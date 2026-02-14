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
sudo dnf install neovim xclip tmux git-delta eza zsh-syntax-highlighting
```

**macOS:**
```sh
brew install neovim tmux git-delta eza fzy zsh-syntax-highlighting
```

**Ubuntu:**
```sh
sudo apt install neovim xclip tmux git-delta eza fzy zsh-syntax-highlighting
```

**fzy (Fedora only, build from source):**
```sh
git clone git@github.com:jhawthorn/fzy.git
cd fzy
make
sudo make install
```
