#!/bin/bash

# Authentication
CHAT_ID=""
TOKEN=""
URL="https://api.telegram.org/bot${TOKEN}/sendMessage"
# Message
DOCKERPS=$(docker ps --all --format "table {{.Names}}\t{{.State}}")
DOCKERMSG="\n Running containers:\n $DOCKERPS"
IPADDRESS=$(curl ifconfig.me)
IPADDRESSMSG="\n Current IP Address:\n $IPADDRESS\n"
MESSAGE="$DOCKERMSG $IPADDRESSMSG"

curl -s -X POST "${URL}" -d chat_id="${CHAT_ID}" -d text="$(echo -e "$MESSAGE")"
