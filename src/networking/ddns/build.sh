#!/bin/bash -eu

SCRIPT_PATH="$(dirname $0)"
SRC_PATH="${SCRIPT_PATH}/../.."
RESOURCES_PATH="${SCRIPT_PATH}/sources"

DUCKDNS="${RESOURCES_PATH}/duckdns.sh"
CONFIG="${RESOURCES_PATH}/duckdns.cfg"
SERVICENAME="duckdns.service"
SERVICE="${RESOURCES_PATH}/${SERVICENAME}"
TIMERNAME="duckdns.timer"
TIMER="${RESOURCES_PATH}/${TIMERNAME}"
SYSTEMD_PATH="/etc/systemd/system"

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

# Configure script parameters and set logging path
function script_configuration() {
  # Copy script to host destination
  cp "$DUCKDNS" "$DESTINATION"
  replace_placeholder "domain" "$DOMAINS" "$DESTINATION" || return 1
  replace_placeholder "token" "$TOKEN" "$DESTINATION" || return 1
  chmod 744 "$DESTINATION"
  # Create log path
  mkdir -p "$LOGGING"
}

# Install service and timer. Enabling periodical execution
function enable_service() {
  cp "${SERVICE}" "${SYSTEMD_PATH}/${SERVICENAME}"
  cp "${TIMER}" "${SYSTEMD_PATH}/${TIMERNAME}"
  systemctl daemon-reload
  systemctl enable --now "${TIMERNAME}"
}

# Main function
function main() {
  echo 'Setting up Dynamic DNS: DuckDNS...'

  # This script must be executed with root priviledges
  is_root || return 1

  # Check if dependencies are installed
  is_installed "curl" || return 1

  # Configure script logging paths as well as parameters
  script_configuration || return 1

  # Set execution periodically
  enable_service || return 1

  # Test script execution
  test_ddns || return 1

  echo 'Setting up Dynamic DNS: DuckDNS... done'
}

main
