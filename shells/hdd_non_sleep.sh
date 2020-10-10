#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"
TWEET_AT="@zeriyoshi"

find "/dev" -name 'sd*' | xargs hdparm -S 0
"${TWEET_BIN}" "[hdd_non_sleep] set non-sleep mode successfully. ${TWEET_AT}"
