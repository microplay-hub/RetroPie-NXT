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

rp_module_id="opentyrian"
rp_module_desc="Open Tyrian - port of the DOS shoot-em-up Tyrian"
rp_module_licence="GPL2 https://raw.githubusercontent.com/opentyrian/opentyrian/master/COPYING"
rp_module_repo="git https://github.com/opentyrian/opentyrian.git master"
rp_module_section="opt"
rp_module_flags=""

function depends_opentyrian() {
    getDepends libsdl2-dev libsdl2-net-dev
}

function sources_opentyrian() {
    gitPullOrClone
    # patch to default to fullscreen
    applyPatch "$md_data/01_fullscreen.diff"
}

function build_opentyrian() {
    rpSwap on 512
    make clean
    make
    rpSwap off
    md_ret_require="$md_build/opentyrian"
}

function install_opentyrian() {
    make install prefix="$md_inst"
}

function game_data_opentyrian() {
    if [[ ! -d "$romdir/ports/opentyrian/data" ]]; then
        cd "$__tmpdir"
        # get Tyrian 2.1 (freeware game data)
        downloadAndExtract "$__archive_url/tyrian21.zip" "$romdir/ports/opentyrian/data" -j
        chown -R $user:$user "$romdir/ports/opentyrian"
    fi
}

function configure_opentyrian() {
    addPort "$md_id" "opentyrian" "OpenTyrian" "$md_inst/bin/opentyrian --data $romdir/ports/opentyrian/data"

    mkRomDir "ports/opentyrian"

    moveConfigDir "$home/.config/opentyrian" "$md_conf_root/opentyrian"

    [[ "$md_mode" == "install" ]] && game_data_opentyrian
}
