From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH -next] ASoC: fix wm2200.c printk format warnings
Date: Mon, 22 Oct 2012 14:39:56 +0100
Message-ID: <20121022133956.GH4477@opensource.wolfsonmicro.com>
References: <20121019135419.f996aed8ed85ee50a782a649@canb.auug.org.au>
 <5081DE83.2060402@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5081DE83.2060402@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Liam Girdwood <lrg@ti.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2012 at 04:13:07PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>=20
> Fix wm2200.c printk format warnings (seen on x86_64):

Applied but it is very depressing that I need to *again* remind you to
pay attention to where you're sending patches:

 - *ALWAYS* send patches to the maintainers.
 - Don't send patches to irrelevant people/lists.

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhUylAAoJELSic+t+oim9odwQAJ1EdTKTiJuViPwkktKeHfPJ
39UBRemINNBg3lNjXO5/xaSUMsCuWjveVpjFVGu+QDIol/+T1/D5Y0oxjwnDh6H4
L1J5P1DYv5wDyy/QkN/kvjzdEpKGhPzhktWjXHQfnsnxBtEr1IUjtz3OiPo5QXpF
fWh1zWo6UWFlB+EBwZSOyacYjAytzvq+aNhSektyVlMAJSbTdFEsBrAcWaTZbZ37
ExEPnufdYTzgEN01Qk5vlFH8eq/3tIQz+DCpQ+HrtmM7qMQAPPNLgjbeY+eVz8Jo
tq7rIskkyjeilpFHvFFxzfxS9Lrs81CQOFbYQtCtcFJzKvtOmAPzHSdiytoLE0NS
CYPWvrcE5nMYatPeVsoySQvq6FtydWPbB7TJ2WBHDtMTIAJ/ToBxdIJRhvqTYuAb
OYqcP2EBa5kG6tSmvDxrKcH/TKUGV+eVKlDsDq56/1xVs5iMFQcc8e0IkXaFpksB
En9dd5XhDQQWGq07lJW10bJDexQbODt+8vhoNbdNmBKSjzFAMIrf7DNiykC7tQPP
JicFB/E/m4ZLCKx1Rjay3C2OD0qohG90z8UQp+8W+YHMrVbu58j42SoT132mCkeD
aBejvk6YCd2qCEWP/NTIomxju8QcKOuxgVZcu2IJNiRV5dwGP97zcTv0SJQq0WyK
d3B+KEYnbZA8NQyESA6/
=czX/
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
