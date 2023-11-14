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

rp_module_id="lr-vice-xvic"
rp_module_desc="C64 / C128 / PET / Plus4 / VIC20 emulator - port of VICE for libretro"
rp_module_help="ROM Extensions: .cmd .crt .d64 .d71 .d80 .d81 .g64 .m3u .prg .t64 .tap .x64 .zip .vsf\n\nCopy your games to $romdir/c64"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vice-libretro/master/vice/COPYING"
rp_module_repo="git https://github.com/libretro/vice-libretro.git master"
rp_module_section="opt"
rp_module_flags=""


function sources_lr-vice-xvic() {
    gitPullOrClone
}

function build_lr-vice-xvic() {
    make -f Makefile clean
    make -f Makefile EMUTYPE=xvic
    md_ret_require="$md_build/vice_xvic_libretro.so"
}

function install_lr-vice-xvic() {
    md_ret_files=(
        'vice/data'
        'vice/COPYING'
        'vice_xvic_libretro.so'
    )
}

function configure_lr-vice-xvic() {
    mkRomDir "vic20"
    ensureSystemretroconfig "vic20"

    cp -R "$md_inst/data" "$biosdir"
    chown -R $user:$user "$biosdir/data"

    addEmulator 1 "$md_id" "vic20" "$md_inst/vice_xvic_libretro.so"
    addSystem "vic20"
	
}
