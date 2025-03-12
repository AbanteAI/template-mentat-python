#!/bin/bash

# Try to activate virtual environment, but don't fail if it doesn't exist
if [ -d ".venv" ]; then
    source .venv/bin/activate 2>/dev/null || echo "Warning: Virtual environment exists but could not be activated"
fi

# Determine Python command to use (python3 or python)
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "Warning: No Python command found. Will try to run tools directly."
    PYTHON_CMD=""
fi

# Find appropriate commands for our tools
RUFF_CMD="ruff"
PYRIGHT_CMD="pyright"

# Check if ruff is available
if ! command -v $RUFF_CMD &> /dev/null; then
    echo "Warning: ruff not found in PATH"
    # Try to run with python module
    if [ -n "$PYTHON_CMD" ] && $PYTHON_CMD -m ruff --version &> /dev/null; then
        echo "Found ruff as Python module"
        RUFF_CMD="$PYTHON_CMD -m ruff"
    elif command -v python3 -m ruff &> /dev/null; then
        echo "Found ruff as Python3 module"
        RUFF_CMD="python3 -m ruff"
    elif command -v python -m ruff &> /dev/null; then
        echo "Found ruff as Python module"
        RUFF_CMD="python -m ruff"
    else
        echo "Error: ruff not found. Run setup.sh first."
        exit 1
    fi
fi

# Check if pyright is available
if ! command -v $PYRIGHT_CMD &> /dev/null; then
    echo "Warning: pyright not found in PATH"
    # Try to run with npx
    if command -v npx &> /dev/null; then
        if npx --no-install pyright --version &> /dev/null; then
            echo "Found pyright via npx"
            PYRIGHT_CMD="npx --no-install pyright"
        else
            # Try with global installation
            echo "Error: pyright not found. Run setup.sh first."
            exit 1
        fi
    else
        echo "Error: pyright not found and npx not available. Run setup.sh first."
        exit 1
    fi
fi

# Format code with ruff
echo "Formatting code with ruff..."
$RUFF_CMD format . || {
    echo "Warning: Ruff formatting failed, continuing with other checks"
}

# Fix linting issues with ruff
echo "Running ruff linter with automatic fixes..."
$RUFF_CMD check --fix . || {
    echo "Warning: Ruff linting failed, continuing with other checks"
}

# Run type checking with pyright
echo "Running type checking with pyright..."
$PYRIGHT_CMD || {
    echo "Warning: Pyright type checking failed"
    # Don't fail the script on type checking issues, just warn
}

# Tests are run in CI, so we don't need to run them here
# If you need to run tests locally, uncomment the line below
# pytest
