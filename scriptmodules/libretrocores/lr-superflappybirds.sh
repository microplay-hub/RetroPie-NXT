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

rp_module_id="lr-superflappybirds"
rp_module_desc="Super Flappy Birds - Multiplayer Flappy Bird Clone"
rp_module_help="https://github.com/IgniparousTempest/libretro-superflappybirds/wiki"
rp_module_licence="GPL3 https://raw.githubusercontent.com/IgniparousTempest/libretro-superflappybirds/master/LICENSE"
rp_module_repo="git https://github.com/IgniparousTempest/libretro-superflappybirds.git master"
rp_module_section="exp"

function depends_lr-superflappybirds() {
    getDepends cmake
}

function sources_lr-superflappybirds() {
    gitPullOrClone
}

function build_lr-superflappybirds() {
    cmake .
    make
    md_ret_require="$md_build/superflappybirds_libretro.so"
}

function install_lr-superflappybirds() {
    md_ret_files=(
        'superflappybirds_libretro.so'
        'resources'
        'LICENSE'
        'README.md'
    )
}

function configure_lr-superflappybirds() {
    setConfigRoot "ports"

    addPort "$md_id" "superflappybirds" "Super Flappy Birds" "$md_inst/superflappybirds_libretro.so"

    defaultRAConfig "superflappybirds"
}
