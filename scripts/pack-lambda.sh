#!/usr/bin/env bash
# Build contact Lambda zip outside Terraform (avoids archive_file walking iCloud-slow node_modules).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LAMBDA_DIR="$ROOT_DIR/infra/contact/lambda"
OUT_DIR="$ROOT_DIR/infra/contact/build"
OUT_ZIP="$OUT_DIR/contact-lambda.zip"
PNPM_VERSION="9.15.9"

# Prefer Node 20+ (Homebrew node can be older than pnpm requires).
for dir in "${HOME}/.nodebrew/node"/v22.*/bin "${HOME}/.nodebrew/node"/v20.*/bin "${HOME}/.nodebrew/current/bin"; do
  if [[ -x "${dir}/node" ]]; then
    export PATH="${dir}:$PATH"
    break
  fi
done

run_pnpm() {
  if command -v pnpm >/dev/null 2>&1 && pnpm --version >/dev/null 2>&1; then
    pnpm "$@"
  else
    npx --yes "pnpm@${PNPM_VERSION}" "$@"
  fi
}

if ! command -v zip >/dev/null 2>&1; then
  echo "zip is required to pack the Lambda bundle." >&2
  exit 1
fi

node_major="$(node -p "process.versions.node.split('.')[0]" 2>/dev/null || echo 0)"
if [[ "${node_major}" -lt 20 ]]; then
  echo "Node.js 20+ is required to pack the Lambda bundle (found $(node -v 2>/dev/null || echo none))." >&2
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
