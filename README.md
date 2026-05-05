# TEMPLATE_PKG

TEMPLATE_DESCRIPTION

Built on FastAPI 0.118 + uv + hatchling + ruff (Python 3.13).

## Local dev

```bash
uv sync
uv run uvicorn template_pkg.main:app --reload
curl http://localhost:8000/health
```

## Deploy

Tag a release (`git tag v0.1.0 && git push --tags`) — `Deploy` workflow runs `flyctl deploy --remote-only`.
