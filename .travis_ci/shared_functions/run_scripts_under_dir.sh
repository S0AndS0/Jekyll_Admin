#!/usr/bin/env bash


run_scripts_under_dir(){
    local _dir_path="${1}"
    local -n _script_list_ref="${2}"

    for _script_name in "${_script_list_ref[@]}"; do
        local _script_path="${_dir_path}/${_script_name}"
        if ! [ -f "${_script_path}" ]; then
            return 1
        fi

        if ! [ -f "${_script_path}" ]; then
            printf 'Warning - chmod u+x "%s"\n' "${_script_path}"
            chmod u+x "${_script_path}"
        fi

        bash "${_script_path}" || return "${?}"
    done

    printf '%s finished\n' "${FUNCNAME[0]}"
}
