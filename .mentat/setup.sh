#!/bin/bash

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python -m venv .venv
fi

# Activate virtual environment
source .venv/bin/activate

# Install dependencies
echo "Installing development dependencies..."
pip install -r dev-requirements.txt

# Install the package in development mode
echo "Installing the package in development mode..."
pip install -e .

echo "Setup complete. You can activate the virtual environment with:"
echo "source .venv/bin/activate"
