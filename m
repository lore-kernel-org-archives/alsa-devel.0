From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2] ASoC: tegra: utils: add support for
	Tegra30 devices
Date: Fri, 6 Apr 2012 18:31:19 +0100
Message-ID: <20120406173118.GL19424@opensource.wolfsonmicro.com>
References: <1333732555-9934-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4187208128291847075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B218C104524
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:31:22 +0200 (CEST)
In-Reply-To: <1333732555-9934-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4187208128291847075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GU3/x65mZ6MFE8p3"
Content-Disposition: inline


--GU3/x65mZ6MFE8p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2012 at 11:15:55AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Tegra30 has some additional clocks that need to be manipulated, names
> some clocks differently, runs PLLs at different base rates, etc. The
> utility code needs to handle this.

Applied, thanks.

--GU3/x65mZ6MFE8p3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfyhgAAoJEBus8iNuMP3d57AP+wWFaG5C00MJ/rS/63DwdWae
xaIbUr9aQucaxnaDInU9MT3SWg3vxcZWrRWIzHJrNX81ngti23B/i4/gUU5vYI4a
XEwlJqksfCNj15oVZ/ob2ZTVzqOYQTiLYJhQW9pLmDSql814zDSrUaTsbrk73H+q
qGYGLSS/BZaiMUXnpae3xsWtYom4Vqazc65czM6u2ZYk7y/JnO9tnjifgksxZgY6
GALKPum6l1l0IApfw/Abo0gwN/p3Gc6IUbTozTDur5CTyt14t8A28Z2TuqTxemB2
KwzKMqiPy2+MYH19f3kRAwI700J5AoB1oZw5KQ0kHKzgR3TPK6FApRHCtrervwg3
vBe4GhLgDalAodPGpaUBkQMdVs1SzG+Farnwsh3fCkdCW8WEyGad4c1pCRajNn8H
Bx0DZqLv+rB2EiEU3BFcLYiD4vxMqBXQE5XVYrK+CC1kjimtQbf18kOMDeoD7+jT
Q+aaaQsYBYsxmKpSuDoPy5Olw5S5COPjKGQnaQhyzjAkl6DZoetM04MgS1d8c6vs
We1F/2UAI6m5meUsAmCSk1saHZ0Fx+3n4iK8oAZx1nLhylIOJW1JLdIT3vSeo8et
3KWSXW8tI/UxR00niDqlbH+TT9I3MkZJAE97XMURtYY91/jNsRxfBi2zauWJZtKD
tgVHGbY+mQec3ejQKrNV
=Gvia
-----END PGP SIGNATURE-----

--GU3/x65mZ6MFE8p3--

--===============4187208128291847075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4187208128291847075==--
