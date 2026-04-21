# Copyright 1999-2026 Gentoo Authors
# SPDX-License-Identifier: GPL-2.0-or-later

EAPI=8

DESCRIPTION="A modern runtime for JavaScript and TypeScript"
HOMEPAGE="https://deno.land https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/releases/download/v${PV}/deno-x86_64-unknown-linux-gnu.zip -> ${P}-amd64.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT=""
QA_PREBUILT="opt/deno/deno"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
        insinto /opt/deno
        doins deno
        fperms 0755 /opt/deno/deno
        dosym -r /opt/deno/deno /usr/bin/deno
}