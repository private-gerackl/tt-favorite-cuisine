set windows-shell := ["pwsh.exe", "-c"]
set dotenv-filename := ".env"

APP_DIR := "app"
DOCKER_DIR := ".docker"

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

up environment="local":
    docker compose \
        -f {{ DOCKER_DIR }}/{{ environment }}/docker-compose.yml \
        --env-file {{ DOCKER_DIR }}/{{ environment }}/docker.compose.variables.env \
        up \
        --build \
        --remove-orphans
