# Official Ollama image
FROM ollama/ollama:latest

# Use bash for RUN
SHELL ["/bin/bash", "-lc"]

# Models directory inside the image (Ollama default)
ENV OLLAMA_MODELS=/root/.ollama

# Ensure the client talks to the local server during build
ENV OLLAMA_HOST=127.0.0.1:11434

# List of models to pre-download, injected via --build-arg (from docker-compose)
# e.g. "llama3:8b qwen2:7b deepseek-r1:7b"
ARG MODELS=""

# Temporarily start the server, pull the models (with retries), then stop it.
# The named volume mounted later will be initialized with these files on first run.
RUN set -euo pipefail; \
    echo "Models requested: '${MODELS}'"; \
    # Nothing to do if MODELS is empty
    if [[ -z "${MODELS// }" ]]; then \
      echo "No models requested at build time."; \
      exit 0; \
    fi; \
    # Start the Ollama server in the background
    ollama serve >/tmp/ollama-build.log 2>&1 & \
    pid=$!; \
    # Normalize separators: commas -> spaces
    models="$(echo "$MODELS" | tr ',' ' ')"; \
    for m in $models; do \
      echo "==> Pulling $m"; \
      ok=0; \
      # Retry for ~2 minutes while the server warms up
      for i in {1..60}; do \
        if ollama pull "$m"; then ok=1; break; fi; \
        sleep 2; \
      done; \
      if [[ "$ok" -ne 1 ]]; then \
        echo "Failed to pull model: $m"; \
        echo "---- ollama logs ----"; tail -n +1 /tmp/ollama-build.log || true; \
        exit 1; \
      fi; \
    done; \
    # Gracefully stop the server
    kill "$pid"; \
    wait "$pid" || true; \
    echo "All requested models pulled successfully."