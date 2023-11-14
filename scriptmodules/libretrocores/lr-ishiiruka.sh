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

rp_module_id="lr-ishiiruka"
rp_module_desc="Gamecube/Wii emulator - lrishiiruka Dolphin port for libretro"
rp_module_help="ROM Extensions: .gcm .iso .wbfs .ciso .gcz\n\nCopy your gamecube roms to $romdir/gc and Wii roms to $romdir/wii"
rp_module_repo="git https://github.com/libretro/Ishiiruka"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/ishiiruka/master/license.txt"
rp_module_section="lr"
rp_module_flags="!arm"

function depends_lr-ishiiruka() {
    depends_dolphin
	
	if isPlatform "odroid-n2"; then
	/home/aresuser/ARES-Setup/fixmali.sh
    elif isPlatform "rockpro64"; then
    /usr/lib/arm-linux-gnueabihf/install_mali.sh
	fi
}

function sources_lr-ishiiruka() {
    gitPullOrClone
}

function build_lr-ishiiruka() {
    if isPlatform "jetson-nano"; then
	cmake . -DLIBRETRO=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-7 -DCMAKE_C_COMPILER=gcc-7
    make clean
    make
	else cmake . -DLIBRETRO=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-8 -DCMAKE_C_COMPILER=gcc-8
	make clean
	make
    fi	
    md_ret_require="Binaries/ishiiruka_libretro.so"
}

function install_lr-ishiiruka() {
    md_ret_files=(
        'Binaries/ishiiruka_libretro.so'
        'Binaries/ishiiruka-nogui'
    )
}

function configure_lr-ishiiruka() {
    mkRomDir "gc"
    mkRomDir "wii"

    ensureSystemretroconfig "gc"
    ensureSystemretroconfig "wii"

    addEmulator 1 "$md_id" "gc" "$md_inst/ishiiruka_libretro.so"
    addEmulator 1 "$md_id" "wii" "$md_inst/ishiiruka_libretro.so"

    addSystem "gc"
    addSystem "wii"
}
