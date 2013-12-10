From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: gen: fixup Gen2 channel size
Date: Tue, 10 Dec 2013 10:22:05 +0000
Message-ID: <20131210102205.GW29268@sirena.org.uk>
References: <8738m1lcoe.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5593318022478721460=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A43A3261A86
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 11:22:09 +0100 (CET)
In-Reply-To: <8738m1lcoe.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5593318022478721460==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hCLvYgaP90yRNu/h"
Content-Disposition: inline


--hCLvYgaP90yRNu/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 05:26:01PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Gen2 has 0 - 9, total 10 channels, not 9 channels.

Applied, thanks.

--hCLvYgaP90yRNu/h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSputKAAoJELSic+t+oim9Zk4P/jl7eOl58LbQTbB+ApWLjQbg
MKhd97eRT5u9WQ5LKOjG2p/A38QbbPhqm8+/v7FfdHSNEKQHI5CTiKjpKqccFyer
GWecMpMk/ehlZB+5XeKqzMMCuLn1s47sM7HdRzWV3GUbbu9oHSxg3PG11V0BRHAY
8p4c7O8p9plpNXsOi1cVVN8Yqn1Ys7YmjCLY9F7Rk3eXZi0gaK1Hv/LXDRoay5Pr
vyF15Tq0pAv88Cgm9gb4t1PChLTxySYQcnqcbesUSHvlTIM4dIFY/jIKmVJe+6+f
AZbmB5CcZwNLn8gFREqDqdrMV1K2xcjpOeoNy8q/d65m2hxzj5oTfH5tgTi+cFg5
EM5TsguxU2hrAnXr501kA5g2migG7HjVHZcz2zx68QqohyoH4Cm0zSYM3fi6zrdx
kSYZnohQ8izOONkvfYYuh7psoRyP+skG9O4OcCfMsL76QDnBk6AKy9c6H2QKw7+S
k0CiyVXndo11V9F+zxFaH79tTplxGyNTriKbjtjoADXfa6MEkYqJPYZm7MXL47eE
aY/muEhfovXFQegypVRdag3U1GJXx7dtgSUKFACiQidZmh+Nc/Lqfzk3MKdJKxlX
RTyfqvY42GkIpOueRfHV3gFa1BqKI7tFcD3vyC++MdPAWc/v8kiPxyrSlijHqVER
ZauvBKkWKTDJ9YSIs0b6
=gPiH
-----END PGP SIGNATURE-----

--hCLvYgaP90yRNu/h--

--===============5593318022478721460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5593318022478721460==--
