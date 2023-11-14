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

rp_module_id="lr-supafaust"
rp_module_desc="Super Nintendo emu - Supafaust port for libretro"
rp_module_repo="git https://github.com/libretro/supafaust master"
rp_module_help="ROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_section="exp"

function sources_lr-supafaust() {
    gitPullOrClone
}

function build_lr-supafaust() {
    local params=()
    
    
    make "${params[@]}" clean
	# temporarily disable distcc due to segfaults with cross compiler and lto
    DISTCC_HOSTS="" make "${params[@]}"																		 
    make 
    md_ret_require="$md_build/mednafen_supafaust_libretro.so"
}

function install_lr-supafaust() {
    md_ret_files=(
        'libretro/mednafen_supafaust_libretro.so'
        'docs'
    )
}

function configure_lr-supafaust() {
    local system
    for system in snes sfc sufami snesmsu1 satellaview; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/mednafen_supafaust_libretro.so"
        addSystem "$system"
		
    done
}
