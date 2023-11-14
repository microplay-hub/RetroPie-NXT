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

rp_module_id="lr-puae"
rp_module_desc="P-UAE Amiga emulator port for libretro"
rp_module_help="ROM Extensions: .adf .uae\n\nCopy your roms to $romdir/amiga and create configs as .uae"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/PUAE/master/COPYING"
rp_module_repo="git https://github.com/libretro/libretro-uae.git master"
rp_module_section="opt"

function sources_lr-puae() {
    gitPullOrClone
}

function build_lr-puae() {
    make
    md_ret_require="$md_build/puae_libretro.so"
}

function install_lr-puae() {
    md_ret_files=(
        'puae_libretro.so'
        'README.md'
    )
}

function configure_lr-puae() {
    mkRomDir "amiga"
    defaultRAConfig "amiga"
    addEmulator 1 "$md_id" "amiga" "$md_inst/puae_libretro.so"
    addSystem "amiga"
}
