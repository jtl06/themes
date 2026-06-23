#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
COLOR_SRC="$ROOT_DIR/Wheatgrass.itermcolors"
PROFILE_SRC="$ROOT_DIR/profile/WG.json"
COLOR_DST="$HOME/Library/Application Support/iTerm2/ColorPresets/Wheatgrass.itermcolors"
PROFILE_DST="$HOME/Library/Application Support/iTerm2/DynamicProfiles/Wheatgrass-WG.json"
DOMAIN="com.googlecode.iterm2"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "iTerm2 profile install is macOS-only" >&2
  exit 1
fi

if pgrep -x "iTerm2" >/dev/null 2>&1; then
  echo "quit iTerm2 before installing its profile and preferences" >&2
  exit 1
fi

mkdir -p "$(dirname "$COLOR_DST")" "$(dirname "$PROFILE_DST")"
cp "$COLOR_SRC" "$COLOR_DST"
cp "$PROFILE_SRC" "$PROFILE_DST"

defaults write "$DOMAIN" AppleWindowTabbingMode -string "manual"
defaults write "$DOMAIN" "Default Bookmark Guid" -string "F014114C-3F15-47CC-B0C6-2C98C3D01846"
defaults write "$DOMAIN" EnableDivisionView -bool false
defaults write "$DOMAIN" FocusFollowsMouse -bool false
defaults write "$DOMAIN" HideScrollbar -bool false
defaults write "$DOMAIN" HideTab -bool false
defaults write "$DOMAIN" OpenTmuxWindowsIn -int 0
defaults write "$DOMAIN" PreventEscapeSequenceFromClearingHistory -bool false
defaults write "$DOMAIN" PromptOnQuit -bool true
defaults write "$DOMAIN" QuitWhenAllWindowsClosed -bool true
defaults write "$DOMAIN" SplitPaneDimmingAmount -float 0.4047330411585366
defaults write "$DOMAIN" StatusBarPosition -int 0
defaults write "$DOMAIN" TabStyleWithAutomaticOption -int 5
defaults write "$DOMAIN" TabViewType -int 0
defaults write "$DOMAIN" UseBorder -bool false
defaults write "$DOMAIN" WindowNumber -bool true

echo "installed iTerm2 color preset -> $COLOR_DST"
echo "installed iTerm2 dynamic profile -> $PROFILE_DST"
echo "restart iTerm2, then select profile: WG"
