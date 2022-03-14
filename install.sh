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

if command_exists teknorm; then
    cd ~/.teknorm
    git remote update > /dev/null
    if [ "$(git status --porcelain)" ]; then
        git pull --rebase --quiet
    fi
    exit 0
fi

# Clone TekNorm repository in the home directory
cd ~
git clone --quiet https://github.com/Thibb1/TekNorm.git
mv TekNorm .teknorm

# Install TekNorm
cd .teknorm
make install

# Fancy message to the user in blue
echo "\033[1;34m _____     _   _____                \033[0m"
echo "\033[1;34m|_   _|___| |_|   | |___ ___ _____  \033[0m"
echo "\033[1;34m  | | | -_| '_| | | | . |  _|     | \033[0m"
echo "\033[1;34m  |_| |___|_,_|_|___|___|_| |_|_|_| \033[0m"
echo "\033[1;34m                                    \033[0m"

echo "TekNorm has been installed successfully."
echo "Run 'teknorm'"