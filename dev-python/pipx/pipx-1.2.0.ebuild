# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1 bash-completion-r1

DESCRIPTION="Install and Run Python Applications in Isolated Environments"
HOMEPAGE="https://github.com/pypa/pipx"
SRC_URI="https://files.pythonhosted.org/packages/86/4e/2820045417d94d699c7fcfc81860c9d671aed87fe563a00d9a5f88993c2f/${PN}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/hatchling
	"
RDEPEND="
	dev-python/userpath
	"

python_prepare_all() {
        distutils-r1_python_prepare_all
}

python_test() {
        distutils_install_for_testing
        pytest -vv || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
        distutils-r1_python_install_all

		use bash-completion && newbashcomp "${FILESDIR}/pipx.bash_completion" pipx
}

