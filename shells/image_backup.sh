#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"
TWEET_AT="@zeriyoshi"
TARGET_MOUNT_POINT="/storage"
TARGET_DIR="/nas_image_backup"
TARGET_DEV="/dev/mmcblk1"

if [ ! -d "${TARGET_MOUNT_POINT}" ]; then
    "${TWEET_BIN}" "[image_backup] ${TARGET_MOUNT_POINT} missing. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
fi

if [ ! -d "${TARGET_MOUNT_POINT}${TARGET_DIR}" ]; then
    "${TWEET_BIN}" "[image_backup] ${TARGET_MOUNT_POINT}${TARGET_DIR} missing. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
fi

OUT_PATH="${TARGET_MOUNT_POINT}${TARGET_DIR}/$(date +"%Y%m%d").img.gz"
"${TWEET_BIN}" "[image_backup] image backup started: ${OUT_PATH} $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
dd if="${TARGET_DEV}" bs=1M | gzip -c > "${OUT_PATH}"
"${TWEET_BIN}" "[image_backup] image backup finished: ${OUT_PATH} $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
