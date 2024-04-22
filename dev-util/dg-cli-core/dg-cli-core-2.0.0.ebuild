 # Copyright 1999-2022 Gentoo Authors
 # Distributed under the terms of the GNU General Public License v2

 EAPI=8

 DISTUTILS_USE_PEP517=poetry
 PYTHON_COMPAT=( python3_{10..11} pypy3 )
 inherit distutils-r1

 DESCRIPTION="The DG CLI is the tool to manage your local Digitec Galaxus development environment."
 HOMEPAGE=""
 SRC_URI="http://localhost/dg-cli-core-1.9.1.tar.gz"

 RDEPEND="
    dev-python/typer"

 LICENSE="MIT"
 SLOT="0"
 KEYWORDS="~amd64 ~arm64"
