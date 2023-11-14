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

rp_module_id="minivmac"
rp_module_desc="Macintosh Plus Emulator"
rp_module_help="ROM Extensions: .dsk \n\nCopy your Macintosh Plus disks to $romdir/macintosh \n\n You need to copy the Macintosh bios file vMac.ROM into "$biosdir" and System Tools.dsk to $romdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/vanfanel/minivmac_sdl2/master/COPYING.txt"
rp_module_repo="git https://github.com/vanfanel/minivmac_sdl2.git master"
rp_module_section="exp"
rp_module_flags=""

function depends_minivmac() {
    getDepends libsdl2-dev
}

function sources_minivmac() {
    gitPullOrClone
    # apply fix for building on gcc 10+
    applyPatch "$md_data/gcc10_fix.diff"
}

function build_minivmac() {
    make
    md_ret_require="$md_build/minivmac"
}

function install_minivmac() {
    md_ret_files=(
        'minivmac'
    )
}

function configure_minivmac() {
    mkRomDir "macintosh"

    ln -sf "$biosdir/vMac.ROM" "$md_inst/vMac.ROM"

    addEmulator 1 "$md_id" "macintosh" "pushd $md_inst; $md_inst/minivmac $romdir/macintosh/System\ Tools.dsk %ROM%; popd"
    addSystem "macintosh"
}