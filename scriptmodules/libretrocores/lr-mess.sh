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

rp_module_id="lr-mess"
rp_module_desc="MESS emulator - MESS Port for libretro"
rp_module_help="see wiki for detailed explanation"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame/master/COPYING"
rp_module_repo="git https://github.com/libretro/mame.git master"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-mess() {
    depends_lr-mame
}

function sources_lr-mess() {
    gitPullOrClone
}

function build_lr-mess() {
    rpSwap on 4096
    local params=($(_get_params_lr-mame) SUBTARGET=mess)
    make clean
    make "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/mamemess_libretro.so"
}

function install_lr-mess() {
    md_ret_files=(
        'COPYING'
        'mamemess_libretro.so'
        'README.md'
        'hash'
    )
}

function configure_lr-mess() {
    local module="$1"
    [[ -z "$module" ]] && module="mamemess_libretro.so"

    local system
    for system in nes gb coleco arcadia crvision; do
        mkRomDir "$system"
        defaultRAConfig "$system"
        addEmulator 0 "$md_id" "$system" "$md_inst/$module"
        addSystem "$system"
    done

    [[ "$md_mode" == "remove" ]] && return

    setRetroArchCoreOption "mame_softlists_enable" "enabled"
    setRetroArchCoreOption "mame_softlists_auto_media" "enabled"
    setRetroArchCoreOption "mame_boot_from_cli" "enabled"

    mkUserDir "$biosdir/mame"
    cp -rv "$md_inst/hash" "$biosdir/mame/"
    chown -R $user:$user "$biosdir/mame"
}