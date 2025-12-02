#!/bin/bash

# Open ChatGPT in a new window
firefox --new-window "https://chat.openai.com" &

sleep 1

# Open Gemini in another new window
firefox --new-window "https://gemini.google.com" &

sleep 1

# Open a blank Firefox window (or your homepage)
firefox --new-window "about:blank" &
