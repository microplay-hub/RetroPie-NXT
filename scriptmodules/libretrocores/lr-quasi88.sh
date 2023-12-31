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

rp_module_id="lr-quasi88"
rp_module_desc="NEC PC-8801 emu - Quasi88 port for libretro"
rp_module_help="ROM Extensions: .d88 .88d .cmt .m3u .t88\n\nCopy your pc88 games to to $romdir/pc88\n\nCopy bios files n88.rom, n88_0.rom, n88_1.rom, n88_2.rom, n88_3.rom, n88n.rom, disk.rom, n88knj1.rom, n88knj2.rom, and n88jisho.rom to $biosdir/quasi88"
rp_module_licence="BSD https://raw.githubusercontent.com/libretro/quasi88-libretro/master/LICENSE"
rp_module_repo="git https://github.com/libretro/quasi88-libretro.git master"
rp_module_section="exp"

function sources_lr-quasi88() {
    gitPullOrClone
}

function build_lr-quasi88() {
    make clean
    make
    md_ret_require="$md_build/quasi88_libretro.so"
}

function install_lr-quasi88() {
    md_ret_files=(
        'README.md'
        'quasi88_libretro.so'
    )
}

function configure_lr-quasi88() {
    mkRomDir "pc88"
    defaultRAConfig "pc88"
    addEmulator 1 "$md_id" "pc88" "$md_inst/quasi88_libretro.so"
    addSystem "pc88"
}
