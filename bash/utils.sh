#!/bin/bash

log() {
  echo -e "\033[1;32m[+] $1\033[0m"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

detect_os() {
  case "$OSTYPE" in
    darwin*) echo "macos" ;;
    linux*) 
      if grep -qi debian /etc/os-release; then echo "debian"
      elif grep -qi arch /etc/os-release; then echo "arch"
      else echo "unknown"; fi
      ;;
    *) echo "unknown" ;;
  esac
}

create_symlink() {
    local source_path=$1
    local target_path=$2

    if [ -L "${target_path}" ] && [ "$(readlink "${target_path}")" = "${source_path}" ]; then
        log "Symlink already exists for ${target_path}"
        return
    fi

    if [ -e "${target_path}" ]; then
        log "Backing up existing file or directory at ${target_path}"
        mv "${target_path}" "${target_path}.bak"
    fi

    log "Creating symlink for ${target_path}"
    ln -s "${source_path}" "${target_path}"
}
