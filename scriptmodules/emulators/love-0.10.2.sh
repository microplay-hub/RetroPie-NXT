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

rp_module_id="love-0.10.2"
rp_module_desc="Love - 2d Game Engine v0.10.2"
rp_module_help="Copy your Love games to $romdir/love"
rp_module_repo="git https://github.com/love2d/love 0.10.2"
rp_module_licence="ZLIB https://raw.githubusercontent.com/love2d/love/0.10.2/license.txt"
rp_module_section="exp"
rp_module_flags=""

function depends_love-0.10.2() {
    depends_love

}

function sources_love-0.10.2() {
    gitPullOrClone
    # libluajit-5.1-dev in buster (and also on Ubuntu 18.04+) still has
    # LUA_VERSION_NUM defined as 501 but requires the newer luaL_Reg named struct.
    # adjusting the compatibility code #if to check for LUA_VERSION_NUM >= 501 fixes this.
    sed -i "s/LUA_VERSION_NUM > 501/LUA_VERSION_NUM >= 501/" "$md_build/src/libraries/luasocket/libluasocket/lua.h"
}

function build_love-0.10.2() {
    build_love
}

function install_love-0.10.2() {
    install_love
}

function game_data_love-0.10.2() {
    game_data_love
}

function configure_love-0.10.2() {
    configure_love
}
