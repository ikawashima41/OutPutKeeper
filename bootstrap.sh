#!/bin/sh
# Script to build this project

# setup Gems, Brews and Mints
echo "Install Gems and Brews"
bundle install
brew bundle

# install dependencies via CocoaPods
echo "Install dependencies via CocoaPods"
pod install

# set projectname
open OutPutKeeper.xcworkspace
