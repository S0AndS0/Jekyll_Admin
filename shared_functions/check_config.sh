#!/usr/bin/env bash

## Zombi-Code!

## Hint this can print itself via something like...
##  check_from_to 'check_from_to()' '^}' 'thisFile.sh' 'print'
## ... or output matching line numbers '5,42' via...
##  check_from_to 'check_from_to()' '^}' 'thisFile.sh' 'lines'
check_from_to(){
    local _search_start="${1:?No search start parameters provided}"
    local _search_end="${2:?No search end parameters provided}"
    local _file_path="${3:?No config path provided}"
    local _output_format="${4:-lines}"
    if ! [ -f "${_file_path}" ]; then
        printf 'No file found at: %s\n' "${_file_path}" >&2
        return 1
    fi

    local _last_line_checked='0'
    local _max_line_number="$(wc -l <<<"$(<"${_file_path}")")"
    until [[ "${_max_line_number}" -le "${_last_line_checked}" ]]; do
        local _start_line_number="$(grep -nE -- "${_search_start}" "${_file_path}" | head -1 | awk -F':' '{print $1}')"
        local _till_line_count="$(gawk -v _s="${_search_start}" -v _e="${_search_end}" '$0 ~ _s, $0 ~ _e {print} {if ($0 ~ _s) _t=1} {if ($0 ~ _e && _t==1) exit}' "${_file_path}" | wc -l)"
        local _end_line_number="$(( ${_start_line_number} + (${_till_line_count}-1) ))"
        ## Bellow matches one extra line
        # _end_line_number="$(( ${_start_line_number} + ${_till_line_count} ))"
        if [[ "${_end_line_number}" == "${_last_line_checked}" ]]; then
            break
        elif [ -z "${_start_line_number}" ] || [ -z "${_end_line_number}" ]; then
            break
        fi
        _last_line_checked="${_end_line_number}"
        case "${_output_format,,}" in
            'lines')
                local _output="${_start_line_number},${_end_line_number}"
            ;;
            *)
                local _output="$(sed -n "${_start_line_number},${_end_line_number}p" "${_file_path}")"
            ;;
        esac
        printf '%s\n' "${_output}"
    done
}
