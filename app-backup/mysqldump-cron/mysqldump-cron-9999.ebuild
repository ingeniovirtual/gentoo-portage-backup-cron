# Copyright 1999-2021 Gentoo Autors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3

DESCRIPTION="Backup for MySQL."
HOMEPAGE="https://proyectos.nis.com.ar/projects/backup-cron"
SRC_URI=""
EGIT_REPO_URI="https://github.com/i-nis/backup-cron.git"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-admin/tmpwatch
	virtual/cron
	>=virtual/backup-cron-2.14
	virtual/mysql"
RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/cron.daily
	dosbin "${S}"/usr/sbin/mysqldump.cron
	dosbin "${S}"/usr/sbin/mysql_restore

	if [ ! -h /etc/cron.*/mysqldump.cron ]; then
			dosym "${EROOT}"/usr/sbin/mysqldump.cron /etc/cron.daily/mysqldump.cron
		else
			dosym "${EROOT}"/usr/sbin/mysqldump.cron $(ls /etc/cron.*/mysqldump.cron)
	fi
}

pkg_postinst() {
	local file="${EROOT}/etc/backup-cron/backup-cron.conf"
	einfo "Don't forget set root password in BDB_PASSWD parameter at '${file}' script."
}
