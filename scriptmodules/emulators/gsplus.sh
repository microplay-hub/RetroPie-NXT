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

rp_module_id="gsplus"
rp_module_desc="Apple 2 GS emulator GSplus a modern sdl2 fork of gsport (alpha)"
rp_module_help="ROM Extensions: .gsp\n\nCopy your Apple 2 GS games to $romdir/apple2gs Note The Developer considers this to be an alpha build. Expect bugs Known issue: some games do not detect the emulated joystick"
rp_module_repo="git https://github.com/digarok/gsplus.git"
rp_module_licence="GPL2 https://raw.githubusercontent.com/digarok/gsplus/master/LICENSE.txt"
rp_module_section="exp"

function depends_gsplus() {
    getDepends libpcap0.8-dev libfreetype6-dev libsdl2-dev libsdl2-image-dev re2c libreadline-dev
		
}

function sources_gsplus() {
    gitPullOrClone "$md_build" 
}

function build_gsplus() {
    if isPlatform "arm"; then
        cp "$md_data/vars_armv7-a_sdl2" "$md_build/src/vars"
    elif isPlatform "aarch64"; then
        cp "$md_data/vars_aarch64_sdl2" "$md_build/src/vars"
    fi
    mkdir build
    cd build
    cmake ..
    make
}

function install_gsplus() {
    md_ret_files=(
        '/build/bin/GSplus'
    )
}

function configure_gsplus() {
    mkRomDir "apple2gs"
    mkUserDir "$md_conf_root/apple2gs"
    addEmulator 1 "$md_id" "apple2gs" "$md_inst/GSplus -config %ROM%"
    addSystem "apple2gs"
	
}
