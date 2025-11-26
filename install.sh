#!/bin/bash

OS="$(uname)"

if [[ "$OS" == "Linux" ]]; then
  ./install_linux.sh
elif [[ "$OS" == "Darwin" ]]; then
  ./install_macos.sh
else
  echo "Unsupported OS: $OS"
  exit 1
fi
