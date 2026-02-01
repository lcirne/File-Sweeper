#!/bin/bash
set -e

OS="$(uname)"
SERVICE_NAME="file-sweeper"
PLIST_NAME="com.lcirne.file-sweeper.plist"

echo "Uninstalling File Sweeper startup service..."

if [[ "$OS" == "Darwin" ]]; then
  PLIST="$HOME/Library/LaunchAgents/$PLIST_NAME"

  if [[ -f "$PLIST" ]]; then
    launchctl unload "$PLIST" 2>/dev/null || true
    rm "$PLIST"
    echo "Removed macOS LaunchAgent."
  else
    echo "LaunchAgent not found — nothing to remove."
  fi

elif [[ "$OS" == "Linux" ]]; then
  SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

  if [[ -f "$SERVICE_FILE" ]]; then
    sudo systemctl stop "$SERVICE_NAME" 2>/dev/null || true
    sudo systemctl disable "$SERVICE_NAME" 2>/dev/null || true
    sudo rm "$SERVICE_FILE"
    sudo systemctl daemon-reload
    echo "Removed systemd service."
  else
    echo "Systemd service not found — nothing to remove."
  fi

else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo "Uninstall complete."
echo "Your files remain in ~/.config/file-sweeper"
