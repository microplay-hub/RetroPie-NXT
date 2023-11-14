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

rp_module_id="basilisk-sdl2"
rp_module_desc="Macintosh emulator"
rp_module_help="ROM Extensions: .img .rom\n\nCopy your Macintosh roms mac.rom and disk.img to $romdir/macintosh"
rp_module_repo="git https://github.com/DavidLudwig/macemu.git"
rp_module_licence="GPL2 https://raw.githubusercontent.com/cebix/macemu/master/BasiliskII/COPYING"
rp_module_section="exp"
rp_module_flags="!dispmanx"

function depends_basilisk-sdl2() {
    local depends=(libsdl1.2-dev autoconf automake oss-compat)
    isPlatform "x11" && depends+=(libgtk2.0-dev)
    getDepends "${depends[@]}"

}

function sources_basilisk-sdl2() {
    gitPullOrClone

}

function build_basilisk-sdl2() {
    cd BasiliskII/src/Unix
    cp /usr/share/misc/config.guess "$md_build/BasiliskII/src/Unix/"
    cp /usr/share/misc/config.sub "$md_build/BasiliskII/src/Unix/"
    local params=(--enable-sdl-video --enable-sdl-audio --disable-vosf --without-mon --without-esd)
    ! isPlatform "x86" && params+=(--disable-jit-compiler)
    ! isPlatform "x11" && params+=(--without-x --without-gtk)
    ./autogen.sh --prefix="$md_inst" "${params[@]}"
    make clean
    make
    md_ret_require="$md_build/BasiliskII/src/Unix/BasiliskII"
}

function install_basilisk-sdl2() {
    cd "BasiliskII/src/Unix"
    make install
}

function configure_basilisk-sdl2() {
    mkRomDir "macintosh"
    touch "$romdir/macintosh/Start.txt"

    mkUserDir "$md_conf_root/macintosh"

    addEmulator 1 "$md_id" "macintosh" "$md_inst/bin/BasiliskII --rom $romdir/macintosh/mac.rom --disk $romdir/macintosh/disk.img --extfs $romdir/macintosh --config $md_conf_root/macintosh/basiliskii.cfg"
    addSystem "macintosh"
	
}
