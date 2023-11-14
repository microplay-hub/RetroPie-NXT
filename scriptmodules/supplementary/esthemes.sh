#!/usr/bin/env bash

# This file is part of the microplay-hub Project
# Own Scripts useable for RetroPie and offshoot
#
# The microplay-hub Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the main directory of this distribution and
#
# The Core script is based on The RetroPie Project https://retropie.org.uk Modules
##

rp_module_id="esthemes"
rp_module_desc="Install themes for Emulation Station"
rp_module_section="config"

function depends_esthemes() {
    if isPlatform "x11"; then
        getDepends feh
    else
        getDepends fbi
    fi
}

function _has_pixel_pos_esthemes() {
    local pixel_pos=0
    # get the version of emulationstation installed so we can check whether to show
    # themes that use the new pixel based positioning - we run as $user as the
    # emulationstation launch script will exit if run as root
    local es_ver="$(sudo -u $user /usr/bin/emulationstation --help | grep -oP "Version \K[^,]+")"
    # if emulationstation is newer than 2.10, enable pixel based themes
    compareVersions "$es_ver" ge "2.10" && pixel_pos=1
    echo "$pixel_pos"
}

function install_theme_esthemes() {
    local theme="$1"
    local repo="$2"
    local branch="$3"

    local pixel_pos="$(_has_pixel_pos_esthemes)"

    if [[ -z "$repo" ]]; then
        repo="RetroPie"
    fi

    if [[ -z "$theme" ]]; then
        theme="carbon"
        repo="RetroPie"
        [[ "$pixel_pos" -eq 1 ]] && theme+="-2021"
    fi

    local name="$theme"

    if [[ -z "$branch" ]]; then
        # Get the name of the default branch, fallback to 'master' if not found
        branch=$(runCmd git ls-remote --symref --exit-code "https://github.com/$repo/es-theme-$theme.git" HEAD | grep -oP ".*/\K[^\t]+")
        [[ -z "$branch" ]] && branch="master"
    else
        name+="-$branch"
    fi

    mkdir -p "/etc/emulationstation/themes"
    gitPullOrClone "/etc/emulationstation/themes/$name" "https://github.com/$repo/es-theme-$theme.git" "$branch"
}

function uninstall_theme_esthemes() {
    local theme="$1"
    if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
        rm -rf "/etc/emulationstation/themes/$theme"
    fi
}

function gui_esthemes() {
    local themes=()

    local pixel_pos="$(_has_pixel_pos_esthemes)"

    if [[ "$pixel_pos" -eq 1 ]]; then
        themes+=(
            'RetroPie carbon-2021'
            'RetroPie carbon-2021 centered'
            'RetroPie carbon-2021 nometa'
        )
    fi

    local themes+=(  
        'AndreaMav arcade-crt'
        'AndreaMav arcade-crt2020'
        'RetroPie carbon'
        'RetroPie carbon-centered'
        'RetroPie carbon-nometa'
        'TMNTturtleguy ComicBook'
        'TMNTturtleguy ComicBook_4-3'
        'TMNTturtleguy ComicBook_SE-Wheelart'
        'TMNTturtleguy ComicBook_4-3_SE-Wheelart'
        'chicueloarcade Chicuelo'
        'FlyingTomahawk futura-V'
        'FlyingTomahawk futura-dark-V'
        'ruckage famicom-mini'
        'ehettervik pixel'
        'ehettervik pixel-metadata'
        'ehettervik pixel-tft'
        'lostless playstation'
        'free-gen psx-mini'
        'mattrixk metapixel'
        'SuperMagicom nostalgic'
        'ruckage nes-mini'
        'nickearl retrowave'
        'nickearl retrowave_4_3'
        'lipebello retrorama'
        'lipebello retrorama-turbo'
        'lipebello strangerstuff'
        'lipebello spaceoddity'
        'lipebello spaceoddity-43'
        'lipebello spaceoddity-wide'
        'lipebello swineapple'
        'ruckage snes-mini'
        'lilbud switch'
        'coinjunkie synthwave'
        'mrharias superdisplay'
        'HerbFargus tronkyfran'
    )
    while true; do
        local theme
        local theme_dir
        local branch
        local name

        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local gallerydir="/etc/emulationstation/es-theme-gallery"
        if [[ -d "$gallerydir" ]]; then
            status+=("i")
            options+=(G "View or Update Theme Gallery")
        else
            status+=("n")
            options+=(G "Download Theme Gallery")
        fi

        options+=(U "Update all installed themes")

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            branch="${theme[2]}"
            name="$repo/$theme"
            theme_dir="$theme"
            if [[ -n "$branch" ]]; then
                name+=" ($branch)"
                theme_dir+="-$branch"
            fi
            if [[ -d "/etc/emulationstation/themes/$theme_dir" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $name (installed)")
                installed_themes+=("$theme $repo $branch")
            else
                status+=("n")
                options+=("$i" "Install $name")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            G)
                if [[ "${status[0]}" == "i" ]]; then
                    options=(1 "View Theme Gallery" 2 "Update Theme Gallery" 3 "Remove Theme Gallery")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for gallery" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            cd "$gallerydir"
                            if isPlatform "x11"; then
                                feh --info "echo %f" --slideshow-delay 6 --fullscreen --auto-zoom --filelist images.list
                            else
                                fbi --timeout 6 --once --autozoom --list images.list
                            fi
                            ;;
                        2)
                            gitPullOrClone "$gallerydir" "https://github.com/wetriner/es-theme-gallery"
                            ;;
                        3)
                            if [[ -d "$gallerydir" ]]; then
                                rm -rf "$gallerydir"
                            fi
                            ;;
                    esac
                else
                    gitPullOrClone "$gallerydir" "http://github.com/wetriner/es-theme-gallery"
                fi
                ;;
            U)
                for theme in "${installed_themes[@]}"; do
                    theme=($theme)
                    rp_callModule esthemes install_theme "${theme[0]}" "${theme[1]}" "${theme[2]}"
                done
                ;;
            *)
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
                branch="${theme[2]}"
                name="$repo/$theme"
                theme_dir="$theme"
                if [[ -n "$branch" ]]; then
                    name+=" ($branch)"
                    theme_dir+="-$branch"
                fi
                if [[ "${status[choice]}" == "i" ]]; then
                    options=(1 "Update $name" 2 "Uninstall $name")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 60 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            rp_callModule esthemes install_theme "$theme" "$repo" "$branch"
                            ;;
                        2)
                            rp_callModule esthemes uninstall_theme "$theme_dir"
                            ;;
                    esac
                else
                    rp_callModule esthemes install_theme "$theme" "$repo" "$branch"
                fi
                ;;
        esac
    done
}
