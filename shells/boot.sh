#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"
TWEET_AT="@zeriyoshi"

"${TWEET_BIN}" "[boot] boot succssfully. $(date +"%Y-%m-%d %H:%M:%S") ${TWEET_AT}"
