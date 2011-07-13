From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Wed, 13 Jul 2011 14:59:33 +0200
Message-ID: <20110713125933.GH1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<20110713124648.GA6640@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4502466334739729953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C459E24436
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 14:59:36 +0200 (CEST)
In-Reply-To: <20110713124648.GA6640@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4502466334739729953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2011 at 09:46:52PM +0900, Mark Brown wrote:
> On Wed, Jul 13, 2011 at 01:57:11PM +0200, Wolfram Sang wrote:
>=20
> > Proper regulator support for mxs is not in mainline yet. Is that
> > planned? How do you do it?
>=20
> Regulator support is not a feature of the platform, it's a generic Linux
> feature.

Yup, sorry, meant s/mxs/mx28evk/

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4dlrUACgkQD27XaX1/VRsNvgCgrbvtqAMkUg4qmcjMYB4N1dI+
K6IAoMP1sXqupB+gN1nZ3jTSFml4MVhs
=BazR
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--

--===============4502466334739729953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4502466334739729953==--
