# dinfuehr dotfiles

## Requirements
You need `zsh` and `git`. These tools are required by the installation script.

## Installation

```sh
cd ~/code/
git clone git@github.com:dinfuehr/dotfiles.git

rake install
```

## Additional Dependencies

**Fedora:**
```sh
sudo dnf install neovim xclip tmux git-delta zsh-syntax-highlighting fzf
```

**eza (Fedora, no package available):**
```sh
cargo install eza
```

**macOS:**
```sh
brew install neovim tmux git-delta eza fzy fzf zsh-syntax-highlighting
```

**Ubuntu:**
```sh
sudo apt install neovim xclip tmux git-delta eza fzy fzf zsh-syntax-highlighting
```

**Nerd Font (required for Neovim icons):**
```sh
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/DejaVuSansMono.tar.xz"
tar xf DejaVuSansMono.tar.xz
rm DejaVuSansMono.tar.xz
fc-cache -fv ~/.local/share/fonts
```
Restart the terminal, then set your terminal font to "DejaVuSansM Nerd Font Mono".

**fzy (Fedora only, build from source):**
```sh
git clone git@github.com:jhawthorn/fzy.git
cd fzy
make
sudo make install
```
