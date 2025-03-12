#!/bin/bash

# Determine Python command to use (python3 or python)
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    PIP_CMD="pip3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
    PIP_CMD="pip"
else
    echo "Error: Neither python3 nor python was found"
    exit 1
fi

echo "Using Python command: $PYTHON_CMD"

# Determine if we can create a virtual environment or if we should install globally
USE_VENV=true

# Try to create virtual environment, skip if it fails
if [ ! -d ".venv" ]; then
    echo "Attempting to create virtual environment..."
    $PYTHON_CMD -m venv .venv 2>/dev/null || {
        echo "Warning: Unable to create virtual environment. Will install dependencies globally."
        USE_VENV=false
    }
fi

# Activate virtual environment if created successfully
if [ "$USE_VENV" = true ] && [ -d ".venv" ]; then
    echo "Activating virtual environment..."
    source .venv/bin/activate 2>/dev/null || {
        echo "Warning: Unable to activate virtual environment. Will install dependencies globally."
        USE_VENV=false
    }
    PIP_CMD="pip"  # Use pip from virtual environment if activated
fi

# Check if pip is available
if ! command -v $PIP_CMD &> /dev/null; then
    if command -v pip3 &> /dev/null; then
        PIP_CMD="pip3"
    elif command -v pip &> /dev/null; then
        PIP_CMD="pip"
    else
        echo "Error: No pip command found. Cannot install dependencies."
        exit 1
    fi
fi

echo "Using pip command: $PIP_CMD"

# Install dependencies
echo "Installing development dependencies..."
$PIP_CMD install --upgrade pip
$PIP_CMD install -r dev-requirements.txt

# Install the package in development mode
echo "Installing the package in development mode..."
$PIP_CMD install -e .

# Print completion message
echo "Setup complete!"
if [ "$USE_VENV" = true ]; then
    echo "You can activate the virtual environment with: source .venv/bin/activate"
fi
