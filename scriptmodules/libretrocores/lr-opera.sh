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

rp_module_id="lr-opera"
rp_module_desc="3DO emulator - fork of 4DO/FreeDO for libretro"
rp_module_help="ROM Extension: .cue .chd .iso .zip\n\nCopy your 3do roms to $romdir/3do\n\nCopy the required BIOS file panazf10.bin to $biosdir"
rp_module_licence="LGPL https://raw.githubusercontent.com/libretro/opera-libretro/master/libopera/opera_3do.c"
rp_module_repo="git https://github.com/libretro/opera-libretro.git master"
rp_module_section="exp"

function sources_lr-opera() {
    gitPullOrClone
}

function _update_hook_lr-opera() {
     renameModule "lr-4do" "lr-opera"
}

function build_lr-opera() {
    make clean
    make
    md_ret_require="$md_build/opera_libretro.so"
}

function install_lr-opera() {
    md_ret_files=(
        'opera_libretro.so'
    )
}

function configure_lr-opera() {
    mkRomDir "3do"
    defaultRAConfig "3do"

    addEmulator 1 "$md_id" "3do" "$md_inst/opera_libretro.so"
    addSystem "3do"
}
