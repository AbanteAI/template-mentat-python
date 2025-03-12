#!/bin/bash

# Determine Python command to use (python3 or python)
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "Error: Neither python3 nor python was found"
    exit 1
fi

echo "Using Python command: $PYTHON_CMD"

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    $PYTHON_CMD -m venv .venv
fi

# Activate virtual environment
source .venv/bin/activate

# Install dependencies
echo "Installing development dependencies..."
pip install --upgrade pip
pip install -r dev-requirements.txt

# Install the package in development mode
echo "Installing the package in development mode..."
pip install -e .

echo "Setup complete. You can activate the virtual environment with:"
echo "source .venv/bin/activate"
