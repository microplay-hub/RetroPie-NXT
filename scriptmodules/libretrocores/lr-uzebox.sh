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

rp_module_id="lr-uzem"
rp_module_desc="Uzebox engine - Uzem port for libretro"
rp_module_help="ROM Extensions: .uze\n\nCopy your ROM files to $romdir/ports/uzebox"
rp_module_repo="git https://github.com/libretro/libretro-uzem.git"
rp_module_licence="GPL3 https://raw.githubusercontent.com/Uzebox/uzebox/master/gpl-3.0.txt"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-uzem() {
    gitPullOrClone 
}

function build_lr-uzem() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro 
    md_ret_require="$md_build/uzem_libretro.so"
}

function install_lr-uzem() {
    md_ret_files=(
        'uzem_libretro.so'
    )
}

function configure_lr-uzem() {
    
	addEmulator 1 "$md_id" "uzebox" "$md_inst/uzem_libretro.so"
    addSystem "uzebox"
	
    mkRomDir "uzebox"
    ensureSystemretroconfig "uzebox"
}