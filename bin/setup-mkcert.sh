#!/bin/bash

# Detect OS
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    echo "Detected macOS."
elif [[ "$OS" == "Linux" ]]; then
    echo "Detected Linux."
elif [[ "$OS" == *"MINGW"* || "$OS" == *"MSYS"* || "$OS" == *"CYGWIN"* ]]; then
    echo "Detected Windows."
    IS_WINDOWS=true
else
    echo "Error: This script does not support $OS."
    exit 1
fi

# Check if mkcert is installed
if command -v mkcert &> /dev/null || command -v mkcert.exe &> /dev/null; then
    echo "mkcert is already installed."
    mkcert -install
    exit 0
fi

echo "mkcert not found. Starting installation..."

if [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is required for installation on macOS. Please install it first: https://brew.sh/"
        exit 1
    fi
    brew install mkcert
    brew install nss # Required for Firefox support
elif [[ "$OS" == "Linux" ]]; then
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y wget curl libnss3-tools
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
elif [[ "$IS_WINDOWS" == true ]]; then
    if command -v choco &> /dev/null; then
        choco install mkcert -y
    elif command -v scoop &> /dev/null; then
        scoop install mkcert
    else
        echo "No package manager (choco or scoop) found. Downloading binary..."
        if ! command -v curl &> /dev/null; then
            echo "Error: curl is required to download mkcert. Please install curl or mkcert manually."
            exit 1
        fi
        VERSION=$(curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | grep tag_name | cut -d '"' -f 4)
        curl -L -o mkcert.exe "https://github.com/FiloSottile/mkcert/releases/download/${VERSION}/mkcert-${VERSION}-windows-amd64.exe"
        # Try to move to a directory in PATH
        if [[ -d "/c/Windows/System32" ]]; then
             mv mkcert.exe /c/Windows/System32/mkcert.exe 2>/dev/null || echo "Could not move to System32. Please run as Admin or add current dir to PATH."
        fi
    fi
fi

# Initialize mkcert
mkcert -install

echo "mkcert installation completed."
