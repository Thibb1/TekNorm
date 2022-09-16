#!/usr/bin/env bash
# TekNorm installation script
# Author: Thibb1

command_exists() { command -v "$@" > /dev/null 2>&1 }
green() { printf "\033[32m${1}\033[0m\n\n"; }
blue() { printf "\033[38;5;27m${1}\033[0m\n" ; }
red() { printf "\033[38;5;196m${1}\033[0m\n"; }

if ! command_exists git; then
    red "Git is not installed. Please install it before continuing."
    exit 1
fi

if ! command_exists make; then
    red "Make is not installed. Please install it before continuing."
    exit 1
fi

if ! command_exists perl; then
    red "Perl is not installed. Please install it before continuing."
    exit 1
fi

if command_exists teknorm; then
    cd ~/.teknorm
    git fetch -q
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    if [ $LOCAL != $REMOTE ]; then
        git pull --rebase --quiet
        green "TekNorm has been updated."
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

blue " _____     _   _____                "
blue "|_   _|___| |_|   | |___ ___ _____  "
blue "  | | | -_| '_| | | | . |  _|     | "
blue "  |_| |___|_,_|_|___|___|_| |_|_|_| "
blue "                                    "

green "TekNorm has been installed successfully."
green "Run 'teknorm'"
