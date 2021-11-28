#!/bin/bash

# Authentication
CHAT_ID=""
TOKEN=""
URL="https://api.telegram.org/bot${TOKEN}/sendMessage"
# Message
DOCKERPS=$(docker ps --all --format "table {{.Names}}\t{{.State}}")
DOCKERMSG="\n <b><i>Running containers:</i></b><pre>$DOCKERPS</pre>"
IPADDRESS=$(curl ifconfig.me)
IPADDRESSMSG="\n <b><i>Current IP Address</i></b>:\n $IPADDRESS\n"
MESSAGE="$DOCKERMSG $IPADDRESSMSG"

curl -s -X POST "${URL}" \
    -d chat_id="${CHAT_ID}" \
    -d text="$(echo -e "$MESSAGE")"  \
    -d parse_mode=html
