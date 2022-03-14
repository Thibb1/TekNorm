#!/usr/bin/env bash
# TekNorm installation script
# Author: Thibb1

set -e

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

if ! command_exists git; then
    echo "Git is not installed. Please install it before continuing."
    exit 1
fi

if ! command_exists make; then
    echo "Make is not installed. Please install it before continuing."
    exit 1
fi

if ! command_exists perl; then
    echo "Perl is not installed. Please install it before continuing."
    exit 1
fi

if command_exists teknorm; then
    cd ~/.teknorm
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    if [ $LOCAL != $REMOTE ]; then
        echo "TekNorm is already installed but not up to date. Please update it before continuing."
        git pull --rebase --quiet
        sudo make re
        echo "TekNorm has been updated."
    fi
    exit 0
fi

# Clone TekNorm repository in the home directory
cd ~
git clone --quiet https://github.com/Thibb1/TekNorm.git
mv TekNorm .teknorm

# Install TekNorm
cd .teknorm
sudo make install

# Fancy message to the user in blue
echo -e "\033[1;34m _____     _   _____                \033[0m"
echo -e "\033[1;34m|_   _|___| |_|   | |___ ___ _____  \033[0m"
echo -e "\033[1;34m  | | | -_| '_| | | | . |  _|     | \033[0m"
echo -e "\033[1;34m  |_| |___|_,_|_|___|___|_| |_|_|_| \033[0m"
echo -e "\033[1;34m                                    \033[0m"

echo -e "TekNorm has been installed successfully."
echo -e "Run 'teknorm'"