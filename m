From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/5] ASoC: mxs: Add missing
	MODULE_LICENSE("GPL")
Date: Fri, 9 Dec 2011 15:17:28 +0100
Message-ID: <20111209141728.GJ3327@pengutronix.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<a541450341a475b27ef603c5a4a67f113ba7fa0c.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3425559558558453469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4369C24141
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 15:17:29 +0100 (CET)
In-Reply-To: <a541450341a475b27ef603c5a4a67f113ba7fa0c.1323436034.git.LW@KARO-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3425559558558453469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2011 at 02:38:11PM +0100, Lothar Wa=DFmann wrote:
> The sound driver refuses to load as module, because of the missing
> MODULE_LICENSE("GPL").
> The file header indicates that the driver is indeed published under
> the GPL.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Sascha's code was also GPL and this code was derived from it.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7iGHgACgkQD27XaX1/VRuu2QCfU5yW+aR4Od6mTt5RoEK23Gel
dnwAoJJOqUseufeODEsCY3IZKkk1p/bZ
=ley2
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--

--===============3425559558558453469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3425559558558453469==--
