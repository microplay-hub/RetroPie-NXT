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

rp_module_id="lr-beetle-pce-fast"
rp_module_desc="PCEngine emu - Mednafen PCE Fast port for libretro"
rp_module_help="ROM Extensions: .pce .ccd .cue .zip\n\nCopy your PC Engine / TurboGrafx roms to $romdir/pcengine\n\nCopy the required BIOS file syscard3.pce to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-pce-fast-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/beetle-pce-fast-libretro.git master"
rp_module_section="main"

function _update_hook_lr-beetle-pce-fast() {
    # move from old location and update emulators.cfg
    renameModule "lr-mednafen-pce-fast" "lr-beetle-pce-fast"
}

function sources_lr-beetle-pce-fast() {
    gitPullOrClone
}

function build_lr-beetle-pce-fast() {
    make clean
    make
    md_ret_require="$md_build/mednafen_pce_fast_libretro.so"
}

function install_lr-beetle-pce-fast() {
    md_ret_files=(
        'mednafen_pce_fast_libretro.so'
        'COPYING'
        'README.md'
    )
}

function configure_lr-beetle-pce-fast() {
    mkRomDir "pcengine"
    defaultRAConfig "pcengine"

    addEmulator 1 "$md_id" "pcengine" "$md_inst/mednafen_pce_fast_libretro.so"
    addSystem "pcengine"
}
