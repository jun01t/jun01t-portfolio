#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TF_DIR="$ROOT_DIR/infra/contact"
TF_BIN="$ROOT_DIR/infra/.bin/terraform"

if [[ ! -x "$TF_BIN" ]]; then
  echo "terraform binary not found at $TF_BIN (requires Terraform >= 1.10)" >&2
  exit 1
fi

if [[ ! -s "$TF_DIR/backend.hcl" ]]; then
  echo "Missing infra/contact/backend.hcl. Copy backend.hcl.example and set the existing state bucket." >&2
  echo "See infra/contact/README.md for backend setup and local state migration." >&2
  exit 1
fi

cd "$TF_DIR"
"$TF_BIN" init -input=false -backend-config=backend.hcl "$@"
