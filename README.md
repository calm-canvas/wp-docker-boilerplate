# wp-docker-boilerplate

## Getting Started

Follow these steps to set up your new WordPress project.

### 1. Environment Configuration

First, you need to create your local environment configuration file. Copy the example file:

```bash
cp .env.example .env
```

Next, open the `.env` file and customize the configuration values for your project. At a minimum, you should set your desired theme name:

```dotenv
THEME_NAME=my-awesome-theme
```

### 2. Theme Initialization

Once you have configured your `THEME_NAME` in the `.env` file, run the theme initialization script. This will rename the `theme-name` directory and update all placeholder references throughout the project.

From the project root directory, run:

```bash
python3 bin/python/rename_theme.py
```

### 3. Shared Services (Database)

This project's `docker-compose.yml` does not include a database service. It is designed to connect to a shared MariaDB service.

Before starting this project, you must first set up the shared services by following the instructions at this repository: [https://github.com/tranthethang/docker-shared-services](https://github.com/tranthethang/docker-shared-services)

This will install and run MariaDB and other shared containers needed by this project.

### 4. Start the Project

Once the shared services are running and the project is set up, you can start it using Docker:

```bash
docker-compose up -d
```
