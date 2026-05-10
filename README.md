# Wheatgrass Themes

Personal Wheatgrass-inspired themes for VS Code and Oh My Zsh.

The colors are based on GNU Emacs' `wheatgrass-theme.el`: wheat foreground, SpringGreen comments, turquoise constants, pale-green functions, dark-khaki strings, aquamarine types, yellow-green variables, and salmon/orange diagnostics.

## Layout

```text
omz/      Oh My Zsh theme
vscode/   VS Code color theme extension
fonts/    Bundled Ioskeley Mono core faces
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

The bundled font subset includes only the normal-width, unhinted core faces:

```text
IoskeleyMono-Regular.ttf
IoskeleyMono-Italic.ttf
IoskeleyMono-Bold.ttf
IoskeleyMono-BoldItalic.ttf
```

The full upstream release also includes hinted duplicates, condensed and semi-condensed widths, and extra weights such as Thin, Light, Medium, SemiBold, ExtraBold, and Black. Those are useful for full font packaging, but unnecessary for this theme repo.

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
