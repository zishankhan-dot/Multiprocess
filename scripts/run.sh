#!/bin/bash
TARGET="${1:-}"
case "$TARGET" in
    java|java-virtual)
        sudo apt install -y default-jdk
        java -version
        ;;
    cpp|c)
        sudo apt install -y build-essential
        ;;
    python)
        sudo apt install -y python3
        python3 --version
        ;;
    *)
        echo "Unknown target: $TARGET"
        exit 1
        ;;
esac    