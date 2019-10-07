# Dotfiles

My personal config files for everyone to use. Sadly this repo gets frequent commits. 😌😉

```
  ▓▓▓▓▓▓▓▓▓▓
 ░▓ About  ▓ The configuration files for NeoVim, Tmux, ZSH
 ░▓ Author ▓ Evan N <dacsang97@gmail.com>
 ░▓ Code   ▓ https://github.com/dacsang97/dotfiles
 ░▓▓▓▓▓▓▓▓▓▓
 ░░░░░░░░░░
```

## Requirements

For installation `git` is must.

Powerline patched fonts are required for glyphs. I'll recommend [Nerd Fonts](https://www.nerdfonts.com/).

## Setup

Clone this project

```
git clone https://github.com/dacsang97/dotfiles
cd dotfiles
```

Installation

```
chmod +x install.sh
./install.sh --macos // Currently, this option is support macOS only.
```

Link dotfiles

```
./install.sh --dotfiles
```

In `Neovim` run:

```
:PlugClean
```

And follow its steps.
After, in `NeoVim` run:

```
:PlugInstall
```

> If you want to get newest version of `NeoVim` plugin, in `NeoVim` simply run: `:PlugUpdate`
