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

rp_module_id="lr-lutro"
rp_module_desc="Lua engine - lua game framework (WIP) for libretro following the LÖVE API"
rp_module_help="ROM Extensions: .lutro .lua"
rp_module_repo="git https://github.com/libretro/libretro-lutro.git"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/libretro-lutro/master/LICENSE"
rp_module_section="lr"
rp_module_flags="!aarch64"

function sources_lr-lutro() {
    gitPullOrClone
}

function build_lr-lutro() {
    make clean
    make 
    md_ret_require="$md_build/lutro_libretro.so"
}

function install_lr-lutro() {
    md_ret_files=(
	'lutro_libretro.so'
    )
}

function configure_lr-lutro() {
    	
    addEmulator 1 "$md_id" "lutro" "$md_inst/lutro_libretro.so"
    addSystem "lutro"
	
    mkRomDir "lutro"
    ensureSystemretroconfig "lutro"
}