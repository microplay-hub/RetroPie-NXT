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

rp_module_id="golang"
rp_module_desc="Golang binary install"
rp_module_licence="BSD https://golang.org/LICENSE"
rp_module_section="depends"
rp_module_flags="noinstclean"

function _get_goroot_golang() {
    echo "$rootdir/supplementary/golang"
}

function install_bin_golang() {
    local target_version=1.11.13
    local version
    if [[ -e "$md_inst/bin/go" ]]; then
        local version=$(GOROOT="$md_inst" "$md_inst/bin/go" version | sed 's/.*go\(1[^ ]*\).*/\1/')
    fi
    printMsgs "console" "Current Go version: $version"
    if compareVersions "$version" ge "$target_version" ; then
        return 0
    fi

    rm -rf "$md_inst"
    mkdir -p "$md_inst"
    local arch="armv6l"
    if isPlatform "x86"; then
        if isPlatform "64bit"; then
            arch="amd64"
        else
            arch="386"
        fi
    fi
    if isPlatform "aarch64"; then
        arch="arm64"
    fi
    printMsgs "console" "Downloading go$target_version.linux-$arch.tar.gz"
    downloadAndExtract "https://storage.googleapis.com/golang/go${target_version}.linux-$arch.tar.gz" "$md_inst" --strip-components 1 --exclude="go/test"
}
