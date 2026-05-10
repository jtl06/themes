#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
OMZ_THEME_SRC="$ROOT_DIR/omz/wheatgrass.zsh-theme"
OMZ_THEME_DST="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/wheatgrass.zsh-theme"
VSCODE_SRC="$ROOT_DIR/vscode"
VSCODE_EXT_DST="$HOME/.vscode/extensions/jacenli.wheatgrass-theme-0.0.1"
ZSHRC="$HOME/.zshrc"

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  --all             Install OMZ theme, VS Code theme, and update ~/.zshrc.
  --omz             Install the Oh My Zsh theme.
  --vscode          Install the VS Code theme by copying into ~/.vscode/extensions.
  --zshrc           Set ZSH_THEME="wheatgrass" in ~/.zshrc.
  --fonts           Install bundled Ioskeley Mono fonts into ~/Library/Fonts on macOS.
  --help            Show this help.

With no options, installs OMZ and VS Code themes but does not edit ~/.zshrc.
EOF
}

install_omz() {
  if [ ! -f "$OMZ_THEME_SRC" ]; then
    echo "missing OMZ theme: $OMZ_THEME_SRC" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$OMZ_THEME_DST")"
  cp "$OMZ_THEME_SRC" "$OMZ_THEME_DST"
  echo "installed OMZ theme -> $OMZ_THEME_DST"
}

install_vscode() {
  if [ ! -f "$VSCODE_SRC/package.json" ]; then
    echo "missing VS Code theme package: $VSCODE_SRC" >&2
    exit 1
  fi

  mkdir -p "$HOME/.vscode/extensions"
  rm -rf "$VSCODE_EXT_DST"
  cp -R "$VSCODE_SRC" "$VSCODE_EXT_DST"
  echo "installed VS Code theme -> $VSCODE_EXT_DST"
  echo "reload VS Code and select theme: Wheatgrass"
}

install_fonts() {
  if [ "$(uname -s)" != "Darwin" ]; then
    echo "font install is currently macOS-only; skipping"
    return
  fi

  FONT_DIR="$ROOT_DIR/fonts/IoskeleyMono/Normal/Unhinted"
  if [ ! -d "$FONT_DIR" ]; then
    echo "missing extracted Ioskeley Mono fonts: $FONT_DIR" >&2
    echo "download/extract IoskeleyMono.zip first, or skip --fonts" >&2
    exit 1
  fi

  mkdir -p "$HOME/Library/Fonts"
  cp "$FONT_DIR"/*.ttf "$HOME/Library/Fonts/"
  echo "installed Ioskeley Mono fonts -> $HOME/Library/Fonts"
}

update_zshrc() {
  if [ ! -f "$ZSHRC" ]; then
    touch "$ZSHRC"
  fi

  backup="$ZSHRC.wheatgrass.bak"
  cp "$ZSHRC" "$backup"

  if grep -q '^ZSH_THEME=' "$ZSHRC"; then
    tmp="${ZSHRC}.tmp"
    sed 's/^ZSH_THEME=.*/ZSH_THEME="wheatgrass"/' "$ZSHRC" > "$tmp"
    mv "$tmp" "$ZSHRC"
  else
    printf '\nZSH_THEME="wheatgrass"\n' >> "$ZSHRC"
  fi

  echo "updated $ZSHRC"
  echo "backup written -> $backup"
  echo "reload with: source ~/.zshrc"
}

DO_OMZ=0
DO_VSCODE=0
DO_ZSHRC=0
DO_FONTS=0

if [ "$#" -eq 0 ]; then
  DO_OMZ=1
  DO_VSCODE=1
fi

while [ "$#" -gt 0 ]; do
  case "$1" in
    --all)
      DO_OMZ=1
      DO_VSCODE=1
      DO_ZSHRC=1
      ;;
    --omz)
      DO_OMZ=1
      ;;
    --vscode)
      DO_VSCODE=1
      ;;
    --zshrc)
      DO_ZSHRC=1
      ;;
    --fonts)
      DO_FONTS=1
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

[ "$DO_OMZ" -eq 1 ] && install_omz
[ "$DO_VSCODE" -eq 1 ] && install_vscode
[ "$DO_FONTS" -eq 1 ] && install_fonts
[ "$DO_ZSHRC" -eq 1 ] && update_zshrc
