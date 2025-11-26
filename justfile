set windows-shell := ["pwsh.exe", "-c"]
set dotenv-filename := ".env"

APP_DIR := "app"
TESTS_DIR := "tests"
DOCKER_DIR := ".docker"

# Sum of code checks in one command
[group('ci')]
ci: ruff-fmt ruff-style mypy safety

# Sum of formatter commands in one command
[group('formatting')]
fmt: ruff-fmt ruff-style

# Code formatting
[group('formatting')]
ruff-fmt:
    ruff format {{ APP_DIR }}
    ruff format {{ TESTS_DIR }}

# Code style
[group('formatting')]
ruff-style:
    ruff check --fix --unsafe-fixes {{ APP_DIR }}
    ruff check --fix --unsafe-fixes {{ TESTS_DIR }}

# Sum of lint checks in one command
[group('linting')]
lint: ruff-fmt-check mypy safety

# Check code format by ruff
[group('linting')]
ruff-fmt-check:
    ruff format --check {{ APP_DIR }}
    ruff format --check {{ TESTS_DIR }}

# Check code style by ruff
[group('linting')]
ruff-style-check:
    ruff check {{ APP_DIR }}
    ruff check {{ TESTS_DIR }}

# Check type hints correctness by mypy
[group('linting')]
mypy:
    mypy {{ APP_DIR }}
    mypy {{ TESTS_DIR }}

# Check dependencies vulnerability by safety
[group('linting')]
safety:
    safety --disable-optional-telemetry check --full-report --file uv.lock --ignore 70612

# Up
[group('runtime')]
up environment="local":
    docker compose \
        -f {{ DOCKER_DIR }}/{{ environment }}/docker-compose.yml \
        --env-file {{ DOCKER_DIR }}/{{ environment }}/docker.compose.variables.env \
        up \
        --build \
        --remove-orphans
