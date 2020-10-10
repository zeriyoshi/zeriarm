#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"
TWEET_AT="@zeriyoshi"
TARGET_MOUNT_POINT="/storage"

if [ ! -d "${TARGET_MOUNT_POINT}" ]; then
    "${TWEET_BIN}" "[btrfs_maintenance] ${TARGET_MOUNT_POINT} not found. ${TWEET_AT}"
    exit 2
fi 

"${TWEET_BIN}" "[btrfs_maintenance] starting defrag... ${TWEET_AT}"
btrfs filesystem defragment -r -v "${TARGET_MOUNT_POINT}"
"${TWEET_BIN}" "[btrfs_maintenance] complete defrag. ${TWEET_AT}"

sleep 10

"${TWEET_BIN}" "[btrfs_maintenance] begin scrub.

status:
$(btrfs scrub status "${TARGET_MOUNT_POINT}")"
btrfs scrub start "${TARGET_MOUNT_POINT}"
