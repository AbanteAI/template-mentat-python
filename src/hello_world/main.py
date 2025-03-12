"""A simple hello world program."""


def hello_world() -> str:
    """Return hello world string."""
    return "Hello, World!"


def main() -> None:
    """Print hello world message."""
    print(hello_world())


if __name__ == "__main__":
    main()
