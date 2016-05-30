From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/49] ASoC: simple-card-core: add
 asoc_simple_card_init_jack()
Date: Mon, 30 May 2016 18:14:02 +0100
Message-ID: <20160530171402.GX29837@sirena.org.uk>
References: <87lh35rs8w.wl%kuninori.morimoto.gx@renesas.com>
 <87zirlqd4t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e9ndEBTQFD7P4kUb"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zirlqd4t.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--e9ndEBTQFD7P4kUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 09:48:38AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> simple-card is supporting jack/gpio.
> This patch makes this method simple style standard.

There was some recent discussion about a more complete core binding
for this based on the work that Dylan Reid had been pushing a while ago
- it's not clear that the simple-card binding is great for
generalization here.

--e9ndEBTQFD7P4kUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTHTZAAoJECTWi3JdVIfQIqwH/A+T75vynzQlFMCaxrdu1osq
iZzb8O1rXgGpCApawAvGEZJasu7F11ZhE12uf57fCbmWjXWU0loBwllezNtnkbwG
IiujNaAe35xcRdZi5lGmBFshTRWdmvxqEuzrTl128bhV2jnmEn8+eCu5TbaG7yLS
t4cFus+oelBhw2XOKCa7uvNSUCESuwCJpIqx6Kd2U9tzr3QE2GTs7Gj5vLRsoTgn
RvnWYi/5A3BximKqOnNNNgFuQLfcnKa7dtYnUl6pAhoimThshNQhr1udRMgK+GTo
mk9c6CAayiPsA+N+ZLNiYEOiSMSkLU6hzgbeXNMzZLY/JpdoIhjNsRrO5yZRaTQ=
=9mL8
-----END PGP SIGNATURE-----

--e9ndEBTQFD7P4kUb--
