#!/bin/bash

# github.com/douxxu | git.douxx.tech/piwave-webgui
print_magenta() {
  echo -e "\e[35m$1\e[0m"
}

check_status() {
  if [ $? -ne 0 ]; then
    echo -e "\e[31mError: $1 failed\e[0m"
    exit 1
  fi
}

print_magenta "
  ____            __        __   _      ____ _   _ ___ 
 |  _ \\__      __ \\ \\      / /__| |__  / ___| | | |_ _|
 | |_) \\ \\ /\\ / /  \\ \\ /\\ / / _ \\ '_ \\| |  _| | | || | 
 |  __/ \\ V  V /    \\ V  V /  __/ |_) | |_| | |_| || | 
 |_|     \\_/\\_/      \\_/\\_/ \\___|_.__/ \\____|\\___/|___|
"

echo "Removing PiWave WebGUI aliases from .bashrc..."
if [ -f "$HOME/.bashrc" ]; then
  sed -i '/# PiWave WebGUI Aliases/,/^$/d' "$HOME/.bashrc"
  check_status "Removing aliases from .bashrc"
else
  echo -e "\e[31mError: ~/.bashrc not found. Cannot remove aliases.\e[0m"
fi

echo "Stopping any running PiWave WebGUI processes..."
sudo pkill -f server.py
check_status "Stopping PiWave WebGUI processes"

echo "Removing PiWave WebGUI directory..."
CLONE_DIR="$HOME/piwave-webgui"
if [ -d "$CLONE_DIR" ]; then
  sudo rm -rf "$CLONE_DIR"
  check_status "Removing $CLONE_DIR"
else
  echo "Directory $CLONE_DIR does not exist. Skipping removal."
fi

echo "Uninstalling Flask..."
sudo pip uninstall -y flask
check_status "Uninstalling Flask"

echo "Removing setup PiWave..."
curl -sSL https://piwave.hs.vc/uninstall/ | sudo bash
check_status "Running PiWave uninstall script"

echo "Uninstallation completed successfully!"
