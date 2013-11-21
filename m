From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/11] wm8728: Use IS_ENABLED() macro
Date: Thu, 21 Nov 2013 13:09:45 +0000
Message-ID: <20131121130945.GQ2674@sirena.org.uk>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
 <1384969072-25906-8-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3322480479644598315=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D614426072A
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 14:09:50 +0100 (CET)
In-Reply-To: <1384969072-25906-8-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3322480479644598315==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1RcuuA4CmYq3pph"
Content-Disposition: inline


--k1RcuuA4CmYq3pph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 03:37:47PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--k1RcuuA4CmYq3pph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjgYWAAoJELSic+t+oim9F7UP/102Q1q1B6bS4rSU2Nyz+Jxj
sstTbunO742LDKfLs9Dpls7e2RGr5cABIkE0eKJz1qU9sCc4gLBgbnPEtOoZ/WqD
7nzcvSJvpy9V+jfA8KgcokkCH46SG51uD1PHNmKfLkbUq6A8cZ7oIpCPTekoQoNn
A3m8j4gZHQsbKIk6taJVrWvz2g+hy3XYMH4YkOTX5xEHsPa1HZ3Bi9+SlhR7K+QQ
K7ziubWPpQ5VHlkPe/daXPDRU6b2gLRahYmSXKt2SeE0Mq2gnVgQgO/XavYvolku
lLhUR9XOMKTSxyhKl1FKViIVLBKZLE62J6B56/GEJpLHqFh6WJ3GBJe8mptIrf2e
jqunPaubynU0F7dB/2DeHsbIqRp298gfkrgJa+SU9SXWm7lYBbot09FVShWBq3lE
Y7KOQR4eUx33SAdsUnn4NR6XvqxQX5QIky/hOVSwM72b6gvSaNhhr9skPEmm08Ay
7tceDYg2t+JZDQok6ZgsaVhrZMTXhbbDMN8lvanOWSDOY2njsNp6Z9qmZWFiiK9p
dO+oJpWhiMyDXaR2EDQ8GUAqCZf1QdBW1f3ZT/WSXEFpP6NwTlvdkYjlsg0l+75N
O4d4q2evtzfimryBahSOrft7L/iy7vPCv3jew2PSTojo0SErSgIpveibSf2vQsMt
YUp5mmtOVBv9a4KvsGFb
=mGcY
-----END PGP SIGNATURE-----

--k1RcuuA4CmYq3pph--

--===============3322480479644598315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3322480479644598315==--
