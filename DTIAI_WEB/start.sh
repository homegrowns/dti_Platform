#/bin/bash

DOWNLOAD_FILE_DIR=/data/backend/download-file

if ! [ -d "$DOWNLOAD_FILE_DIR" ]; then
    echo "$DOWNLOAD_FILE_DIR" does not exist. making directory...
    mkdir -p "$DOWNLOAD_FILE_DIR"
fi

/root/.nvm/versions/node/v20.9.0/bin/pm2 start /data/ecosystem.config.js
