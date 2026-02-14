#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.12"
# dependencies = ["jinja2"]
# ///
"""Install dotfiles into user's home directory."""

import argparse
import difflib
import shutil
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

DOTFILES_DIR = Path(__file__).resolve().parent

FILES = [
    {"src": "zshrc", "dest": "~/.zshrc", "link": False},
    {"src": "zsh", "dest": "~/.zsh"},
    {"src": "gitconfig.j2", "dest": "~/.gitconfig", "template": True},
    {"src": "gitconfig.local.j2", "dest": "~/.gitconfig.local", "template": True},
    {"src": "gitignore", "dest": "~/.gitignore"},
    {"src": "ackrc", "dest": "~/.ackrc"},
    {"src": "irbrc", "dest": "~/.irbrc"},
    {"src": "hgrc", "dest": "~/.hgrc"},
    {"src": "tmux.conf", "dest": "~/.tmux.conf"},
    {"src": "gdbinit", "dest": "~/.gdbinit"},
    {"src": "nvim", "dest": "~/.config/nvim"},
    {"src": "fish", "dest": "~/.config/fish"},
]

jinja_env = Environment(
    loader=FileSystemLoader(DOTFILES_DIR),
    keep_trailing_newline=True,
)


def render_template(src_name):
    template = jinja_env.get_template(src_name)
    return template.render(
        vim=shutil.which("vim"),
        delta=shutil.which("delta"),
    )


def file_content(path):
    return path.read_text()


def save_file(dest, content):
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(content)


def install_link(src, dest, dry=False):
    if dest.exists() or dest.is_symlink():
        if dest.is_symlink() and dest.resolve() == src.resolve():
            print(f"identical symlink {dest}")
            return
        if dry:
            print(f"would overwrite {dest} with symlink")
            return
        print(f"overwrite {dest} with symlink")
        link_file(src, dest)
    else:
        print(f"{'would create' if dry else 'create'} symlink {dest}")
        if not dry:
            link_file(src, dest)


def link_file(src, dest):
    if dest.exists() or dest.is_symlink():
        if dest.is_dir() and not dest.is_symlink():
            shutil.rmtree(dest)
        else:
            dest.unlink()
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.symlink_to(src.resolve())


def install_copy(src_name, dest, template=False, dry=False, skip=False):
    new_content = render_template(src_name) if template else file_content(DOTFILES_DIR / src_name)

    if dest.exists():
        old_content = file_content(dest)
        if new_content == old_content:
            print(f"identical {dest}")
            return
        diff = difflib.unified_diff(
            old_content.splitlines(keepends=True),
            new_content.splitlines(keepends=True),
            fromfile=str(dest),
            tofile=src_name,
        )
        print("".join(diff), end="")
        if skip:
            print(f"skip {dest} (use --include-gitconfig-local to overwrite)")
            return
        if dry:
            return
        print(f"overwrite {dest}")
        save_file(dest, new_content)
    else:
        print(f"{'would create' if dry else 'create'} {dest}")
        if not dry:
            save_file(dest, new_content)


def main():
    parser = argparse.ArgumentParser(description="Install dotfiles")
    parser.add_argument("--force", action="store_true", help="apply changes (default is dry run)")
    parser.add_argument("--skip-gitconfig", action="store_true", help="skip gitconfig installation")
    parser.add_argument("--include-gitconfig-local", action="store_true", help="overwrite gitconfig.local even if it exists")
    args = parser.parse_args()

    dry = not args.force

    if dry:
        print("dry run (use --force to apply changes)")

    for entry in FILES:
        if args.skip_gitconfig and entry["src"].startswith("gitconfig"):
            continue
        src_name = entry["src"]
        dest = Path(entry["dest"].replace("~", str(Path.home())))
        link = entry.get("link", True)
        template = entry.get("template", False)

        # Special handling for gitconfig.local: only update if file doesn't exist or --include-gitconfig-local is set
        skip_gitconfig_local = (src_name == "gitconfig.local.j2" and dest.exists() and not args.include_gitconfig_local)

        if not link or template:
            install_copy(src_name, dest, template=template, dry=dry, skip=skip_gitconfig_local)
        else:
            install_link(DOTFILES_DIR / src_name, dest, dry=dry)


if __name__ == "__main__":
    main()
