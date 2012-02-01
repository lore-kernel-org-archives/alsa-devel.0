From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: cs42l73: Fix Output
 [X|A|V]SP_SCLK Sourcing Mode setting for master mode
Date: Wed, 1 Feb 2012 10:49:21 +0000
Message-ID: <20120201104921.GA5648@opensource.wolfsonmicro.com>
References: <1327974544.4566.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6888168228705144457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38B761038E8
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 11:49:24 +0100 (CET)
In-Reply-To: <1327974544.4566.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6888168228705144457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2012 at 09:49:04AM +0800, Axel Lin wrote:
> For master mode, set Output [X|A|V]SP_SCLK Sourcing Mode to MCLK Mode.

Applied, thanks.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKRciAAoJEBus8iNuMP3dV4YP/02ZVf8O8RyerAGULpLP6VaY
FJi7dJWkaH2CuchJSMt3L0qHIQv7hvxvjrHMlZtoyyEqv1Kn3RLzdy6CSbVXsaGt
7L0vsnK+qY3igSHos90Nb6h1Sl1t3ANnaWnxzyiPagFVbmuQGDsNuNOuhY+67VSt
6/6oQKh5B5t/Yk1W41ZJwcTMFyUfZiKMaV3caa2C9ReJAbIkZPGfZv6oA0n/LKHV
68Iur3qawdUPF/UzNcWnfqyEwItJCDEbIEnxwhW4pGZIdISsTXBcEQ3t+AoQ8AVV
OnyElEsa2E5hhMqSb1OhgD+xYD8crXAQP/kP5KEqcnhyDZhzivOiqyjmvGzUL9XB
/pUbgZdajro7YNkddj7hP0GTPgAYQygCHhUVXFUZpRWTDhXvoyGTROntKFRsEnl3
xIMtTjXThQpZsd6h6AU401tztocW6w922q2CSrqiW7E3Sy0zuLCAeWIiZNAWq2Gf
x46plrtSYI0HzASZqhWnXkBu6kq8bHITOssgQjn2YJibD226qwpFmbqVHKeVvCgR
DgzBPOBH267qkC9s1Dfl/4EFs61IqieHdPBJH83HgffbHZEoy5b2E0o8zlMQtltN
a2aSGWONCMSd1nVT0yQaSiU9sjKqx26uf9G2qo/gEjZMCWqBytXDCQzQjP+v0KMh
XoUhhIggP6cYAPnKYvNS
=wLci
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--===============6888168228705144457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6888168228705144457==--
