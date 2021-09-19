#!/bin/bash -eu

SCRIPT_PATH="$(dirname $0)"
SRC_PATH="${SCRIPT_PATH}/.."
RESOURCES_PATH="${SCRIPT_PATH}/sources"

DUCKDNS="${RESOURCES_PATH}/duckdns.sh"
CONFIG="${RESOURCES_PATH}/duckdns.cfg"
TIMERNAME="duckdns.timer"
TIMER="${RESOURCES_PATH}/${TIMERNAME}"

DESTINATION="/usr/local/bin/duckdns.sh"
LOGGING="/var/log/duckdns"

source "${SRC_PATH}/utils.sh"
source "${CONFIG}"

# Test connection to DuckDNS AWS service
function test_ddns() {
  echo '    Testing if script can be executed...'

  # Execute script
  $DESTINATION >/dev/null 2>&1 || return 1

  local status
  status="$(cat "${LOGGING}/duckdns.log")"
  if [[ $status == "KO" ]]; then
    echo "[ERROR]: DuckDNS failed..."
    echo "[ERROR]: Check that DOMAINS and TOKEN are correct in ${CONFIG} file"
    echo "[ERROR]: or substitute them directly in ${DESTINATION}"
    return 1
  fi

  echo '    Testing if script can be executed... done'
}

# Main function
function main() {
  echo 'Setting up Dynamic DNS: DuckDNS...'

  # This script must be executed with root priviledges
  is_root || return 1

  # Check if dependencies are installed
  is_installed "curl" || return 1

  # Copy script to host destination
  cp "$DUCKDNS" "$DESTINATION"
  replace_placeholder "domain" "$DOMAINS" "$DESTINATION" || return 1
  replace_placeholder "token" "$TOKEN" "$DESTINATION" || return 1
  chmod 744 "$DESTINATION"
  # Create log path
  mkdir -p "$LOGGING"

  # Set execution periocidity
  cp "${TIMER}" "/etc/systemd/system/${TIMERNAME}"

  # Test script execution
  test_ddns || return 1

  echo 'Setting up Dynamic DNS: DuckDNS... done'
}

main
