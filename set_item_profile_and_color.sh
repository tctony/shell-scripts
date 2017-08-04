#!/bin/sh

# This script will change your iterm tab color and the background for that tab.

# Requirements
# - iterm as terminal
# - a profile named Prod in iterm. You can configure it how ever you want. A profile can be found in Preferences -> Profiles

# Set window profile ( in my case, Prod profile will make the background red)
echo -e "\033]50;SetProfile=Server\a"

# Set tab color to red
echo -e "\033]6;1;bg;red;brightness;255\a"
