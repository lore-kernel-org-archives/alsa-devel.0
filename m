From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 16/18] ASoC: wm8990: Use IS_ENABLED()
	macro
Date: Mon, 25 Nov 2013 17:14:02 +0000
Message-ID: <20131125171402.GL14725@sirena.org.uk>
References: <1385045312-15092-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4619473671771533783=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 59254261AF9
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 18:14:05 +0100 (CET)
In-Reply-To: <1385045312-15092-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4619473671771533783==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYOwxzDtEZWltKxP"
Content-Disposition: inline


--mYOwxzDtEZWltKxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 12:48:30PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This doesn't apply against current code.

--mYOwxzDtEZWltKxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4VXAAoJELSic+t+oim9MAsP/3jUQVoqjo5F1MvkevDRH9A7
+yASTA7ht9QBK76mglvmH36UgXoCW3Lol8pLtjw2gmR1M6ucwZqmbtsnrdonjJ/S
AYIN6ju/FzdzSp8D2kmlnES2lkV6hOsbI/w20egn2yCAZ2uhtp1rtCbtJC7bk3Nm
W7iG0ndXfi4cf25N8ipvoqmpaL/5BTINVqLrJNmwmuIa2yqUdlFGbyCMobnH/zoI
Cx6CcI4p+tuYa1SdX8N9AgFqhW43+a9Cq6WoPEwAqbuKmgvXanhOCJS3pmK5B5nx
BiIEBVeJbvbNoy/d/mFAIobAVWdbGhqixAQ1k3Nlx0vBZKJuLxSy1rmTlelK4UrX
geqpWtAk1I3GYXybJiOcALMsDrp+YvbftqSkAlNhPwlE9EQ/TbTqelF+idUa2qgt
TOOgXbVraKXJ2WBqlmV0TCCUwWRPfcrOYi0C7LHGlz3Ge4y4BOMY+S4ifz9JkVb1
thmJPn+NtlsivvJsNxhXdm7OhkAKYGw8QrWkyBC7CP5DctSVjagnPUx/Ccut7z0O
F4A55h4Z9nnOhKFfUMsW627+IJ2HtuVQcZwixJzZZuBljKCYHsw6L3Wzop+Oma8a
iUyQXmy4uc4zRJLwgPZv+vFUHmqoloGWIREydIheDoYtxncvBrKRyIjy1NFfBSVc
qWXnK2KJZOPbR77JOwW+
=yKvQ
-----END PGP SIGNATURE-----

--mYOwxzDtEZWltKxP--

--===============4619473671771533783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4619473671771533783==--
