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

rp_module_id="lr-quicknes"
rp_module_desc="NES emulator - QuickNES Port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/QuickNES_Core/master/LICENSE"
rp_module_repo="git https://github.com/libretro/QuickNES_Core.git master"
rp_module_section="opt armv6=main"

function sources_lr-quicknes() {
    gitPullOrClone
}

function build_lr-quicknes() {
    make clean
    make
    md_ret_require="$md_build/quicknes_libretro.so"
}

function install_lr-quicknes() {
    md_ret_files=(
        'quicknes_libretro.so'
    )
}

function configure_lr-quicknes() {
    mkRomDir "nes"
    defaultRAConfig "nes"

    local def=0
    isPlatform "armv6" && def=1

    addEmulator "$def" "$md_id" "nes" "$md_inst/quicknes_libretro.so"
    addSystem "nes"
}
