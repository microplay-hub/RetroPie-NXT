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

rp_module_id="lr-mess2016"
rp_module_desc="MESS emulator - MESS Port for libretro"
rp_module_help="see wiki for detailed explanation"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame2016-libretro/master/LICENSE.md"
rp_module_repo="git https://github.com/libretro/mame2016-libretro.git master"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-mess2016() {
    depends_lr-mame2016
}

function sources_lr-mess2016() {
    gitPullOrClone
}

function build_lr-mess2016() {
    rpSwap on 1200
    local params=($(_get_params_lr-mame) SUBTARGET=mess)
    make clean
    make "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/mess2016_libretro.so"
}

function install_lr-mess2016() {
    md_ret_files=(
        'mess2016_libretro.so'
    )
}

function configure_lr-mess2016() {
    configure_lr-mess "mess2016_libretro.so"
}
