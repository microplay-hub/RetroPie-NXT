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

rp_module_id="lr-yabasanshiro"
rp_module_desc="Sega Saturn Emulator"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="https://github.com/devmiyax/yabause/blob/minimum_linux/yabause/COPYING"
rp_module_repo="git https://github.com/libretro/yabause.git yabasanshiro"
rp_module_section="exp"
rp_module_flags="!armv6"

function sources_lr-yabasanshiro() {
    gitPullOrClone
}

function build_lr-yabasanshiro() {
    cd "$md_build/yabause"
    if isPlatform "sun50i-h616"; then
        make -j2 -C yabause/src/libretro/ platform=unix
	elif isPlatform "sun50i-h6"; then
        make -j2 -C yabause/src/libretro/ platform=unix
	elif isPlatform "sun8i-h3"; then
        make -j2 -C yabause/src/libretro/ platform=unix
    elif isPlatform "rpi4"; then       
        make -j2 -C yabause/src/libretro/ platform=rpi4
    else
        exit
    fi
    md_ret_require="$md_build/yabause/src/libretro/yabasanshiro_libretro.so"
}

function install_lr-yabasanshiro() {
    md_ret_files=(
        'yabause/src/libretro/yabasanshiro_libretro.so'
    )
}

function configure_lr-yabasanshiro() {    
    mkRomDir "saturn"
    ensureSystemretroconfig "saturn"
    addEmulator 0 "$md_id" "saturn" "$md_inst/yabasanshiro_libretro.so"
    addSystem "saturn"
	
    
    # set core options
    #setRetroArchCoreOption "${dir_name}yabasanshiro_addon_cart" "4M_extended_ram"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_force_hle_bios" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_frameskip" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port1" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port2" "disabled"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_resolution_mode" "2x"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_sh2coretype" "dynarec"
    #setRetroArchCoreOption "${dir_name}yabasanshiro_videoformattype" "NTSC"
}
