# Development Guide

This document provides rules and development processes for the theme-name project.

## 1. Structure and Source Code Location

The project uses Vite to compile frontend assets from the `assets/` directory into the `theme-name/dist/` directory.

### CSS / Sass
- **Frontend (User Interface):** Write in [./assets/sass/style.scss](./assets/sass/style.scss).
- **Admin (Administrative Interface):** Write in [./assets/sass/admin-style.scss](./assets/sass/admin-style.scss).

### JavaScript / TypeScript / React
- **Frontend:** Write in [./assets/ts/script.tsx](./assets/ts/script.tsx).
- **Admin:** Write in [./assets/ts/admin-script.tsx](./assets/ts/admin-script.tsx).

## 2. Development and Compilation Workflow

You should use the commands in the `Makefile` to perform compilation:

- **Development Mode (Watch mode):** Run the following command to automatically compile whenever there are changes:
  ```bash
  make dev
  ```
- **Production Build:** Run the following command to optimize and bundle into the `theme-name/dist/` directory:
  ```bash
  make build
  ```

## 3. Code Quality Check (Linting & Formatting)

The project has been set up with **Husky**, **ESLint**, **Prettier**, and **PHP_CodeSniffer** to ensure code quality. These tools will automatically run when you perform a `commit`.

However, you should proactively run the following commands to check or automatically fix formatting errors:

### For JavaScript/TypeScript:
- Check for errors: `make lint-js` (or `pnpm lint`)
- Automatically fix errors: `make fix-js` (or `pnpm lint:fix`)

### For PHP:
- Check WordPress Standards (WPCS): `make lint-php` (or `composer format`)
- Automatically fix formatting errors: `make fix-php` (or `composer fix`)

## 4. Important Notes
- Always ensure the source code is free of Lint errors before pushing to the server.
- Do not directly edit files in the `theme-name/dist/` directory as they will be overwritten during compilation.
