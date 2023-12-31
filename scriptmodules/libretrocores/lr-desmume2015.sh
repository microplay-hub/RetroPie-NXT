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

rp_module_id="lr-desmume2015"
rp_module_desc="NDS emu - DESMUME (2015 version)"
rp_module_help="ROM Extensions: .nds .zip\n\nCopy your Nintendo DS roms to $romdir/nds"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/desmume/master/desmume/COPYING"
rp_module_repo="git https://github.com/libretro/desmume2015.git master"
rp_module_section="exp"

function depends_lr-desmume2015() {
   depends_lr-desmume
}

function sources_lr-desmume2015() {
    gitPullOrClone
}

function build_lr-desmume2015() {
    cd desmume
    make clean
    make $(_params_lr-desmume)
    md_ret_require="$md_build/desmume/desmume2015_libretro.so"
}

function install_lr-desmume2015() {
    md_ret_files=(
        'desmume/desmume2015_libretro.so'
    )
}

function configure_lr-desmume2015() {
    mkRomDir "nds"
    defaultRAConfig "nds"

    addEmulator 0 "$md_id" "nds" "$md_inst/desmume2015_libretro.so"
    addSystem "nds"
}
