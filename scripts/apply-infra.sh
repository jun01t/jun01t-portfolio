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

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN || true
export AWS_EC2_METADATA_DISABLED=1 AWS_SDK_LOAD_CONFIG=1

if ! aws sts get-caller-identity >/dev/null 2>&1; then
  echo "AWS credentials are missing or expired."
  echo "Run: aws login"
  echo "Then re-run this script."
  exit 1
fi

# Terraform AWS provider does not always pick up `aws login` cache directly.
eval "$(aws configure export-credentials --format env)"

cd "$TF_DIR/lambda"
run_pnpm install --prod

cd "$TF_DIR"
mkdir -p build
"$TF_BIN" init -input=false
"$TF_BIN" apply -input=false -auto-approve

echo
echo "Next:"
echo "1) Open the SES verification email sent to tmdjnch0901@gmail.com"
echo "2) From repo root: pnpm run deploy:aws"
echo
"$TF_BIN" output
