#!/usr/bin/env bash


## Outputs Front-Mater formatted failures for functions not returning 0
## Use the following line to call this function from other scripts
##    trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR
failure(){
    local -n _lineno="${1:-LINENO}"
    local -n _bash_lineno="${2:-BASH_LINENO}"
    local _last_command="${3:-${BASH_COMMAND}}"
    local _code="${4:-0}"

    ## Workaround for read EOF combo tripping traps
    if ! ((_code)); then
        return "${_code}"
    fi

    local _last_command_height="$(wc -l <<<"${_last_command}")"

    echo '---'
    cat <<EOF
lines_history: [${_lineno} ${_bash_lineno[*]}]
function_trace: [${FUNCNAME[*]}]
exit_code: ${_code}
EOF

    if [[ "${#BASH_SOURCE[@]}" -gt '1' ]]; then
        printf 'source_trace:\n'
        for _item in "${BASH_SOURCE[@]}"; do
            printf '  - "%s"\n' "${_item}"
        done
    else
        printf 'source_trace: ["%s"]\n' "${BASH_SOURCE[*]}"
    fi

    if [[ "${_last_command_height}" -gt '1' ]]; then
        printf 'last_command: ->\n%s\n' "${_last_command}"
    else
        printf 'last_command: %s\n' "${_last_command}"
    fi

    echo '---'

    exit ${_code}
}
