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

rp_module_id="lr-pokemini"
rp_module_desc="Pokemon Mini emulator - PokeMini port for libretro"
rp_module_help="ROM Extensions: .min .zip\n\nCopy your Pokemon Mini roms to $romdir/pokemini"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/PokeMini/master/LICENSE"
rp_module_repo="git https://github.com/libretro/pokemini.git master"
rp_module_section="exp"

function sources_lr-pokemini() {
    gitPullOrClone
}

function build_lr-pokemini() {
    make clean
    make
    md_ret_require="$md_build/pokemini_libretro.so"
}

function install_lr-pokemini() {
    md_ret_files=(
        'pokemini_libretro.so'
    )
}

function configure_lr-pokemini() {
    mkRomDir "pokemini"
    defaultRAConfig "pokemini"

    addEmulator 1 "$md_id" "pokemini" "$md_inst/pokemini_libretro.so"
    addSystem "pokemini"
}
