#!/bin/bash

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

echo "Creating directory for PiWave WebGUI..."
CLONE_DIR="$HOME/piwave-webgui"
REPO_URL="https://github.com/douxxu/piwave-webgui"

if [ ! -d "$CLONE_DIR" ]; then
  mkdir -p "$CLONE_DIR"
  check_status "Creating directory $CLONE_DIR"
else
  echo "Directory $CLONE_DIR already exists. Skipping creation."
fi

echo "Installing Flask..."
sudo pip install flask --break-system-packages
check_status "Installing PiWave"

echo "Cloning PiWave WebGUI repository into $CLONE_DIR..."
git clone "$REPO_URL" "$CLONE_DIR"
check_status "Cloning PiWave WebGUI repository"

echo "Creating aliases in .bashrc..."

if [ -f "$HOME/.bashrc" ]; then
    echo -e "\n# PiWave WebGUI Aliases" >> ~/.bashrc
    echo "alias pw-webgui='sudo python3 ${CLONE_DIR}/server.py'" >> ~/.bashrc
    echo "alias pw-webgui-config='nano ${CLONE_DIR}/piwave.conf'" >> ~/.bashrc
    check_status "Appending aliases to .bashrc"

    source ~/.bashrc
else
    echo -e "\e[31mError: ~/.bashrc not found. Please create it manually.\e[0m"
    exit 1
fi

echo "Setup ended. You can now use the following commands:"
echo "  - pw-webgui: Start the PiWave WebGUI server."
echo "  - pw-webgui-config: Edit the PiWave configuration file."

echo "The repository was cloned into $CLONE_DIR."
