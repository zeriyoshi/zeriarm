#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
TWEET_BIN="${SCRIPT_DIR}/../kotoriotoko/BIN/tweet.sh"

CPU_TEMP="$(cat "/sys/class/thermal/thermal_zone0/temp" | sed -e 's/^\(.\{2\}\)/\1./') ℃"
HDD_TEMPS="いや編集してるんだがEX
"

for DEVICE in $(find "/dev" -name "sd*");do
    HDD_TEMPS="$(printf "${HDD_TEMPS}\n${DEVICE}: $(/usr/sbin/hddtemp -n "${DEVICE}")")"
done

printf "CPU:${CPU_TEMP}\nHDDs:\n${HDD_TEMPS}\n$(date +"%Y-%m-%d %H:%M:%S")" | "${TWEET_BIN}"
