From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/12] ASoC: rcar: rename GEN2_SRU to
	GEN2_SCU
Date: Tue, 19 Nov 2013 10:24:38 +0000
Message-ID: <20131119102438.GY2674@sirena.org.uk>
References: <87zjp0dam4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0468670495604092419=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BD3E42610C7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 11:24:41 +0100 (CET)
In-Reply-To: <87zjp0dam4.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0468670495604092419==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yhqQ34TVR4fE8mPU"
Content-Disposition: inline


--yhqQ34TVR4fE8mPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2013 at 01:06:15AM -0800, Kuninori Morimoto wrote:
> Gen2 has SCU. SRU is for Gen1
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Mark Brown <broonie@linaro.org>

assumning this is tied in with other changes in the series, if not I can
apply it.

--yhqQ34TVR4fE8mPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSizxiAAoJELSic+t+oim9b2MP/jKUREq0uXP8duRkQvMEXKKA
0bueujDayXB+b+ChH2Qpy+VDpYwO3ciIT/P/pR9cirBaM2wvo1NzKb5TwOzqCwfN
YxFeMEpb+tPBDvtU9s9zdEg9yb7b86UqMw/CCCMfjNNCZEwe6n3FrSS14rXuStm5
hItjm9mPEBafKLLj8a47kybfAPCwu2UfmitIqa9OrTpK5uzArPfcAu587rOLP6gQ
DUP7IY1MU/mBmFaJlNA4j0GWyjA1LCZLTUhoxfpDkLUx+yz29WtedFHTKRhG9MjY
2evI5WX5oVyDgKoxRw+4gCkuBK0G5I7VbuqmSV7v1TDHsiDj2nd5BQRBuawtjrdW
CdiAaXH3dMYgCHENk+9CNDtOvvqjvzu2bc09YZnKs6WpPN6R/4hFSsuHQAvLb3cW
qUgDLkjFgPacwD5j0GD+LgLhI/hGmzt2i6imezpoMteQPFOCJ6OJiLP8GIMt6rTI
CqbgIOZP5dcP4GUjQdYnOYc22Nggd1kw2E4bJ5ktDBwFPUW/00G6irM9YkWQjyUz
DGJMHdDgkZieB7osUhDfLZE5PezMJWVJF1q7BIi/vf4puTPgbHpe+tyv5MiTQ6rI
GuSRnHn5MsHNx1or9YM+k+6K2s+3b7QNGQIAIpzvx3qoO0TLVlSuYqOrCbhfPQRU
yI/WaVB79oZlwLVorJ05
=pO1W
-----END PGP SIGNATURE-----

--yhqQ34TVR4fE8mPU--

--===============0468670495604092419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0468670495604092419==--
