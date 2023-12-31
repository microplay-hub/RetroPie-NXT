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

rp_module_id="omxiv"
rp_module_desc="OpenMAX image viewer for the Raspberry Pi"
rp_module_licence="GPL2 https://raw.githubusercontent.com/cmitu/omxiv/master/LICENSE"
rp_module_repo="git https://github.com/retropie/omxiv.git master"
rp_module_section="depends"
rp_module_flags="!all rpi"

function depends_omxiv() {
    getDepends libraspberrypi-dev libraspberrypi-doc libpng-dev libjpeg-dev
}

function sources_omxiv() {
    gitPullOrClone
}

function build_omxiv() {
    make clean
    make ilclient
    make
    md_ret_require="omxiv.bin"
}

function install_omxiv() {
    make install INSTALL="$md_inst"
}
