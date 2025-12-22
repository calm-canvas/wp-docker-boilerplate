# Gemini Development Workspace Documentation

This document provides instructions for developing WordPress themes and plugins within this workspace.

## Project Structure

- **`theme-name/`**: This is the primary directory for theme development. It is mapped to `/var/www/html/wp-content/themes/theme-name` inside the Docker containers.
- **`plugins/`**: This directory is for plugin development. For example, the `wp-bomb` plugin resides in `plugins/wp-bomb`. Any new plugin should have its own subdirectory here and be mapped in `docker-compose.yml`.
- **`assets/`**: This directory contains the raw, uncompiled frontend assets (TypeScript and Sass).
  - **`assets/ts/`**: TypeScript files. The main entry point is `script.ts`.
  - **`assets/sass/`**: Sass files. The main entry point is `style.sass`.
- **`docker-compose.yml`**: Defines the Docker services, including the WordPress container, a WP-CLI container, and volume mappings.
- **`vite.config.js`**: Configuration file for Vite, the frontend build tool.
- **`composer.json`**: PHP dependency management and scripting for code quality tools.
- **`package.json`**: Node.js dependencies and scripts for the frontend build process.

## Getting Started

1.  **Environment Variables**: Copy `.env.example` to `.env` and customize the variables as needed.
2.  **Start Docker**: Run `docker-compose up -d` to start the WordPress and CLI containers.
3.  **Initialization**: Run `sh bin/init.sh` to set file permissions and install recommended development plugins.

## Theme Development

1.  The main theme is located in the `theme-name` directory. You can start developing your theme by editing the files in this directory.
2.  The theme's name is determined by the `THEME_NAME` environment variable in your `.env` file, which defaults to `theme-name`.

## Plugin Development

1.  Plugins are located in the `plugins` directory.
2.  To create a new plugin:
    1.  Create a new directory for your plugin inside `plugins/`.
    2.  Add a volume mapping in `docker-compose.yml` to map your new plugin directory to `/var/www/html/wp-content/plugins/your-plugin-name`.
    3.  Restart your Docker containers: `docker-compose up -d --force-recreate`.

## Frontend Development (Assets)

This project uses Vite to compile TypeScript and Sass.

-   **Source files**:
    -   TypeScript: `assets/ts/script.ts`
    -   Sass: `assets/sass/style.sass`
-   **Output files**:
    -   JavaScript: `theme-name/assets/js/script.js`
    -   CSS: `theme-name/style.css`

### Frontend Workflow

-   **Development**: Run `npm run dev` to start the Vite development server. This will watch for changes in the `assets` directory and automatically recompile your assets. It also provides hot module replacement for a smoother development experience.
-   **Production Build**: Run `npm run build` to create optimized, production-ready assets.
-   **Watch for Changes**: Run `npm run watch` to automatically rebuild assets whenever a file in the `assets` directory is changed.

## WP-CLI

A WP-CLI container is included for running WordPress commands from the command line.

-   **Usage**: `docker-compose exec cli wp <command>`
-   **Example**: `docker-compose exec cli wp plugin list`

## PHP Code Quality

This project uses PHP_CodeSniffer with WordPress Coding Standards.

-   **Check Code**: `composer format`
-   **Fix Code**: `composer fix`
