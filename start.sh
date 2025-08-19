#!/usr/bin/env bash
# Equivalent Bash script for the given .bat
# Works with Docker Compose v2 ("docker compose") or v1 ("docker-compose")

set -o nounset
set -o pipefail

# === Paths & project name ===
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
GPU_FILE="$DIR/config/docker-compose-gpu.yml"
CPU_FILE="$DIR/config/docker-compose-cpu.yml"
PROJECT="local-ai-infra"

echo "Select mode:"
echo "  [1] GPU"
echo "  [2] CPU"
read -r -p "Enter 1 or 2: " choice

case "$choice" in
  1)
    FILE="$GPU_FILE"
    echo "Using GPU mode."
    ;;
  2)
    if [[ -f "$CPU_FILE" ]]; then
      FILE="$CPU_FILE"
    else
      echo "ERROR: CPU compose file not found: \"$CPU_FILE\"." >&2
      exit 1
    fi
    echo "Using CPU mode."
    ;;
  *)
    echo "Invalid choice." >&2
    exit 1
    ;;
esac

if [[ ! -f "$FILE" ]]; then
  echo "ERROR: Compose file \"$FILE\" not found." >&2
  exit 1
fi

# Prefer Docker Compose v2, fall back to v1
if docker compose version >/dev/null 2>&1; then
  echo "Running: docker compose -f \"$FILE\" -p \"$PROJECT\" up -d"
  docker compose -f "$FILE" -p "$PROJECT" up -d
elif docker-compose --version >/dev/null 2>&1; then
  echo "Running: docker-compose -f \"$FILE\" -p \"$PROJECT\" up -d"
  docker-compose -f "$FILE" -p "$PROJECT" up -d
else
  echo
  echo "ERROR: Docker Compose not found." >&2
  echo " - Install Docker Desktop (includes \"docker compose\") or docker-compose v1." >&2
  exit 1
fi

echo
echo "Done."