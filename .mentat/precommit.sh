#!/bin/bash

# Activate virtual environment if it exists
if [ -d ".venv" ]; then
    source .venv/bin/activate
fi

# Format code with ruff
echo "Formatting code with ruff..."
ruff format .

# Fix linting issues with ruff
echo "Running ruff linter with automatic fixes..."
ruff check --fix .

# Run type checking with pyright
echo "Running type checking with pyright..."
pyright

# Tests are run in CI, so we don't need to run them here
# If you need to run tests locally, uncomment the line below
# pytest
