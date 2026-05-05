# syntax=docker/dockerfile:1.7
FROM python:3.13-slim AS builder
COPY --from=ghcr.io/astral-sh/uv:0.5.0 /uv /usr/local/bin/uv
WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev
COPY src ./src
RUN uv pip install --no-deps -e .

FROM python:3.13-slim
COPY --from=builder /app /app
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
WORKDIR /app
EXPOSE 8080
CMD ["uvicorn", "template_pkg.main:app", "--host", "0.0.0.0", "--port", "8080"]
