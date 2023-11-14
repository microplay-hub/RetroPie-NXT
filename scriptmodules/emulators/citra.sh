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

rp_module_id="citra"
rp_module_desc="3ds emulator"
rp_module_help="ROM Extension: .3ds\n\nCopy your 3DS roms to  $romdir/3ds"
rp_module_repo="git https://github.com/slaminger/citra-android"
rp_module_licence="GPL2 https://github.com/citra-emu/citra/blob/master/license.txt"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_citra() {
    if compareVersions $__gcc_version lt 7; then
        md_ret_errors+=("Sorry, you need an OS with gcc 7.0 or newer to compile citra")
        return 1
    fi

    # Additional libraries required for running
    local depends=(libsdl2-dev doxygen qtbase5-dev libqt5opengl5-dev qtmultimedia5-dev build-essential clang clang-format libc++-dev cmake qtbase5-dev libqt5opengl5-dev qtmultimedia5-dev)
    getDepends "${depends[@]}"
}

function sources_citra() {
    gitPullOrClone
}

function build_citra() {
    cd "$md_build/citra"
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_QT=ON #for now QT_BUILD disable doesn't compile missing header due the packages for debian/ubuntu doesn't support opengl desktop 3.3 core.
    make
    md_ret_require="$md_build/build/bin/Release"

}

function install_citra() {
      md_ret_files=(
      '/build/bin/Release/citra'
     '/build/bin/Release/citra-qt' 
      
      )

}

function configure_citra() {

    mkRomDir "3ds"
    addEmulator 1 "$md_id" "3ds" "$md_inst/citra %ROM%"
    addEmulator 0 "${md_id}-fullscreen" "3ds" "$md_inst/citra -f %ROM%"
   # addEmulator 0 "$md_id-qt" "3ds" "$md_inst/citra-qt %ROM%"
    addSystem "3ds"

}
