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

rp_module_id="smw"
rp_module_desc="Super Mario War"
rp_module_licence="GPL http://supermariowar.supersanctuary.net/"
rp_module_repo="git https://github.com/HerbFargus/Super-Mario-War.git master"
rp_module_section="opt"
rp_module_flags="sdl1 !mali"

function depends_smw() {
    getDepends libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev
}

function sources_smw() {
    gitPullOrClone
}

function build_smw() {
    ./configure --prefix="$md_inst"
    make clean
    make
    md_ret_require="$md_build/smw"
}

function install_smw() {
    make install
}

function configure_smw() {
    addPort "$md_id" "smw" "Super Mario War" "$md_inst/smw"

    [[ "$md_mode" == "remove" ]] && return

    isPlatform "dispmanx" && setBackend "$md_id" "dispmanx"

    moveConfigFile "$home/.smw.options.bin" "$md_conf_root/smw/.smw.options.bin"
}
