#!/usr/bin/env bash

## Warning this function may remove multiple matching blocks of data
## To ensure compatibility with all of the regex magic grep -E is capable of
##  this function is where the gawk requirement for this script pack is.
remove_from_to(){ ## remove_from_to regex-start regex-stop file-path
    _search_start="${1:?No search start parameters provided}"
    _search_end="${2:?No search end parameters provided}"
    _config_path="${3:?No config path provided}"
    if ! [ -f "${_config_path}" ]; then
        printf 'No configuration file found at: %s\n' "${_config_path}" >&2
        return 1
    fi

    ## Search and destroy configuration lines that match till none are left
    until [[ "$(grep -nE -- "${_search_start}" "${_config_path}" | wc -l)" == '0' ]]; do
        ## Returns first line number search start matches on
        _start_line_number="$(grep -nE -- "${_search_start}" "${_config_path}" | head -1 | awk -F':' '{print $1}')"
        ## Matches from-to (only printing first occurrence) for wc to count lines
        _till_line_count="$(gawk -v _s="${_search_start}" -v _e="${_search_end}" '$0 ~ _s, $0 ~ _e {print} {if ($0 ~ _s) _t=1} {if ($0 ~ _e && _t==1) exit}' "${_config_path}" | wc -l)"
        ## Use gwak to wc line count for offset from start line number
        _end_line_number="$(( ${_start_line_number} + (${_till_line_count}-1) ))"
        ## Above only removes line numbers that match, bellow removes one extra
        # _end_line_number="$(( ${_start_line_number} + ${_till_line_count} ))"
        if [ -n "${_start_line_number}" ]; then
            printf '# sed -i \"%s,%sd\" "%s"\n' "${_start_line_number}" "${_end_line_number}" "${_config_path}"
            sed -i "${_start_line_number},${_end_line_number}d" "${_config_path}"
        fi
    done

    return $?
}
