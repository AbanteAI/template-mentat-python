# Python Project Template

A simple template for Python projects with basic setup for development and testing.

## Features

- Basic structure with source code in `src/` and tests in `tests/`
- Simple Hello World example
- Testing with pytest
- Code quality tools:
  - Ruff for linting and formatting
  - Pyright for type checking
- CI/CD with GitHub Actions

## Getting Started

### Prerequisites

- Python 3.8 or newer
- pip for package management

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

2. Set up a virtual environment:
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

3. Install development dependencies:
```bash
pip install -r dev-requirements.txt
```

### Running the Program

```bash
python -m src.hello_world.main
```

### Development

Run the tests:
```bash
pytest
```

Check code style and lint:
```bash
ruff check .
ruff format --check .
```

Format code:
```bash
ruff format .
```

Type check with pyright:
```bash
pyright
```

## Project Structure

```
.
├── .github/workflows  # GitHub Actions workflows
├── src/               # Source code
├── tests/             # Test files
├── .gitignore         # Git ignore file
├── dev-requirements.txt  # Development dependencies
├── pyproject.toml     # Project configuration
└── README.md          # This file
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.