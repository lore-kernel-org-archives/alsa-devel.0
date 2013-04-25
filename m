From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: mxs-sgtl5000: Remove unneeded
	'ret' variable
Date: Thu, 25 Apr 2013 11:59:30 +0100
Message-ID: <20130425105929.GQ5019@opensource.wolfsonmicro.com>
References: <1366820595-19762-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5919081744319681136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 546CB2650CE
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 12:59:31 +0200 (CEST)
In-Reply-To: <1366820595-19762-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5919081744319681136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmjRBBEgaenXGypG"
Content-Disposition: inline


--rmjRBBEgaenXGypG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 01:23:14PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Variable 'ret' is not needed here, so just remove it.

Applied both, thanks.

--rmjRBBEgaenXGypG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReQyKAAoJELSic+t+oim9ztQP/iciBMBbkQTdoCyjbsoRKazh
GIuei0P9BuTKg8HLZaeqx/Ubc621CW5tNQ71nItr+QLI/8k03i+BR7Cfn4a8Hmks
NJ54DKmLa34g/0topFihV7/vQAoaaDKw66GA/GKCr4Axpxkq3Z4OK0BMgXEtFCKa
hn0DDUSkVlSkTbfnOf/focR6mevD7QPYbvCHmd07QfC7a3ps1iEe+x7QOB7wAoGE
QQbeAwgVIVsqIKE1L2A9v+4tbBGYO27GzkcmO49M5rFJcqwgT9hSwYbpd9VIhyon
ZeYUbV4fDxNZrdJ3MQ1ADZCkkH6QGLVp0nk2KViu80OkvvKT9mYwxXOwM8hAhAWE
nScRmkHcbcUGMPyxjeDqbk9s/FSwT6e6HObtsTFcHs+GC8eAU9CID+9a4AiTy4hE
xndThFFnwHvAdLYNBSZq4W8l2mOawTjw5rgzXF4TIBslV6abiOlmJzzDAkWTBHnO
3PgIoYUHIYntZ/ZdBXOqEfZLC/koSHciyO1SqSkSOhm2h1kYvzVcuw+fYASGXoZU
J2Bup+NW68uKYuxcWPUtTCB58eBbQHBWkap8d0u430k14i3GyjZeeS3OS4ANP7KL
hp4s5LN6pH7xjEzUn7LZPAjsu8BDijPxWrUHh/rrZ6mH1gcYvVlHuLFid64O6Duc
U6xN30K0Q2d/f6D041Bl
=1XLy
-----END PGP SIGNATURE-----

--rmjRBBEgaenXGypG--

--===============5919081744319681136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5919081744319681136==--
