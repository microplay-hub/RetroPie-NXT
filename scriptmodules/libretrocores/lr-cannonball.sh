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

rp_module_id="lr-cannonball"
rp_module_desc="An Enhanced OutRun engine for libretro"
rp_module_help="ROM Extensions: .game .88\n\nYou need to unzip your OutRun set B from latest MAME (outrun.zip) to $romdir/ports/cannonball. They should match the file names listed in the roms.txt file found in the roms folder. You will also need to rename the epr-10381a.132 file to epr-10381b.132 before it will work."
rp_module_repo="git https://github.com/libretro/cannonball.git master"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/cannonball/master/docs/license.txt"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-cannonball() {
    depends_cannonball
}

function sources_lr-cannonball() {
    gitPullOrClone
}

function build_lr-cannonball() {
    > CannonBall.game
    make clean
    make 
    md_ret_require="$md_build/cannonball_libretro.so"
}

function install_lr-cannonball() {
    md_ret_files=(
	'CannonBall.game'
	'cannonball_libretro.so'
    )
}

function game_data_lr-cannonball() {
    downloadAndExtract "http://buildbot.libretro.com/assets/cores/Cannonball/CannonBall.zip" "$romdir/ports/"
    cp -Rv "$md_inst/CannonBall.game" "$romdir/ports/cannonball"
    chown -R $user:$user "$romdir/ports/cannonball"
}

function configure_lr-cannonball() {
    local script
    setConfigRoot "ports"

    addPort "$md_id" "cannonball" "Cannonball - OutRun Engine" "$md_inst/cannonball_libretro.so" "$romdir/ports/cannonball/CannonBall.game"

    if [[ ! -f "$romdir/ports/cannonball" ]]; then
        game_data_lr-cannonball
    fi

    ensureSystemretroconfig "ports/cannonball"
}