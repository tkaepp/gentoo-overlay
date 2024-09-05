SRC_URI="https://packages.microsoft.com/debian/12/prod/pool/main/m/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_amd64.deb"

LICENSE="Microsoft-ODBC"
SLOT="18"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="bindist mirror"

RDEPEND="dev-db/unixODBC
	virtual/krb5"

S="${WORKDIR}"

SO_NAME="libmsodbcsql-${PV%.*.*}.so.${PV#*.*.}"

DOCS=( "usr/share/doc/msodbcsql${PV%%.*}/RELEASE_NOTES" )

QA_PREBUILT="usr/lib64/${SO_NAME}"

src_prepare() {
	default


	# Change lib path
	sed -i '/Driver/s|opt/microsoft/msodbcsql[0-9]*|usr|' \
		"opt/microsoft/msodbcsql${PV%%.*}/etc/odbcinst.ini" \
		|| die "sed failed for odbcinst.ini"
}

src_install() {
	einstalldocs

	insinto /etc/unixODBC
	doins "opt/microsoft/msodbcsql${PV%%.*}/etc/odbcinst.ini"

	doheader "opt/microsoft/msodbcsql${PV%%.*}/include/msodbcsql.h"
	dolib.so "opt/microsoft/msodbcsql${PV%%.*}/lib64/${SO_NAME}"
	dosym "${SO_NAME}" "usr/lib64/libmsodbcsql-${PV%%.*}.so"

	insinto /usr/share/resources/en_US
	doins "opt/microsoft/msodbcsql${PV%%.*}/share/resources/en_US/msodbcsqlr${PV%%.*}.rll"
}
