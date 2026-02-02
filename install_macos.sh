#!/usr/bin/env bash
set -e

SCRIPT_DIR="$HOME/.config/file-sweeper"
VENV="$SCRIPT_DIR/.venv"
PYTHON="$VENV/bin/python"
PLIST="$HOME/Library/LaunchAgents/com.lcirne.file-sweeper.plist"

echo "Setting up virtual environment..."
cd "$SCRIPT_DIR"

if [[ ! -d "$VENV" ]]; then
  python3 -m venv .venv
fi

echo "Installing Python dependencies..."
"$VENV/bin/pip" install --upgrade pip
"$VENV/bin/pip" install -r requirements.txt

mkdir -p ~/Library/LaunchAgents

cat >"$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.lcirne.file-sweeper</string>
    <key>ProgramArguments</key>
    <array>
        <string>$PYTHON</string>
        <string>$SCRIPT_DIR/main.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>$SCRIPT_DIR</string>
</dict>
</plist>
EOF

launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo "macOS install complete!"
echo ""
echo " ______ _ _             _____                                    __    ")
echo "|  ____(_) |           / ____|                                   | |   ")
echo "| |__   _| | ___ _____| (_____      _____  ___ _ __   ___ _ __   | |   ")
echo "|  __| | | |/ _ \______\___ \ \ /\ / / _ \/ _ \ '_ \ / _ \ '__|  | |   ")
echo "| |    | | |  __/      ____) \ V  V /  __/  __/ |_) |  __/ |   __| |__ ")
echo "|_|    |_|_|\___|     |_____/ \_/\_/ \___|\___| .__/ \___|_|   |/|/|\| ")
echo "                                              | |              |/|\|\| ")
echo "                                              |_|              |/|\|/| ")
