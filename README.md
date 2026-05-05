# TEMPLATE_PKG

TEMPLATE_DESCRIPTION

Built on FastAPI 0.118 + uv + hatchling + ruff (Python 3.13).

## Local dev

```bash
uv sync
uv run uvicorn template_pkg.main:app --reload
curl http://localhost:8000/health
```

## Tests & lint

```bash
uv run ruff check
uv run pytest
```

## Versioning (PEP 440)

`pyproject.toml` `[project].version` MUST be a [PEP 440](https://peps.python.org/pep-0440/) string. `uv lock` rejects non-conformant values (e.g. `0.0.1-test.1`).

Examples accepted by `uv` and PyPI:

| Stage          | Example      |
| -------------- | ------------ |
| Pre-release    | `0.0.1a1`    |
| Beta           | `0.1.0b2`    |
| Release cand.  | `0.1.0rc1`   |
| Dev snapshot   | `0.1.0.dev0` |
| Stable         | `1.0.0`      |
| Post-release   | `1.0.0.post1`|

Use `0.0.1a1` (alpha) for the first scaffold cut, NOT `0.0.1-test.1`.

## Deploy

Two reusable workflows publish on tag push (`v<major>.<minor>.<patch>`):

- **`.github/workflows/deploy.yml`** — `flyctl deploy --remote-only` (Fly.io)
- **`.github/workflows/docker-publish.yml`** — calls `eps-ai-solutions/.github/.github/workflows/docker-publish.yml@main`, multi-arch image to `ghcr.io/eps-ai-solutions/<repo-name>:<version>` + `:latest`

Cut a release:

```bash
git tag v0.1.0
git push --tags
```

Both workflows trigger in parallel; either can be removed if a target is unused.

## Repo bootstrap (template usage)

Replace placeholders after `gh repo create --template`:

- `TEMPLATE_PKG` — Python package name (snake_case), in `pyproject.toml`, `src/template_pkg/`, `tests/`, `Dockerfile` `CMD`
- `TEMPLATE_DESCRIPTION` — one-line project description
- `TEMPLATE_PKG_NAME` — Fly app name (kebab-case), in `fly.toml.template` → rename to `fly.toml`

Then regenerate the lockfile and verify the build:

```bash
uv lock
uv sync
uv run pytest
docker build -t local/<repo-name>:dev .
docker run --rm local/<repo-name>:dev uvicorn --version
```
