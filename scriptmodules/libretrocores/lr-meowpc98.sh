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

rp_module_id="lr-meowpc98"
rp_module_desc="PC98 emu -  Neko Project II port for libretro"
rp_module_help="ROM Extensions: .d88 .d98 .88d .98d .fdi .xdf .hdm .dup .2hd .tfd .hdi .thd .nhd .hdd\n\nCopy your pc98 games to to $romdir/pc98\n\nCopy bios files 2608_bd.wav, 2608_hh.wav, 2608_rim.wav, 2608_sd.wav, 2608_tom.wav 2608_top.wav, bios.rom, FONT.ROM and sound.rom to $biosdir/meowpc98"
rp_module_repo="git https://github.com/libretro/libretro-meowPC98.git"
rp_module_section="exp"

function sources_lr-meowpc98() {
    gitPullOrClone
}

function build_lr-meowpc98() {
    cd ./libretro
    make
    md_ret_require="$md_build/libretro/nekop2_libretro.so"
}

function install_lr-meowpc98() {
    md_ret_files=(
        'libretro/nekop2_libretro.so'
    )
}

function configure_lr-meowpc98() {
    mkRomDir "pc98"
    ensureSystemretroconfig "pc98"

    addEmulator 1 "$md_id" "pc98" "$md_inst/nekop2_libretro.so"
    addSystem "pc98"
}
