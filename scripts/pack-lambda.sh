#!/usr/bin/env bash
# Build contact Lambda zip outside Terraform (avoids archive_file walking iCloud-slow node_modules).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LAMBDA_DIR="$ROOT_DIR/infra/contact/lambda"
OUT_DIR="$ROOT_DIR/infra/contact/build"
OUT_ZIP="$OUT_DIR/contact-lambda.zip"
PNPM_VERSION="9.15.9"

# Prefer a modern Node (Homebrew node can be older than pnpm requires).
if [[ -d "${HOME}/.nodebrew/node/v22.22.0/bin" ]]; then
  export PATH="${HOME}/.nodebrew/node/v22.22.0/bin:$PATH"
elif [[ -d "${HOME}/.nodebrew/node/v20.20.0/bin" ]]; then
  export PATH="${HOME}/.nodebrew/node/v20.20.0/bin:$PATH"
elif [[ -d "${HOME}/.nodebrew/current/bin" ]]; then
  export PATH="${HOME}/.nodebrew/current/bin:$PATH"
fi

run_pnpm() {
  if command -v pnpm >/dev/null 2>&1 && pnpm --version >/dev/null 2>&1; then
    pnpm "$@"
  else
    npx --yes "pnpm@${PNPM_VERSION}" "$@"
  fi
}

STAGE="$(mktemp -d "${TMPDIR:-/tmp}/contact-lambda.XXXXXX")"
cleanup() { rm -rf "$STAGE"; }
trap cleanup EXIT

cp "$LAMBDA_DIR/package.json" "$STAGE/"
[[ -f "$LAMBDA_DIR/pnpm-lock.yaml" ]] && cp "$LAMBDA_DIR/pnpm-lock.yaml" "$STAGE/"
cp "$LAMBDA_DIR/index.mjs" "$STAGE/"
[[ -f "$LAMBDA_DIR/.npmrc" ]] && cp "$LAMBDA_DIR/.npmrc" "$STAGE/"

cd "$STAGE"
run_pnpm install --prod --frozen-lockfile 2>/dev/null || run_pnpm install --prod

mkdir -p "$OUT_DIR"
rm -f "$OUT_ZIP"
# Deterministic-ish zip: store only runtime files
(
  cd "$STAGE"
  zip -qr "$OUT_ZIP" index.mjs package.json node_modules \
    -x '*/pnpm-lock.yaml' -x '*/.npmrc' -x '*/.gitignore'
)

echo "Wrote $OUT_ZIP ($(wc -c <"$OUT_ZIP" | tr -d ' ') bytes)"
