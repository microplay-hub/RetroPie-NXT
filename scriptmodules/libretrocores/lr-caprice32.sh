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

rp_module_id="lr-caprice32"
rp_module_desc="Amstrad CPC emu - Caprice32 port for libretro"
rp_module_help="ROM Extensions: .cdt .cpc .dsk\n\nCopy your Amstrad CPC games to $romdir/amstradcpc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-cap32/master/cap32/COPYING.txt"
rp_module_repo="git https://github.com/libretro/libretro-cap32.git master"
rp_module_section="main"

function sources_lr-caprice32() {
    gitPullOrClone
}

function build_lr-caprice32() {
    make clean
    make
    md_ret_require="$md_build/cap32_libretro.so"
}

function install_lr-caprice32() {
    md_ret_files=(
        'cap32_libretro.so'
    )
}

function configure_lr-caprice32() {
    mkRomDir "amstradcpc"
    defaultRAConfig "amstradcpc"

    setRetroArchCoreOption "cap32_autorun" "enabled"
    setRetroArchCoreOption "cap32_Model" "6128"
    setRetroArchCoreOption "cap32_Ram" "128"
    setRetroArchCoreOption "cap32_combokey" "y"

    addEmulator 1 "$md_id" "amstradcpc" "$md_inst/cap32_libretro.so"
    addSystem "amstradcpc"
}
