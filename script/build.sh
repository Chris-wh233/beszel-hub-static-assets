#!/usr/bin/env bash
set -euo pipefail

VERSION="${VERSION:-v0.18.8}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

git clone --depth 1 --branch "$VERSION" https://github.com/henrygd/beszel.git "$BUILD_DIR/beszel"
npm ci --prefix "$BUILD_DIR/beszel/internal/site"
npm run --prefix "$BUILD_DIR/beszel/internal/site" build

rm -rf "$ROOT_DIR/dist"
mkdir -p "$ROOT_DIR/dist"
cp -a "$BUILD_DIR/beszel/internal/site/dist/." "$ROOT_DIR/dist/"
