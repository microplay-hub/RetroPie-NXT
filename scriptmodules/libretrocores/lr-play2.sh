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

rp_module_id="lr-play2"
rp_module_desc="Play! libretro emulator play 2"
rp_module_help="ROM Extensions: .iso\n\nCopy your playstation 2 roms to $romdir/ps2"
rp_module_repo="git https://github.com/jpd002/Play- master"
rp_module_licence="BSD https://github.com/jpd002/Play-/blob/master/License.txt"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_play2() {
    local depends=(cmake libsqlite3-dev libcurl4-openssl-dev libgl1-mesa-dev libglu1-mesa-dev libalut-dev libevdev-dev libgles2-mesa-dev)
    getDepends "${depends[@]}"
}

function sources_lr-play2() {
    gitPullOrClone
    git submodule update -q --init --recursive

}

function build_lr-play2() {
    if isPlatform "jetson-nano"; then
		cmake . -DBUILD_PLAY=OFF -DUSE_GLES=OFF -DBUILD_LIBRETRO_CORE=ON
	else
		cmake . -DBUILD_PLAY=OFF -DUSE_GLES=ON -DBUILD_LIBRETRO_CORE=ON
	fi 
    make clean
    make
    md_ret_require="$md_build/Source/ui_libretro/play_libretro.so"
}

function install_lr-play2() {
    md_ret_files=('Source/ui_libretro/play_libretro.so')
}

function configure_lr-play2() {
    mkRomDir "ps2"
    addEmulator 1 "$md_id" "ps2" "$md_inst/play_libretro.so" "%ROM%"
    addSystem "ps2"
}