# Check if the user running the script is root
function is_root() {
  if [ "`id -u`" -ne 0 ]; then
    echo "[ERROR]: Execute this script with root priviledges..."
    return 1
  fi
}

# Check whether a package is installed
# $1: name of package
function is_installed() {
  if [ $# -ne 1 ]; then
    echo "[ERROR]: is_installed - $# is not a valid number of arguments..."
    echo "[ERROR]: is_installed - only need package name"
    return 1
  fi

  if ! command -v $1 1>/dev/null; then
    echo "[ERROR]: $1 is not installed. Please install it before continuing"
    return 1
  fi
}

# Replace placeholder in specified location
# $1: placeholder id, without {{}}
# $2: value of substitution
# $3: path to file of substitution
function replace_placeholder() {
  if [ $# -ne 3 ]; then
    echo "[ERROR]: replace_placeholder - $# is not a valid number of arguments..."
    echo "[ERROR]: replace_placeholder - need:"
    echo "[ERROR]: - path to file where placeholder is going to be replaced"
    echo "[ERROR]: - placeholder id"
    echo "[ERROR]: - value of substitution"
  fi
  sed -i "s/{{ ${1} }}/${2}/g" "$3"
}

