#!/bin/bash

# Detect OS
OS="$(uname -s)"

if [ "$OS" == "Darwin" ]; then
    echo "Detected macOS."
elif [ "$OS" == "Linux" ]; then
    echo "Detected Linux."
else
    echo "Error: This script does not support $OS (Windows is not supported)."
    exit 1
fi

# Check if mkcert is installed
if command -v mkcert &> /dev/null; then
    echo "mkcert is already installed."
    exit 0
fi

echo "mkcert not found. Starting installation..."

if [ "$OS" == "Darwin" ]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is required for installation on macOS. Please install it first: https://brew.sh/"
        exit 1
    fi
    brew install mkcert
    brew install nss # Required for Firefox support
elif [ "$OS" == "Linux" ]; then
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install wget libnss3-tools -y
        # Download mkcert binary
        VERSION=$(curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | grep tag_name | cut -d '"' -f 4)
        wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/${VERSION}/mkcert-${VERSION}-linux-amd64
        chmod +x mkcert
        sudo mv mkcert /usr/local/bin/
    elif command -v brew &> /dev/null; then
        brew install mkcert
    else
        echo "Error: No supported package manager found (apt or brew). Please install mkcert manually."
        exit 1
    fi
fi

# Initialize mkcert
mkcert -install

echo "mkcert installation completed."
