From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: care detail of SRC_BSDSR
Date: Thu, 31 Jul 2014 20:36:48 +0100
Message-ID: <20140731193648.GQ17528@sirena.org.uk>
References: <87fvhiuijw.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5127662285313049542=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 502402619F0
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 21:36:59 +0200 (CEST)
In-Reply-To: <87fvhiuijw.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5127662285313049542==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+1GFxID9PnI/U+e"
Content-Disposition: inline


--o+1GFxID9PnI/U+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 11:52:04PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Driver should care more detail of SRC_BSDSR settings.
> The sound includes noise without this patch
> if it used SRC.

Applied, thanks.

--o+1GFxID9PnI/U+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2prNAAoJELSic+t+oim99d4P/2HPi7qwJ2H4JbmvLD17B6p/
QZNUNBGB9TQlg8oVSiPI0yeIkX4cDPqJ0JaJjsiRddrGD54oZoxt/BNshaD4N0xX
Vo4C0ddCZVBlU08zCHFKfQh4idnZHb0aKZKEM+GpDITbWMACrAgDDW/NtReQTMj2
4DK1Uq539b2TUAtyu1Xxs7ruwz+bcn2uwvHdP84zSXL5oOuFMKDDHJwZertvLVHR
R6qOQNm14ZNpROU0JqRz2w8LqTarkwHbEf5m0dG2VyGT9DdvXG3PNOTOrbXNRUS1
4ucsQT4rjY3yHzBQ/6ixn/cx8dzyjTRdCD1wE5p77AJZi6A9PVz5QSejlS1LRu3j
2bRcGGlbs82qegoBH7od3y1pt0TFKTETWhMVRKGLosJavYZvHzkRwnoZXupiEFY+
T/qMFEGZ74mWnM6x7MWPGD/M8B0Aqr5FVrPnzTXj2NZ0AHMc7fjE7JbWE1zj3qzP
hs/Crsv1IGsrKZ40EgYFUVp/4lb50YD38Wpei9Kip5QL8zfhHC9rRcDIFiGtbkIo
UASsMIUk9J/4AkDj7lKLnZ8Fk/KsJ26qsOtWlm+xdaUy33qlMUuRcvyQvk+1r+l8
+0O+O8/yjGVhMdYjbm8dAQbjkBdabELW+6xq4J1RmcAX7pA+a3LpKzwY/AEsoUlk
/qg2klNedgyHrYhu2F5B
=KWg+
-----END PGP SIGNATURE-----

--o+1GFxID9PnI/U+e--

--===============5127662285313049542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5127662285313049542==--
