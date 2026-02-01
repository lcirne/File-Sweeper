#!/usr/bin/env bash

OS="$(uname)"

if [[ "$OS" == "Linux" ]]; then
  ./install_linux.sh
elif [[ "$OS" == "Darwin" ]]; then
  ./install_macos.sh
else
  echo "Unsupported OS: $OS"
  exit 1
fi

if [[ "$EUID" -eq 0 ]]; then
  echo "❌ Do not run install.sh with sudo"
  exit 1
fi
