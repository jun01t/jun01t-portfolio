#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TF_DIR="$ROOT_DIR/infra/contact"
TF_BIN="$ROOT_DIR/infra/.bin/terraform"
PNPM_VERSION="9.15.9"

run_pnpm() {
  if command -v pnpm >/dev/null 2>&1 && pnpm --version >/dev/null 2>&1; then
    pnpm "$@"
  else
    npx --yes "pnpm@${PNPM_VERSION}" "$@"
  fi
}

# Prefer Node 20+ (nuxt generate can crash on older Node)
if [[ -x "$HOME/.nodebrew/current/bin/node" ]]; then
  export PATH="$HOME/.nodebrew/current/bin:$PATH"
fi

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN || true
export AWS_EC2_METADATA_DISABLED=1 AWS_SDK_LOAD_CONFIG=1
eval "$(aws configure export-credentials --format env)"

cd "$TF_DIR"
if [[ ! -x "$TF_BIN" ]]; then
  echo "terraform binary not found at $TF_BIN" >&2
  exit 1
fi

BUCKET="$("$TF_BIN" output -raw s3_bucket_name)"
DIST_ID="$("$TF_BIN" output -raw cloudfront_distribution_id)"
API_URL="$("$TF_BIN" output -raw contact_api_url)"
TURNSTILE_KEY="$("$TF_BIN" output -raw turnstile_site_key 2>/dev/null || true)"

cd "$ROOT_DIR"
export CONTACT_API_URL="${CONTACT_API_URL:-$API_URL}"
export TURNSTILE_SITE_KEY="${TURNSTILE_SITE_KEY:-$TURNSTILE_KEY}"
echo "CONTACT_API_URL=$CONTACT_API_URL"
if [[ -n "${TURNSTILE_SITE_KEY}" ]]; then
  echo "TURNSTILE_SITE_KEY is set"
else
  echo "WARN: TURNSTILE_SITE_KEY is empty (honeypot-only until Turnstile is configured)"
fi
echo "Deploying to s3://$BUCKET (CloudFront $DIST_ID)"

run_pnpm run generate
aws s3 sync dist/ "s3://${BUCKET}/" --delete
aws cloudfront create-invalidation --distribution-id "$DIST_ID" --paths "/*"

echo "Done: https://jun01t-portfolio.jun01t.com"
