#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if [[ ! -f .env ]]; then
  echo "Missing .env; copy .env.example and fill in values." >&2
  exit 1
fi
set -a
# shellcheck disable=SC1091
source <(sed 's/\r$//' .env)
set +a
for key in WP_URL WP_TITLE WP_ADMIN_USER WP_ADMIN_PASSWORD WP_ADMIN_EMAIL DB_NAME DB_USER DB_PASSWORD DB_ROOT_PASSWORD; do
  [[ -n "${!key:-}" ]] || { echo "Missing $key in .env" >&2; exit 1; }
done
if [[ "$WP_ADMIN_PASSWORD $DB_PASSWORD $DB_ROOT_PASSWORD" == *CHANGE_ME* ]]; then
  echo "Replace CHANGE_ME secrets in .env first." >&2
  exit 1
fi
wp() { docker compose run --rm -T wpcli "$@"; }
echo "Starting WordPress + MariaDB..."
docker compose up -d db wordpress
echo "Waiting for WordPress initialization..."
ready=0
for i in $(seq 1 45); do
  if wp core version >/dev/null 2>&1; then ready=1; break; fi
  sleep 3
done
if [[ $ready -ne 1 ]]; then echo "WordPress or database not ready. Check docker compose logs." >&2; exit 1; fi
if ! wp core is-installed >/dev/null 2>&1; then
  wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email
else
  echo "WordPress already installed; preserving existing site."
fi
wp rewrite structure '/%postname%/' --hard || true
wp plugin install meta-embeds --version=1.2.2 --activate
wp theme activate twentytwentyfive
create_page() {
  local slug="$1" title="$2" file="$3" id
  id="$(wp post list --post_type=page --name="$slug" --field=ID --format=ids | tr -d '\r\n')"
  if [[ -n "$id" ]]; then
    wp post update "$id" "/workspace/tests/fixtures/$file" --post_title="$title" --post_status=publish >/dev/null
  else
    wp post create "/workspace/tests/fixtures/$file" --post_type=page --post_name="$slug" --post_title="$title" --post_status=publish >/dev/null
  fi
  echo "Fixture: $WP_URL/$slug/"
}
create_page "poc-client-exact" "POC — Client exact URL" "client-exact.html"
create_page "poc-client-clean" "POC — Client clean permalink" "client-clean.html"
create_page "poc-multiple" "POC — Multiple manual embeds" "multiple.html"
create_page "poc-invalid" "POC — Invalid and unavailable embed" "invalid.html"
echo "Bootstrap complete. Open $WP_URL"
