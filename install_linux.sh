#!/bin/bash
set -e

SERVICE_NAME="file-sweeper"
SCRIPT_DIR="$HOME/.config/file-sweeper"
VENV="$SCRIPT_DIR/.venv"
PYTHON="$VENV/bin/python"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

echo "Setting up virtual environment..."
cd "$SCRIPT_DIR"

if [[ ! -d "$VENV" ]]; then
  python3 -m venv .venv
fi

echo "Installing Python dependencies..."
"$VENV/bin/pip" install --upgrade pip
"$VENV/bin/pip" install -r requirements.txt

sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=File Sweeper Service
After=network.target

[Service]
ExecStart=$PYTHON $SCRIPT_DIR/main.py
WorkingDirectory=$SCRIPT_DIR
Restart=always
User=$USER
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl restart "$SERVICE_NAME"

echo "Linux install complete!"
