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

rp_module_id="capricerpi"
rp_module_desc="Amstrad CPC emulator - port of Caprice32 for the RPI"
rp_module_help="ROM Extensions: .cdt .cpc .dsk\n\nCopy your Amstrad CPC games to $romdir/amstradcpc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/KaosOverride/CapriceRPI/master/COPYING.txt"
rp_module_repo="git https://github.com/KaosOverride/CapriceRPI.git master"
rp_module_section="opt"
rp_module_flags="sdl1 !all videocore"

function depends_capricerpi() {
    getDepends libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev zlib1g-dev libpng-dev
}

function sources_capricerpi() {
    gitPullOrClone
    sed -i "s/-lpng12/-lpng/" src/makefile
}

function build_capricerpi() {
    cd src
    make clean

    make RELEASE=TRUE
    md_ret_require="$md_build/src/capriceRPI"
}

function install_capricerpi() {
    cp -Rv "$md_build/"{README*.txt,COPYING.txt} "$md_inst/"
    cp -Rv "$md_build/src/capriceRPI" "$md_inst/"
}

function configure_capricerpi() {
    mkRomDir "amstradcpc"

    addEmulator 0 "$md_id" "amstradcpc" "$md_inst/capriceRPI %ROM%"
    addSystem "amstradcpc"
}
