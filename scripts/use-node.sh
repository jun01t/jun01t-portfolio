#!/usr/bin/env bash
# Source this file so packaging and deployment use the same Node.js requirement.
NODE_SETUP_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NODE_SETUP_VERSION="$(tr -d '[:space:]' < "$NODE_SETUP_ROOT_DIR/.node-version")"
NODE_SETUP_BIN="${HOME}/.nodebrew/node/v${NODE_SETUP_VERSION}/bin"

if [[ -x "$NODE_SETUP_BIN/node" ]]; then
  export PATH="$NODE_SETUP_BIN:$PATH"
fi

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js $NODE_SETUP_VERSION is required. Install it and add it to PATH." >&2
  return 1
fi

node - "$NODE_SETUP_VERSION" <<'JS'
const required = process.argv[2].split('.').map(Number)
const actual = process.versions.node.split('.').map(Number)
const supported = actual[0] === required[0] && (
  actual[1] > required[1] ||
  (actual[1] === required[1] && actual[2] >= required[2])
)
if (!supported) {
  console.error(`Node.js >=${process.argv[2]} <${required[0] + 1} is required (found ${process.version}). Use the version in .node-version.`)
  process.exit(1)
}
JS
