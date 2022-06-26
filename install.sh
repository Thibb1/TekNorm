#!/usr/bin/env bash
# TekNorm installation script
# Author: Thibb1

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
    git fetch -q
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    if [ $LOCAL != $REMOTE ]; then
        git pull --rebase --quiet
        echo "TekNorm has been updated."
    fi
    exit 0
fi

# Clone TekNorm repository in the home directory
cd /tmp/
rm -rf /tmp/TekNorm
git clone --quiet https://github.com/Thibb1/TekNorm.git
mkdir -p ~/.teknorm
cp -r /tmp/TekNorm/. ~/.teknorm
rm -rf /tmp/TekNorm

# Install TekNorm
cd ~/.teknorm
sudo make re

# Fancy message to the user in blue
echo -e "\033[1;34m _____     _   _____                "
echo "|_   _|___| |_|   | |___ ___ _____  "
echo "  | | | -_| '_| | | | . |  _|     | "
echo "  |_| |___|_,_|_|___|___|_| |_|_|_| "
echo -e "                                    \033[0m"

echo "TekNorm has been installed successfully."
echo "Run 'teknorm'"
