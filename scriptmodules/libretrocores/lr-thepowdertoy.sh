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

rp_module_id="lr-thepowdertoy"
rp_module_desc="Sandbox physics game for libretro"
rp_module_help="Have you ever wanted to blow something up? Or maybe you always dreamt of operating an atomic power plant? Do you have a will to develop your own CPU? The Powder Toy lets you to do all of these, and even more!"
rp_module_repo="git https://github.com/libretro/ThePowderToy.git"
rp_module_licence="GPL3 https://github.com/libretro/thepowdertoy-libretro/blob/master/LICENSE"
rp_module_section="exp"

function sources_lr-thepowdertoy() {
    gitPullOrClone
}

function build_lr-thepowdertoy() {
    mkdir build && cd build
	cmake ..
    make 
    md_ret_require="$md_build/build/src/thepowdertoy_libretro.so"
}

function install_lr-thepowdertoy() {
    md_ret_files=(
        'README.md'
        '/build/src/thepowdertoy_libretro.so'
    )
}

function configure_lr-thepowdertoy() {
	setConfigRoot "ports"

    addPort "$md_id" "thepowdertoy" "The Powder Toy" "$md_inst/thepowdertoy_libretro.so"

    mkRomDir "ports/thepowdertoy"
    ensureSystemretroconfig "ports/thepowdertoy"

    cp -Rv "$md_inst/thepowdertoy" "$romdir/ports"

    chown $user:$user -R "$romdir/ports/thepowdertoy"
}
