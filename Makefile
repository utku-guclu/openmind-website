SHELL := /bin/bash
COMPOSE := docker compose -f openmind-api/docker-compose.yml --env-file openmind-api/.env --project-name openmind --project-directory openmind-api
CLIENT_DIR := openmind-client
WAIT_URL := http://localhost/api/v1/categories
WAIT_RAILS_URL := http://localhost/up

.PHONY: help up down logs ps wait dev e2e e2e-ci stop-client clean

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*##"; printf "Targets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

up: ## Boot the full stack (postgres + rails + postgrest + caddy)
	$(COMPOSE) up -d --build
	@$(MAKE) wait

down: ## Stop and remove the stack (keeps the postgres volume)
	$(COMPOSE) down

clean: ## Stop and wipe the stack including volumes
	$(COMPOSE) down -v

ps: ## Show stack status
	$(COMPOSE) ps

logs: ## Tail interleaved logs from all services with prefixes
	$(COMPOSE) logs -f --tail=50

wait: ## Block until Caddy is up and PostgREST + Rails respond
	@echo "Waiting for stack to be healthy at http://localhost ..."
	@for i in $$(seq 1 60); do \
		if curl -sf $(WAIT_URL) >/dev/null && curl -sf $(WAIT_RAILS_URL) >/dev/null; then \
			echo "Stack is up."; exit 0; \
		fi; \
		sleep 1; \
	done; \
	echo "Timed out waiting for stack" >&2; \
	$(COMPOSE) logs --tail=80; \
	exit 1

dev: up ## Boot the stack and start the Vite dev server (hot reload at :5173)
	cd $(CLIENT_DIR) && npm run dev

build-client: ## Build the SPA so Caddy can serve it from /srv
	cd $(CLIENT_DIR) && npm run build

e2e: build-client ## Headed e2e: stack up, server logs streaming, browser visible
	@$(MAKE) up
	@$(COMPOSE) restart caddy >/dev/null
	@$(MAKE) wait
	@echo
	@echo "============================================================"
	@echo "Stack is live at http://localhost (SPA + API)"
	@echo "Server logs stream below. Playwright opens a headed browser."
	@echo "Ctrl-C stops the test runner; the stack stays up — use \`make down\`."
	@echo "============================================================"
	@echo
	@( $(COMPOSE) logs -f --tail=20 & echo $$! > /tmp/openmind-logs.pid ) ; \
	  trap 'kill `cat /tmp/openmind-logs.pid` 2>/dev/null; rm -f /tmp/openmind-logs.pid' EXIT INT TERM; \
	  cd $(CLIENT_DIR) && npm run e2e

e2e-ci: build-client ## Headless e2e for CI / quick local checks
	@$(MAKE) up
	@$(COMPOSE) restart caddy >/dev/null
	@$(MAKE) wait
	@cd $(CLIENT_DIR) && npm run e2e:ci
	@$(MAKE) down
