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

rp_module_id="bezelproject"
rp_module_desc="Downloader for RetroArch system bezel packs to be used for various systems."
rp_module_section="config"

function gui_bezelproject() {
    source $scriptdir/scriptmodules/supplementary/bezelproject/bezelproject.sh
}
