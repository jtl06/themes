# Wheatgrass Themes

Personal Wheatgrass-inspired themes for VS Code and Oh My Zsh.

The colors are based on GNU Emacs' `wheatgrass-theme.el`: wheat foreground, SpringGreen comments, turquoise constants, pale-green functions, dark-khaki strings, aquamarine types, yellow-green variables, and salmon/orange diagnostics.

## Layout

```text
omz/      Oh My Zsh theme
vscode/   VS Code color theme extension
install.sh
```

## Install

```sh
./install.sh
```

By default this installs the OMZ theme and the VS Code theme. It does not edit `~/.zshrc`.

Useful options:

```sh
./install.sh --all      # install themes and set ZSH_THEME="wheatgrass"
./install.sh --omz
./install.sh --vscode
./install.sh --zshrc
./install.sh --fonts
```

## Oh My Zsh

Enable manually with:

```zsh
ZSH_THEME="wheatgrass"
```

Prompt features:

- dynamic `user@host`
- SSH marker
- git branch/status/ahead-behind
- Python virtualenv indicator
- slow command duration
- root/error prompt coloring

## VS Code

After install, reload VS Code and select:

```text
Wheatgrass
```
