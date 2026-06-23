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
wheatgrass/iterm2/   iTerm2 color preset, WG profile, and UI preferences
wheatgrass/omz/      Oh My Zsh theme
wheatgrass/vscode/   VS Code color theme extension
wheatgrass/vscode-profile/  Portable VS Code profile
wheatgrass/install.sh
```

### Install

```sh
cd wheatgrass
./install.sh
```

By default this installs the OMZ theme, the VS Code theme, and the complete iTerm2 `WG` profile. It does not edit `~/.zshrc`.

Useful options:

```sh
./install.sh --all      # install themes and set ZSH_THEME="wheatgrass"
./install.sh --omz
./install.sh --vscode
./install.sh --vscode-profile
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

#### VS Code Profile

The portable `jtl` profile snapshot includes:

- settings and compact layout preferences
- sidebar, panel, Activity Bar, and view visibility/size state
- keybindings
- the extension list with captured versions
- Wheatgrass as the selected color theme
- Ioskeley Mono editor and terminal fonts

Install it into an existing VS Code profile named `jtl`:

```sh
cd wheatgrass
./install.sh --vscode-profile
```

Use a different existing profile name by running:

```sh
./vscode-profile/install.sh <profile-name>
```

Quit VS Code before running the installer. It backs up the destination profile's `settings.json`, `keybindings.json`, and layout database before applying the portable layout keys.

The repository does not contain the raw VS Code database, open editors, recent files, authentication state, workspace history, or unrelated transient window/session state.

### iTerm2

The iTerm2 export includes the complete portable `WG` profile:

- Wheatgrass ANSI and UI colors
- Ioskeley Mono 13
- 6% profile transparency
- background blur with radius 6.22
- 80x30 initial dimensions
- cursor, scrollback, keyboard, spacing, and terminal behavior
- visible tabs and scrollbar
- tab style, split dimming, quit behavior, and window numbering

Install it with:

```sh
cd wheatgrass
./install.sh --iterm2
```

Quit iTerm2 before running the installer. Reopen it afterward, then select:

```text
Settings > Profiles > WG
```

The standalone color preset remains available at `wheatgrass/iterm2/Wheatgrass.itermcolors`.

The export intentionally excludes iTerm2 AI configuration, recent paths, installation identifiers, update history, saved window coordinates, and other transient machine state.
