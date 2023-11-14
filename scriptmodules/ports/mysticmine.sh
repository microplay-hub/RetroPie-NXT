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

rp_module_id="mysticmine"
rp_module_desc="Mystic Mine - Rail game for up to six players on one keyboard"
rp_module_licence="MIT https://raw.githubusercontent.com/dewitters/MysticMine/master/LICENSE.txt"
rp_module_repo="git https://github.com/dewitters/MysticMine.git master"
rp_module_section="exp"

function depends_mysticmine() {
    getDepends python-pyrex python-numpy python-pygame
}

function sources_mysticmine() {
    gitPullOrClone
}

function build_mysticmine() {
    make
}

function install_mysticmine() {
    python2 setup.py install --prefix "$md_inst"
}

function configure_mysticmine() {
    addPort "$md_id" "mysticmine" "MysticMine" "pushd $md_inst; PYTHONPATH=$PYTHONPATH:${md_inst}/lib/python2.7/site-packages ./bin/MysticMine; popd"
}
