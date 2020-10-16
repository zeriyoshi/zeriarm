#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"
TWEET_AT="@zeriyoshi"
TARGET_MOUNT_POINT="/storage"
LOG_PATH="/tmp/junk_file_clean_list"

COUNT="$(find "${TARGET_MOUNT_POINT}" \( -name '.DS_Store' -o -name '._*' -o -name '.apdisk' -o -name 'Thumbs.db' -o -name 'Desktop.ini' \) | wc -l)"
if [ "${COUNT}" = "0" ]; then
    exit
fi

find "${TARGET_MOUNT_POINT}" \( -name '.DS_Store' -o -name '._*' -o -name '.apdisk' -o -name 'Thumbs.db' -o -name 'Desktop.ini' \) -delete -print > "${LOG_PATH}"

"${TWEET_BIN}" "[junk_file_clean] ${COUNT} files deleted. (log: /tmp/junk_file_clean_list) $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
