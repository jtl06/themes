# Themes

Personal theme collection for editor, shell, and terminal styling. This repository is not specific to one theme family; each theme should live in its own top-level folder, with shared assets in top-level support folders.

Current theme families:

- `wheatgrass/` - Wheatgrass-inspired VS Code, iTerm2, and Oh My Zsh themes

Future theme families can follow the same pattern:

```text
<theme-name>/
  install.sh
  omz/
  vscode/
  ...
```

## Layout

```text
fonts/       Shared font bundles usable by any theme
wheatgrass/  Wheatgrass-inspired theme family
```

## Wheatgrass

The Wheatgrass colors are based on GNU Emacs' `wheatgrass-theme.el`: wheat foreground, SpringGreen comments, turquoise constants, pale-green functions, dark-khaki strings, aquamarine types, yellow-green variables, and salmon/orange diagnostics.

### Layout

```text
wheatgrass/iterm2/   iTerm2 color preset
wheatgrass/omz/      Oh My Zsh theme
wheatgrass/vscode/   VS Code color theme extension
wheatgrass/install.sh
```

### Install

```sh
cd wheatgrass
./install.sh
```

By default this installs the OMZ theme, the VS Code theme, and the iTerm2 color preset. It does not edit `~/.zshrc`.

Useful options:

```sh
./install.sh --all      # install themes and set ZSH_THEME="wheatgrass"
./install.sh --omz
./install.sh --vscode
./install.sh --iterm2
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

The full upstream release also includes hinted duplicates, condensed and semi-condensed widths, and extra weights such as Thin, Light, Medium, SemiBold, ExtraBold, and Black. Those are useful for full font packaging, but unnecessary for this repo's editor/shell theme use.

### Oh My Zsh

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

### VS Code

After install, reload VS Code and select:

```text
Wheatgrass
```

The theme extension also ships compact UI defaults for a denser workspace:

```json
"breadcrumbs.enabled": true,
"editor.folding": true,
"editor.glyphMargin": true,
"editor.lineDecorationsWidth": 0,
"editor.lineNumbers": "on",
"editor.minimap.enabled": true,
"workbench.activityBar.location": "default",
"workbench.editor.alwaysShowEditorActions": true,
"workbench.editor.editorActionsLocation": "default",
"workbench.editor.showIcons": false,
"workbench.editor.tabCloseButton": "off",
"workbench.editor.tabSizing": "shrink",
"workbench.sideBar.location": "left",
"workbench.tree.indent": 8
```

Many Wheatgrass UI surfaces use alpha colors for a lighter, more translucent feel. VS Code themes cannot force true OS-level window transparency; that requires a separate VS Code transparency/custom CSS extension.

VS Code does not expose a native setting for hover-only sidebars or Activity Bars. That behavior also requires custom CSS or an extension.

### iTerm2

After install, select the color preset in:

```text
Settings > Profiles > Colors > Color Presets > Wheatgrass
```

You can also import `wheatgrass/iterm2/Wheatgrass.itermcolors` manually from iTerm2's color preset menu.
