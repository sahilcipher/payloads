#!/bin/bash

# Ensure cmatrix and sox (Sound eXchange) are installed
if ! command -v cmatrix &> /dev/null; then
    echo "cmatrix is not installed. Installing..."
    sudo apt-get install cmatrix -y
fi

if ! command -v play &> /dev/null; then
    echo "Sox (Sound eXchange) is not installed. Installing..."
    sudo apt-get install sox -y
fi

# Function to clean up on exit
cleanup() {
    pkill -f "sox -n synth" 2>/dev/null  # Kill any running sound process
    clear
    echo "Hacker Matrix Stopped!"
}

# Run cleanup on script exit
trap cleanup EXIT

# Play the hacker/virus sound in the background (separate process)
(while true; do play -n synth 5 sine 20-200 gain -10 vol 0.3; done) >/dev/null 2>&1 &

# Run cmatrix with red color (Hacker Style)
cmatrix -C red -s -u 5
