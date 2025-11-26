#!/bin/bash
set -e

SERVICE_NAME="file-sweeper"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"
SCRIPT_DIR="$HOME/.config/file-sweeper"
SCRIPT_PATH="$SCRIPT_DIR/main.py"

# Create systemd service
sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=File Sweeper Service
After=network.target

[Service]
ExecStart=$(which python3) $SCRIPT_PATH
WorkingDirectory=$SCRIPT_DIR
Restart=always
User=$USER
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
EOF

# Install service
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl restart $SERVICE_NAME

echo "Linux installation complete!"
echo "File Sweeper is now running and will start on every boot."
