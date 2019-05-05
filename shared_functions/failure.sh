#!/usr/bin/env bash

## Ensure the following line precedes calls to this function via trap
##    set -eE -o functrace
## Use the following line to call this function from other scripts
##    trap 'failure ${LINENO} "${BASH_COMMAND}"' ERR
failure(){
    local _lineno="${1}"
    local _msg="${2}"
    local _code="${3:-0}"

    local _msg_height="$(wc -l <<<"${_msg}")"
    if [ "${_msg_height}" -gt '1' ]; then
        printf 'Line: %s\n%s\n' "${_lineno}" "${_msg}"
    else
        printf 'Line: %s - %s\n' "${_lineno}" "${_msg}"
    fi

    if ((_code)); then
        printf 'Exit: %s\n' "${_code}"
    fi
    exit ${_code}
}
