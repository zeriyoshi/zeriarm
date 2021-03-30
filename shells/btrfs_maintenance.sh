#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"
TWEET_AT="@zeriyoshi"
TARGET_MOUNT_POINT="/storage"

if [ ! -d "${TARGET_MOUNT_POINT}" ]; then
    "${TWEET_BIN}" "[btrfs_maintenance] ${TARGET_MOUNT_POINT} not found. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
    exit 2
fi 

"${TWEET_BIN}" "[btrfs_maintenance] starting defrag... $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
btrfs filesystem defragment -r -v "${TARGET_MOUNT_POINT}"
"${TWEET_BIN}" "[btrfs_maintenance] complete defrag. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"

sleep 10

"${TWEET_BIN}" "[btrfs_maintenance] begin scrub. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
btrfs scrub start -B "${TARGET_MOUNT_POINT}"
"${TWEET_BIN}" "[btrfs_maintenance] complete scrub. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
