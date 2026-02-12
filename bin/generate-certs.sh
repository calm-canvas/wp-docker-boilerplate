#!/bin/bash

# Check if mkcert is installed
if ! command -v mkcert &> /dev/null
then
    echo "mkcert could not be found. Attempting to install..."
    ./bin/setup-mkcert.sh
    if [ $? -ne 0 ]; then
        echo "Failed to install mkcert. Please install it manually."
        exit 1
    fi
fi

CERT_DIR="docker/nginx/certs"
mkdir -p "$CERT_DIR"

CURRENT_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | awk '{print $2}' | sed 's/addr://' | head -n 1)

# Generate certificates
# You can add your local domains here, e.g., localhost 127.0.0.1
mkcert -cert-file "$CERT_DIR/server.crt" -key-file "$CERT_DIR/server.key" "$CURRENT_IP" localhost 127.0.0.1 ::1

echo "Certificates generated in $CERT_DIR"
