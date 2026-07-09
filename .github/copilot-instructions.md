# Copilot instructions — python-service-template

This is a **uv**-managed Python 3.13 FastAPI service (hatchling build backend, ruff, pytest). Follow these conventions.

## Package manager — uv only
- Use **uv** exclusively. The lockfile is `uv.lock`.
- **Never** run bare `pip install` into the repo and **never** commit `requirements.txt` or `Pipfile`. Manage dependencies with `uv add` / `uv sync`.

## Commands
- `uv sync` — install / sync dependencies
- `uv run uvicorn template_pkg.main:app --reload` — run the service locally
- `uv run ruff check` — lint
- `uv run pytest` — run tests (`asyncio_mode = auto`)

## Scope discipline
- Change **only** what the issue explicitly asks for. Keep the diff minimal — no unrelated files, dependencies, or refactors.

## Versioning
- `[project].version` in `pyproject.toml` MUST be a PEP 440 string (e.g. `0.0.1a1`, not `0.0.1-test.1`) — `uv lock` rejects non-conformant values.

## Template placeholders
- `TEMPLATE_PKG` and `TEMPLATE_DESCRIPTION` are intentional placeholders. Do **not** replace them unless the task explicitly asks.
