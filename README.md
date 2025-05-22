# StartUp Crew

Using CrewAI to validate startup ideas from different points of view.

## Ollama

This project includes an Ollama stack for running local LLMs and a web UI for interaction.

### Setup

1. **Copy the environment template:**

   ```sh
   cp ollama/.env.template ollama/.env
   ```

   Edit `ollama/.env` to adjust ports, model name, or other settings as needed.

2. **Start the stack:**
   ```sh
   cd ollama
   ./run.sh
   ```
   This script will:
   - Load environment variables from `.env`
   - Start the required Docker Compose services
   - Wait for Ollama to be ready
   - Pull the specified model (from `$OLLAMA_MODEL` in `.env`)
   - Tail the logs for all services
   - Automatically stop and clean up services when you exit the script (Ctrl+C)

### Services

- **Ollama API**: [http://localhost:11434](http://localhost:11434) (or the port you set in `.env`)
- **Web UI**: [http://localhost:3000](http://localhost:3000) (or the port you set in `.env`)

### Stopping

- Press `Ctrl+C` in the terminal running `run.sh` to stop all services and clean up.
