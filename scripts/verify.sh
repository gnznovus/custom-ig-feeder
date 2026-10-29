#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
[[ -f .env ]] || { echo "Missing .env" >&2; exit 1; }
set -a
# shellcheck disable=SC1091
source .env
set +a
wp() { docker compose run --rm -T wpcli "$@"; }
echo "=== Runtime ==="
docker compose ps
echo "=== WordPress ==="
wp core version
wp core is-installed && echo "WordPress installed"
echo "=== Meta Embeds ==="
wp plugin get meta-embeds --fields=name,status,version --format=table
echo "=== Theme ==="
wp theme list --status=active --fields=name,status,version
echo "=== Fixtures ==="
wp post list --post_type=page --post_status=publish --fields=ID,post_name,post_title --format=table
echo "=== HTTP status (localhost) ==="
curl -sSL -o /dev/null -w '%{http_code}\n' "${WP_URL:-http://localhost:8086}/"
echo "Browser/carousel/network/performance tests still require evidence; HTTP 200 does not imply PASS."
