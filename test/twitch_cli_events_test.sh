#!/bin/zsh

# Start the Twitch event websocket server
twitch event websocket start-server &

# Function to trigger events
trigger_events() {
  while true; do
    # Trigger channel prediction begin event
    twitch event trigger channel.prediction.begin --transport=websocket
    # Trigger hype train begin event
    twitch event trigger channel.hype_train.begin --transport=websocket
    # Trigger channel poll begin event again
    twitch event trigger channel.poll.begin --transport=websocket
    # Wait for 5 seconds before the next iteration
    sleep 5
  done
}

# Execute the trigger events function
trigger_events