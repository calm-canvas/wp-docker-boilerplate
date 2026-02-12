# WordPress Docker Boilerplate

A comprehensive WordPress development boilerplate designed for modern local development. It integrates a Docker-based environment, a custom theme with a Vite-powered frontend build system (supporting TypeScript, Sass, and React), and automated setup scripts.

## Quick Start

1. **Environment Configuration**: 
   ```bash
   cp .env.example .env
   ```
2. **Theme Initialization**:
   ```bash
   python3 bin/python/rename_theme.py
   ```
3. **Install Dependencies**:
   ```bash
   make install
   ```
4. **Start the Project**:
   ```bash
   make up
   ```

## Detailed Documentation

For more specific instructions, please refer to:

- [**Setup Guide**](./SETUP.md): Detailed steps for environment setup, database configuration, SSL, and initialization.
- [**Development Guide**](./DEVELOP.md): Information on code structure, frontend workflow, and quality standards.

## Project Structure

- `assets/`: Source frontend files (TypeScript/React, Sass).
- `theme-name/`: The primary WordPress theme (renameable).
- `docker/`: Dockerfiles and service configurations.
- `bin/`: Utility scripts for automation.

## Shared Services

This project is designed to connect to a shared MariaDB service. Ensure you have the [Shared Services](https://github.com/tranthethang/docker-shared-services) running before starting.
