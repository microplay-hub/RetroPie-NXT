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

rp_module_id="lr-tgbdual"
rp_module_desc="Gameboy Color emu - TGB Dual port for libretro"
rp_module_help="ROM Extensions: .gb .gbc .zip\n\nCopy your GameBoy roms to $romdir/gb\n\nCopy your GameBoy Color roms to $romdir/gbc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/tgbdual-libretro/master/docs/COPYING-2.0.txt"
rp_module_repo="git https://github.com/libretro/tgbdual-libretro.git master"
rp_module_section="opt"

function sources_lr-tgbdual() {
    gitPullOrClone
}

function build_lr-tgbdual() {
    make clean
    make
    md_ret_require="$md_build/tgbdual_libretro.so"
}

function install_lr-tgbdual() {
    md_ret_files=(
        'tgbdual_libretro.so'
    )
}

function configure_lr-tgbdual() {
    mkRomDir "gbc"
    mkRomDir "gb"
    defaultRAConfig "gb"
    defaultRAConfig "gbc"

    # enable dual / link by default
    setRetroArchCoreOption "tgbdual_gblink_enable" "enabled"

    addEmulator 0 "$md_id" "gb" "$md_inst/tgbdual_libretro.so"
    addEmulator 0 "$md_id" "gbc" "$md_inst/tgbdual_libretro.so"
    addSystem "gb"
    addSystem "gbc"
}
