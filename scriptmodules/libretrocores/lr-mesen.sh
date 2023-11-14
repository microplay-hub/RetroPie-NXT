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

rp_module_id="lr-mesen"
rp_module_desc="High-accuracy NES and Famicom emulator"
rp_module_help="ROM Extensions: .nes .fds .unf .unif .zip\n\nCopy your NES roms to $romdir/nes\nFamicom roms to $romdir/fds\nCopy the recommended BIOS file disksys.rom to $biosdir"
rp_module_licence="GPL3 https://raw.githubusercontent.com/sourmesen/mesen/master/LICENSE"
rp_module_repo="git https://github.com/libretro/Mesen.git master"
rp_module_section="exp"
rp_module_flags="!armv6"

function sources_lr-mesen() {
    gitPullOrClone
}

function build_lr-mesen() {
    make -C Libretro clean
    make -C Libretro
    md_ret_require="$md_build/Libretro/mesen_libretro.so"
}

function install_lr-mesen() {
    md_ret_files=(
        'Libretro/mesen_libretro.so'
        'LICENSE'
        'README.md'
    )
}

function configure_lr-mesen() {
    local system
    for system in "nes" "fds"; do
        mkRomDir "$system"
        defaultRAConfig "$system"
        addEmulator 0 "$md_id" "$system" "$md_inst/mesen_libretro.so"
        addSystem "$system"
    done
}
