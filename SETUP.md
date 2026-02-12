# Setup Guide

Below are the steps to set up the development environment for the theme-name project.

### 1. Environment File Setup
Copy the sample configuration file and create your own `.env` file:
```bash
cp .env.example .env
```

### 2. Database Configuration
Open the newly created `.env` file and update the database connection parameters if necessary. Defaults:
- **WORDPRESS_DB_NAME**: theme-name
- **WORDPRESS_DB_USER**: root
- **WORDPRESS_DB_PASSWORD**: password102

### 3. SSL (HTTPS) Setup
To run the project with HTTPS locally, you need to install `mkcert` and generate certificates:
```bash
make setup-mkcert      # Install mkcert and set up local CA
make generate-certs    # Generate SSL certificates for localhost
```

### 4. Custom PHP Configuration
Create an `override.ini` file to override default PHP configurations (such as memory limits, execution time):
```bash
cp docker/config/override.example.ini docker/config/override.ini
```

### 5. Start Support Services
The project uses Docker Profiles to manage additional services. Run the following command to start MariaDB and Redis:
```bash
docker-compose --profile tools up -d
```
*Explanation: The `tools` profile includes `mariadb` and `redis`.*

### 6. Start Main Application
Once the support services are ready, start WordPress and Nginx:
```bash
make up
# Or: docker-compose up -d
```

### 7. Data and Plugin Initialization
Run the initialization script to install necessary plugins and set permissions:
```bash
make init
```

### 8. Access the Application
After all containers are running, you can access WordPress via the ports configured in `.env`:
- **HTTP**: [http://localhost](http://localhost) (Default port: `WP_PORT=80`)
- **HTTPS**: [https://localhost](https://localhost) (Default port: `WP_PORT_SSL=433`)

### 9. WordPress Installation
On your first visit, you will see the WordPress installation interface. Fill in the administrative information and complete the installation.

---

## Other Useful Commands
- `make install`: Install dependencies for both Frontend (pnpm) and Backend (Composer).
- `make dev`: Run Vite in watch mode for Frontend development.
- `make build`: Bundle assets for the production environment.
- `make logs`: View container logs.
- `make stop`: Stop the containers.
