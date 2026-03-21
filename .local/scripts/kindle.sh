#!/usr/bin/env bash

KINDLE_DIR="$HOME/.local/kindle"

if [ $# -ne 1 ]; then
    echo "kindle.sh <attach|detach>"
    exit 1;
fi

if [ "$1" == "attach" ]; then
    mkdir -p "${KINDLE_DIR}"
    jmtpfs "${KINDLE_DIR}"
elif [ "$1" == "detach" ]; then
    fusermount -u "${KINDLE_DIR}"
    rmdir "${KINDLE_DIR}"
else
    echo "kindle.sh <attach|detach>"
    exit 1;
fi

