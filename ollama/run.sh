#!/bin/bash

# Load environment variables from .env if it exists
if [ -f ".env" ]; then
  echo "Loading environment variables from .env"
  set -o allexport
  source .env
  set +o allexport
fi

# Function to bring down docker-compose on exit
cleanup() {
  echo "\nStopping services..."
  docker-compose -f docker-compose.yaml down
  exit 0
}

trap cleanup SIGINT SIGTERM

docker-compose -f docker-compose.yaml up -d

OLLAMA_URL="http://localhost:${OLLAMA_PORTL}"

until curl -s "$OLLAMA_URL" > /dev/null; do
  echo "Waiting for Ollama to start on $OLLAMA_URL..."
  sleep 3
done

echo "Ollama is up. Pulling $OLLAMA_MODEL..."
curl -X POST "$OLLAMA_URL/api/pull" -d "{\"name\": \"$OLLAMA_MODEL\"}" -H 'Content-Type: application/json'

echo "Tailing docker-compose logs. Press Ctrl+C to stop and clean up."
docker-compose -f docker-compose.yaml logs -f