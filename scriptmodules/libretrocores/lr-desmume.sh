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

rp_module_id="lr-desmume"
rp_module_desc="NDS emu - DESMUME"
rp_module_help="ROM Extensions: .nds .zip\n\nCopy your Nintendo DS roms to $romdir/nds"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/desmume/master/desmume/COPYING"
rp_module_repo="git https://github.com/libretro/desmume.git master"
rp_module_section="exp"

function _params_lr-desmume() {
    local params=()
    isPlatform "arm" && params+=("platform=unixarmvhardfloat")
    isPlatform "aarch64" && params+=("DESMUME_JIT=0")
    echo "${params[@]}"
}

function depends_lr-desmume() {
    getDepends libpcap-dev libgl1-mesa-dev
}

function sources_lr-desmume() {
    gitPullOrClone
}

function build_lr-desmume() {
    cd desmume/src/frontend/libretro
    make clean
    make $(_params_lr-desmume)
    md_ret_require="$md_build/desmume/src/frontend/libretro/desmume_libretro.so"
}

function install_lr-desmume() {
    md_ret_files=(
        'desmume/src/frontend/libretro/desmume_libretro.so'
    )
}

function configure_lr-desmume() {
    mkRomDir "nds"
    defaultRAConfig "nds"

    addEmulator 0 "$md_id" "nds" "$md_inst/desmume_libretro.so"
    addSystem "nds"
}
