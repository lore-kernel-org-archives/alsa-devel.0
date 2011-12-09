From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/5] ASoC: mxs: General cleanups
Date: Fri, 9 Dec 2011 15:07:28 +0100
Message-ID: <20111209140728.GG3327@pengutronix.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5835613555527044855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 16C8D243BF
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 15:07:32 +0100 (CET)
In-Reply-To: <992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
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


--===============5835613555527044855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2011 at 02:38:08PM +0100, Lothar Wa=DFmann wrote:
> Some textual cleanups without functional changes
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  sound/soc/codecs/sgtl5000.c |   13 ++++++-------
>  sound/soc/mxs/mxs-saif.c    |    2 +-
>  2 files changed, 7 insertions(+), 8 deletions(-)

I wonder if it is okay to change those two files in one patch, but for
the changes itself:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7iFiAACgkQD27XaX1/VRu+xQCePXcF20PBs1eC9UkPsdTVbEDj
uP8AnjqdfehO3J21XPGd6qdHT4FI2tMd
=TTiF
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--

--===============5835613555527044855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5835613555527044855==--
