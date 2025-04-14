#!/bin/zsh

# Launch OBS Studio
open -a "OBS" &

# Run ngrok on port 4455 in the background
ngrok http 4455 &