#!/bin/bash
set -e

VERSION="3.1.0"
URL="https://github.com/tariq86/react-native-pjsip-builder/releases/download/${VERSION}/release.tar.gz"
LOCK=".libs.lock"
DEST=".libs.tar.gz"
DOWNLOAD=true

# 1st, check the library LOCK file to see
# if we've already downloaded the libs
if [ -f ${LOCK} ]; then
    CURRENT_VERSION=$(cat ${LOCK})

    if [ "${CURRENT_VERSION}" == "${VERSION}" ]; then
        echo "Requested version, ${VERSION}, already downloaded!"
        exit 0
    fi
fi

# Make sure `curl` exists
if ! type "curl" >/dev/null; then
    echo "Missed curl dependency" >&2
    exit 1
fi

# Make sure `tar` exists
if ! type "tar" >/dev/null; then
    echo "Missed tar dependency" >&2
    exit 1
fi

# Do the download!
if [ "$DOWNLOAD" = true ]; then
    curl -L --silent "${URL}" -o "${DEST}"
    tar -xvf "${DEST}"
    rm -f "${DEST}"

    echo "${VERSION}" >${LOCK}
fi
