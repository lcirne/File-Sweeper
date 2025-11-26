#!/bin/bash
set -e

# Constants
PLIST="$HOME/Library/LaunchAgents/com.lcirne.file-sweeper.plist"
SCRIPT_DIR="$HOME/.config/file-sweeper"
SCRIPT_PATH="$SCRIPT_DIR/main.py"

mkdir -p ~/Library/LaunchAgents

# Generate plist
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
        <string>$(which python3)</string>
        <string>$SCRIPT_PATH</string>
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

# Load into launchd
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo "macOS installation complete!"
echo "File Sweeper will now run automatically on login."
