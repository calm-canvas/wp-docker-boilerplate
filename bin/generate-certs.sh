#!/bin/bash

# Check if mkcert is installed
if ! command -v mkcert &> /dev/null && ! command -v mkcert.exe &> /dev/null
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

# Improved IP detection using Python (reliable across macOS, Linux, and Windows)
CURRENT_IP=$(python3 -c "import socket; s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM); s.connect(('8.8.8.8', 80)); print(s.getsockname()[0]); s.close()" 2>/dev/null || \
             python -c "import socket; s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM); s.connect(('8.8.8.8', 80)); print(s.getsockname()[0]); s.close()" 2>/dev/null || \
             echo "127.0.0.1")

echo "Detected IP: $CURRENT_IP"

# Generate certificates
# You can add your local domains here, e.g., localhost 127.0.0.1
mkcert -cert-file "$CERT_DIR/server.crt" -key-file "$CERT_DIR/server.key" "$CURRENT_IP" localhost 127.0.0.1 ::1

echo "Certificates generated in $CERT_DIR"
