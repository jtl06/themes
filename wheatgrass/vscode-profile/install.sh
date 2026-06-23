#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROFILE_NAME="${1:-jtl}"
PROFILE_SRC="$ROOT_DIR/jtl"
CODE_USER_DIR="$HOME/Library/Application Support/Code/User"
STORAGE_FILE="$CODE_USER_DIR/globalStorage/storage.json"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "this profile installer currently supports macOS only" >&2
  exit 1
fi

if ! command -v code >/dev/null 2>&1; then
  echo "missing VS Code CLI: install the 'code' shell command first" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "missing python3, which is required to install profile layout state" >&2
  exit 1
fi

if [ ! -f "$STORAGE_FILE" ]; then
  echo "missing VS Code profile registry: $STORAGE_FILE" >&2
  exit 1
fi

PROFILE_ID=$(python3 - "$STORAGE_FILE" "$PROFILE_NAME" <<'PY'
import json
import sys

storage_path, profile_name = sys.argv[1:3]
with open(storage_path) as file:
    storage = json.load(file)

for profile in storage.get("userDataProfiles", []):
    if profile.get("name") == profile_name:
        print(profile["location"], end="")
        break
PY
)

if [ -z "$PROFILE_ID" ]; then
  echo "VS Code profile '$PROFILE_NAME' does not exist" >&2
  echo "create it from Profiles > New Profile, then rerun this installer" >&2
  exit 1
fi

PROFILE_DST="$CODE_USER_DIR/profiles/$PROFILE_ID"
BACKUP_DIR="$PROFILE_DST/wheatgrass-profile-backup"
STATE_DB="$PROFILE_DST/globalStorage/state.vscdb"

if pgrep -f "Visual Studio Code.app/Contents/MacOS/Electron" >/dev/null 2>&1; then
  echo "quit VS Code before installing profile layout state" >&2
  exit 1
fi

mkdir -p "$BACKUP_DIR"
for file in settings.json keybindings.json; do
  if [ -f "$PROFILE_DST/$file" ]; then
    cp "$PROFILE_DST/$file" "$BACKUP_DIR/$file"
  fi
  cp "$PROFILE_SRC/$file" "$PROFILE_DST/$file"
done

if [ -f "$STATE_DB" ]; then
  cp "$STATE_DB" "$BACKUP_DIR/state.vscdb"
  python3 - "$STATE_DB" "$PROFILE_SRC/layout-state.json" <<'PY'
import json
import sqlite3
import sys

database_path, layout_path = sys.argv[1:3]
with open(layout_path) as file:
    state = json.load(file)["state"]

with sqlite3.connect(database_path) as database:
    database.executemany(
        "INSERT OR REPLACE INTO ItemTable(key, value) VALUES(?, ?)",
        state.items(),
    )
PY
fi

"$ROOT_DIR/../install.sh" --vscode

while IFS= read -r extension; do
  [ -n "$extension" ] || continue
  case "$extension" in
    jacenli.wheatgrass-theme@*)
      continue
      ;;
  esac

  if ! code --profile "$PROFILE_NAME" --install-extension "$extension" --force; then
    if ! code --profile "$PROFILE_NAME" --install-extension "${extension%@*}" --force; then
      echo "warning: could not install ${extension%@*}; it may already be built in" >&2
    fi
  fi
done < "$PROFILE_SRC/extensions.txt"

echo "installed VS Code profile settings -> $PROFILE_DST"
echo "backup written -> $BACKUP_DIR"
echo "reload VS Code and select profile: $PROFILE_NAME"
