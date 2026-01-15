#!/usr/bin/env zsh

albumfetch() {

    setopt local_options extended_glob null_glob

    local logos_dir="${HOME}/.config/fastfetch/logos"
    local default_logo="${logos_dir}/_default.png" 
    local logo=""

    local album_now=$(playerctl -p spotify metadata album 2>/dev/null)
    local pstatus=$(playerctl status 2>/dev/null)

    if [[ -n "$album_now" && ("$pstatus" == "Playing" || "$pstatus" == "Paused") ]]; then
        local clean_name="${album_now%% \(*}"
        clean_name="${${clean_name}//[ >]/_}"

        # echo "$clean_name"  #debug

        local match=($logos_dir/(#i)${clean_name}.*)
        if (( $#match > 0 )); then
            logo="${match[1]}"
        fi
    fi

    if [[ -z "$logo" ]]; then     # no match = random logo
        local all_logos=($logos_dir/*(N))
        if (( $#all_logos > 0 )); then
            logo="${all_logos[$((RANDOM % $#all_logos + 1))]}"
        fi
    fi

    if [[ -f "$logo" ]]; then
        fastfetch --logo "$logo" --logo-type chafa --logo-width 35
    else
        fastfetch
    fi
}