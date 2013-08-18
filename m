From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Drop SND_SOC_FSL_UTILS from
	i.mx machine code
Date: Sun, 18 Aug 2013 16:29:13 +0100
Message-ID: <20130818152913.GX30073@sirena.org.uk>
References: <1376768292-852-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6813618668208552137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DFA32608D1
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 17:29:20 +0200 (CEST)
In-Reply-To: <1376768292-852-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============6813618668208552137==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhxWStFQ84VXWhXs"
Content-Disposition: inline


--FhxWStFQ84VXWhXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2013 at 04:38:12PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> SND_SOC_FSL_UTILS is only used by PowerPC machines, so let's drop it in t=
he
> i.mx case.

Applied, thanks.

--FhxWStFQ84VXWhXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSEOhFAAoJELSic+t+oim9vkcP/ApePFgO4t0h0lwiwJio3AbQ
DWIqvqrvyLEK45OLLPQb6htXkPxlBVQ3UjIcLq/EEBX47/N0wzkaSUUmEZC/oOkr
WlQqlbwa5wkqvRc09tyAqWxelEsE/9A4laoJaOE41HkdCDgz43oaMFbeKvG4zIdr
ahHc7bcnmK6OHy6Qz7nqdB/B76USUFTDAAZ5H1ZqzIlZvL/jjEKWL9T6j40iX0Ir
ZUrq4V8PDwbtA9GQLvxEeg67zmQ5T20hkvUUT5BynD2Gi0rM3zyRbg+wOgNdGMl0
9tICPgkv5yRbGk3S7Gog6QknQ/J4nc9pepoLO7JzUBnr0VwffkkbPJe41GwATCdC
+YJZFkvGzpszDg6z5/6lhY53OS9C57YmYJgW/vjd7fGp/tuX/SgORO/w1GD0Ov0E
sTIf3OIvJt220nxuog36Hsq1V0rFEVcboss0k0okQ7n4sA0sEkpsKlE1wjZ1RzGc
SBInpKWr0iWRmOQlgw5iJY/0P/ZGf+Ao1GG97smd7g6UwwwCtv2xpjyXXylPC05/
loUqpbKqtjzZUGsDUIPQa2z+J+0UdxFppL+vsvmDl3NkEm19x2RoLdpKlSbWAm36
sq+jJVvdRCW/URAIwKwn9DyPjhjo3OsllgzeiAS6BA1KX3RH8Dgil0yzDWAiITJj
iapDaQC5WCgsAIHQRuPC
=sZYs
-----END PGP SIGNATURE-----

--FhxWStFQ84VXWhXs--

--===============6813618668208552137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6813618668208552137==--
