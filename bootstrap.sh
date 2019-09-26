#!/bin/sh
# Script to build this project

# setup Gems, Brews and Mints
echo "Install Gems and Brews"
bundle install
brew bundle

# install dependencies via Carthage
echo "Install dependencies via Carthage"
carthage update --platform iOS

# set projectname
open OutPutKeeper.xcworkspace
