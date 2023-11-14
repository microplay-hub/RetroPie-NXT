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

rp_module_id="munt"
rp_module_desc="MT-32 emulation"
rp_module_help="MT-32 emulation for DOSBOX.\n\nNote: Place MT32_CONTROL.ROM MT32_PCM.ROM CM32L_CONTROL.ROM CM32L_PCM.ROM (case sensitive) in /usr/share/mt32-rom-data."
rp_module_repo="git https://github.com/munt/munt.git mt32emu_smf2wav_1_9_0"
rp_module_section="driver"
rp_module_flags="noinstclean"

function depends_munt() {
    local depends=(build-essential cmake portaudio19-dev libx11-dev libxt-dev libxpm-dev)
    getDepends "${depends[@]}"
}

function sources_munt() {
    gitPullOrClone
    
}

function build_munt() {

    cmake -DCMAKE_BUILD_TYPE=Release -Dmunt_WITH_MT32EMU_QT:BOOL=OFF
	make
	md_ret_require="$md_build/mt32emu_smf2wav/mt32emu-smf2wav"
	md_ret_require="$md_build/mt32emu/libmt32emu.a"
	cd "$md_build/mt32emu_alsadrv"
	make
	md_ret_require="$md_build/mt32emu_alsadrv/mt32d"
	md_ret_require="$md_build/mt32emu_alsadrv/xmt32"
	
}

function install_munt() {
   cd "$md_build"
   make install
   cd "$md_build/mt32emu_alsadrv"
   make install
   mkdir /usr/share/mt32-rom-data
   chown -R $user:$user /usr/share/mt32-rom-data
   cat > /etc/rc.local << _EOF_
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

/usr/local/bin/mt32d -i 12&

exit 0
_EOF_
  chmod a+x /etc/rc.local
  cp "$scriptdir/configs/pc/dosbox-sdl2-SVN.munt" "$md_conf_root/pc/dosbox-sdl2-SVN.conf"
  cp "$scriptdir/configs/pc/dosbox-SVN.munt" "$md_conf_root/pc/dosbox-SVN.conf"
}