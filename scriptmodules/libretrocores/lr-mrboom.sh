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

rp_module_id="lr-mrboom"
rp_module_desc="Mr.Boom - 8 players Bomberman clone for libretro."
rp_module_help="8 players Bomberman clone for libretro."
rp_module_licence="MIT https://raw.githubusercontent.com/libretro/mrboom-libretro/master/LICENSE"
rp_module_repo="git https://github.com/libretro/mrboom-libretro.git master"
rp_module_section="opt"

function sources_lr-mrboom() {
    gitPullOrClone
}

function build_lr-mrboom() {
    rpSwap on 1000
    make clean
    if isPlatform "neon"; then
        make HAVE_NEON=1
    else
        make
    fi
    md_ret_require="$md_build/mrboom_libretro.so"
}

function install_lr-mrboom() {
    md_ret_files=(
        'mrboom_libretro.so'
        'LICENSE'
        'README.md'
    )
}


function configure_lr-mrboom() {
    setConfigRoot "ports"

    addPort "$md_id" "mrboom" "Mr.Boom" "$emudir/retroarch/bin/retroarch -L $md_inst/mrboom_libretro.so --config $md_conf_root/mrboom/retroarch.cfg"

    mkRomDir "ports/mrboom"
    defaultRAConfig "mrboom"
}
