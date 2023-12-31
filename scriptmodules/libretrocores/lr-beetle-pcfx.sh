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

rp_module_id="lr-beetle-pcfx"
rp_module_desc="PCFX emulator - Mednafen PCFX Port for libretro"
rp_module_help="ROM Extensions: .img .iso .ccd .cue\n\nCopy the required BIOS file pcfx.rom to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-pcfx-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/beetle-pcfx-libretro master"
rp_module_section="exp"

function sources_lr-beetle-pcfx() {
    gitPullOrClone
}

function build_lr-beetle-pcfx() {
    make clean
    make
    md_ret_require="$md_build/mednafen_pcfx_libretro.so"
}

function install_lr-beetle-pcfx() {
    md_ret_files=(
        'mednafen_pcfx_libretro.so'
    )
}

function configure_lr-beetle-pcfx() {
    mkRomDir "pcfx"
    defaultRAConfig "pcfx"

    addEmulator 1 "$md_id" "pcfx" "$md_inst/mednafen_pcfx_libretro.so"
    addSystem "pcfx"
}
