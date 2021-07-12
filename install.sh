#!/bin/bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#

# Notes:
#
# Some apps don't have a cask and so still need to be installed by hand
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

sudo id

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

brew install cask

echo "Installing packages..."
PACKAGES=(
    git
    zsh
    neofetch
    osx-cpu-temp
)
brew install ${PACKAGES[@]}

#Install terminal adds
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

echo "Cleaning up..."
brew cleanup

echo "Installing apps..."
APPS=(
    iterm2
    alfred
    google-drive
    sourcetree
    transmission
    docker
    proxyman
    postman
    spotify
    discord
    slack
    telegram
    vlc
    iconizer
    rectangle
    pdf-expert
    zoom
    vapor
)
brew install ${APPS[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "Bootstrapping complete"
