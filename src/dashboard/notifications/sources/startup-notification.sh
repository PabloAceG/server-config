#!/bin/bash

# Authentication
CHAT_ID=""
TOKEN=""
MSGAPI="https://api.telegram.org/bot${TOKEN}/sendMessage"

# Message
NODENAME=$(cat /etc/hostname)
NODENAMEMSG="<b><u>Node Name</u></b>\n<pre>${NODENAME}</pre>\n"

IPADDRESS=$(curl ifconfig.me)
IPADDRESSMSG="\n<b><i>Current IP Address</i></b>\n${IPADDRESS}\n"

DOCKERPS=$(docker ps --all --format "table {{.Names}}\t{{.State}}")
DOCKERMSG="\n<b><i>Docker Containers Status</i></b>\n<pre>${DOCKERPS}</pre>\n"

VMLIST=$(qm list | awk '{ $4=$5=$6=""; print $0 }' | column -t)
VMLISTMSG="\n<b><i>VMs Status</i></b>\n<pre>${VMLIST}</pre>\n"

DISKUSG=$(df -h -x squashfs -x tmpfs -x devtmpfs --output=source,size,pcent,avail)
DISKUSGMSG="\n<b><i>Disk Statistics</i></b>\n<pre>${DISKUSG}</pre>\n"

MESSAGE="${NODENAMEMSG} ${IPADDRESSMSG} ${DOCKERMSG} ${VMLISTMSG} ${DISKUSGMSG}"

curl -s -X POST "${MSGAPI}" \
    -d chat_id="${CHAT_ID}" \
    -d text="$(echo -e "$MESSAGE")" \
    -d parse_mode=html
