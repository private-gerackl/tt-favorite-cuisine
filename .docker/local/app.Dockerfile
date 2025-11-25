FROM python:3.13-slim AS base
ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    APP_VERSION=0.1.0-local
WORKDIR /app_dir

FROM base AS builder


RUN pip install --upgrade "uv>=0.7,<1.0" && rm -rf /root/.cache/*
ADD pyproject.toml uv.lock ./
RUN uv sync --no-install-project --verbose --no-progress

FROM base AS final

COPY --from=builder /app_dir/.venv ./.venv
ADD app ./app/
ENTRYPOINT ["/app_dir/.venv/bin/python3", "-m", "app.main"]
