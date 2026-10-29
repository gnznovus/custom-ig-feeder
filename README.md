# Custom IG Feeder — native-first POC

Reproducible WordPress lab for validating **Meta Embeds** against Hotel Indigo Bangkok Thonglor's manually curated Instagram requirements. No custom plugin is included in this phase.

## Requirements

- Docker Desktop / Docker Engine with Compose v2
- Bash (Git Bash or WSL on Windows)
- Internet access for WordPress, the plugin registry, Meta oEmbed, and Instagram embed scripts
- Free local port `8086` (override in `.env`)

## Start

```bash
cp .env.example .env
# Edit .env: replace all CHANGE_ME values, especially admin password.
bash scripts/bootstrap.sh
```

Open `http://localhost:8086` (or `WP_URL` from .env). Admin credentials are those in your local .env.

## Verify

```bash
bash scripts/verify.sh
docker compose logs --tail=100 wordpress
```

Bootstrap is repeatable: it does not overwrite an installed WordPress site, and test pages are updated by slug. Database and WordPress data live in named Docker volumes; `docker compose down` keeps them. **Do not use `down -v` unless deliberately destroying local data.**

## Tests

- `tests/fixtures/`: WordPress block-content fixture pages, including the client's exact URL with `?img_index=2`.
- `tests/acceptance.md`: POC-01–10 and evidence rules.
- `docs/results.md`: Record real browser results; nothing is pre-marked PASS.
- `docs/environment.md`: Record tested versions, known limitations, and reproduction notes.

Use the editor and published frontend. Inspect browser console, Network and carousel interaction. Compare the client URL with/without `img_index=2`. WordPress autoembed markup and Meta third-party scripts may behave differently in real frontend conditions.

## Boundaries

- Meta Embeds 1.2.2 is the sole embed provider under test.
- No paid plugins, scraping, custom media extraction, or curator component.
- Local success is *provisional* until reproduced on Hotel Indigo staging.
- Docker environment is a POC lab, **not** a production deployment artifact.
- Version tags are explicit for reproducibility; record image digests after first successful pull.
