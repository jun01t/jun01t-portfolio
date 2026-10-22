#!/usr/bin/env bash
# Build contact Lambda zip outside Terraform (avoids archive_file walking iCloud-slow node_modules).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LAMBDA_DIR="$ROOT_DIR/infra/contact/lambda"
OUT_DIR="$ROOT_DIR/infra/contact/build"
OUT_ZIP="$OUT_DIR/contact-lambda.zip"
PNPM_VERSION="9.15.9"

. "$ROOT_DIR/scripts/use-node.sh"

run_pnpm() {
  if command -v corepack >/dev/null 2>&1; then
    corepack "pnpm@${PNPM_VERSION}" "$@"
  else
    npx --yes "pnpm@${PNPM_VERSION}" "$@"
  fi
}

if ! command -v zip >/dev/null 2>&1; then
  echo "zip is required to pack the Lambda bundle." >&2
  exit 1
fi

STAGE="$(mktemp -d "${TMPDIR:-/tmp}/contact-lambda.XXXXXX")"
cleanup() { rm -rf "$STAGE"; }
trap cleanup EXIT

cp "$LAMBDA_DIR/package.json" "$STAGE/"
[[ -f "$LAMBDA_DIR/pnpm-lock.yaml" ]] && cp "$LAMBDA_DIR/pnpm-lock.yaml" "$STAGE/"
cp "$LAMBDA_DIR/index.mjs" "$STAGE/"
[[ -f "$LAMBDA_DIR/.npmrc" ]] && cp "$LAMBDA_DIR/.npmrc" "$STAGE/"

cd "$STAGE"
if [[ -f pnpm-lock.yaml ]]; then
  run_pnpm install --prod --frozen-lockfile
else
  run_pnpm install --prod
fi

mkdir -p "$OUT_DIR"
rm -f "$OUT_ZIP"
(
  cd "$STAGE"
  zip -Xqr "$OUT_ZIP" index.mjs package.json node_modules
)

if [[ ! -s "$OUT_ZIP" ]]; then
  echo "Failed to write $OUT_ZIP" >&2
  exit 1
fi

echo "Wrote $OUT_ZIP ($(wc -c <"$OUT_ZIP" | tr -d ' ') bytes)"
