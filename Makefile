.PHONY: help up down restart stop logs ps init rename setup-mkcert generate-certs install dev build lint-js fix-js lint-php fix-php backup clear-cache fix-line theme-info

help:
	@echo "Available commands:"
	@echo "  Environment:"
	@echo "    up             - Start docker containers"
	@echo "    down           - Stop and remove containers"
	@echo "    restart        - Restart containers"
	@echo "    stop           - Stop containers"
	@echo "    logs           - Show docker logs"
	@echo "    ps             - List containers"
	@echo ""
	@echo "  Setup:"
	@echo "    init           - Run initial setup script"
	@echo "    rename         - Rename the theme"
	@echo "    setup-mkcert   - Install mkcert and setup local CA"
	@echo "    generate-certs - Generate SSL certificates"
	@echo "    install        - Install all dependencies (pnpm & composer)"
	@echo ""
	@echo "  Frontend (Node):"
	@echo "    dev            - Run Vite in watch mode"
	@echo "    build          - Build production assets"
	@echo "    lint-js        - Lint JS/TS files"
	@echo "    fix-js         - Fix JS/TS lint issues"
	@echo ""
	@echo "  Backend (PHP):"
	@echo "    lint-php       - Check PHP coding standards"
	@echo "    fix-php        - Fix PHP coding standards"
	@echo ""
	@echo "  Utilities:"
	@echo "    backup         - Backup database"
	@echo "    clear-cache    - Clear WordPress cache"
	@echo "    fix-line       - Fix line endings"
	@echo "    theme-info     - Generate theme info"

# Environment management
up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

stop:
	docker-compose stop

logs:
	docker-compose logs -f

ps:
	docker-compose ps

# Setup tasks
init:
	sh bin/init.sh

rename:
	python3 bin/python/rename_theme.py

setup-mkcert:
	sh bin/setup-mkcert.sh

generate-certs:
	sh bin/generate-certs.sh

install:
	pnpm install
	composer install

# Frontend tasks
dev:
	pnpm dev

build:
	pnpm build

lint-js:
	pnpm lint

fix-js:
	pnpm lint:fix

# PHP tasks
lint-php:
	composer format

fix-php:
	composer fix

# Utilities
backup:
	sh bin/backupdb.sh

clear-cache:
	sh bin/clear-cache.sh

fix-line:
	python3 bin/python/fix_line_endings.py

theme-info:
	python3 bin/python/generate-theme-info.py
