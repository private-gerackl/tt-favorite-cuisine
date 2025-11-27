FROM python:3.13-slim

RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir alembic psycopg2-binary sqlalchemy pydantic-settings

COPY alembic.ini .
COPY alembic_migrations ./alembic_migrations
COPY ./app/integrations/postgresql/models.py ./app/integrations/postgresql/models.py
CMD ["alembic", "upgrade", "head"]
