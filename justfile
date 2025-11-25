set windows-shell := ["pwsh.exe", "-c"]
set dotenv-filename := ".env"

APP_DIR := "app"

# Sum of code checks in one command
[group('ci')]
ci: ruff-fmt mypy safety bandit

# Sum of formatter commands in one command
[group('formatting')]
fmt: ruff-fmt

# Code formatting
[group('formatting')]
ruff-fmt:
    ruff format {{ APP_DIR }}

# Sum of lint checks in one command
[group('linting')]
lint: ruff mypy safety bandit

# Check project codestyle by ruff
[group('linting')]
ruff:
    ruff format --check {{ APP_DIR }}

# Check type hints correctness by mypy
[group('linting')]
mypy:
    mypy {{ APP_DIR }}

# Check typical network error by bandit
[group('linting')]
bandit:
    bandit -r ./{{ APP_DIR }}

# Check dependencies vulnerability by safety
[group('linting')]
safety:
    safety --disable-optional-telemetry check --full-report --file uv.lock --ignore 70612
