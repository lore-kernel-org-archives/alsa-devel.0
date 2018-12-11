From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: simple-scu-card: add dai-link
	support
Date: Tue, 11 Dec 2018 01:12:59 +0000
Message-ID: <20181211011259.GG3004@sirena.org.uk>
References: <87efax3e85.wl-kuninori.morimoto.gx@renesas.com>
 <87a7ll3e5y.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1387530514448123333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C695426770D
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:13:00 +0100 (CET)
In-Reply-To: <87a7ll3e5y.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1387530514448123333==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 08:20:26AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> simple-card is supporting dai-link support, but simple-scu-card
> doesn't have it.
> This patch support it. This is prepare for merging simple-card
> and simple-scu-card.

I'm getting a conflict applying this one - can you please check and
resend?

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPDxoACgkQJNaLcl1U
h9DORggAhY45m5cNu2Rjsie0IYmm6sl3jUXcSrKHZ324KqDBFHz06xcnc/XdFG2z
VaPzdH7Oh2iZbWTt7NxpfXNU9GOCfssOBPRuuBWYZj/mzrrjX93pBWko1H838Zwq
Iuu6f4z3zEWP11BQbfnhvglo99o98RtOnMM65nGYvoW5c76tIf4RQEOEV2T04qdC
S1OwhpTnMaV2dbScyxVfjhN2QAcXA8YccPIwWuRJudm7t/upR09kJfQL/+DSYghX
wwmlip0mNoevU3TKsNZ7z2SQTsVxCV4JbTcOA9d1n+eRZoiepsfFiwe3BSkkUP4J
NoVmdENgXtOCwsO+cGBNg7UNJjku8Q==
=pu/t
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============1387530514448123333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1387530514448123333==--
