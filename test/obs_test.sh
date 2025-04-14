#!/bin/zsh

# Launch OBS Studio
open -a "OBS" &

# Run ngrok in a new terminal window
osascript -e 'tell app "Terminal" to do script "ngrok http 4455"'