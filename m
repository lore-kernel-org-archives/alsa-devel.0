From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rsnd: control kctrl items acceptance
 anytime/runtime
Date: Thu, 6 Apr 2017 11:48:17 +0100
Message-ID: <20170406104817.ozzx4ooek5cepvul@sirena.org.uk>
References: <87wpay3svc.wl%kuninori.morimoto.gx@renesas.com>
 <87shlm3srx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="saqineivkzdjtyxg"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87shlm3srx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--saqineivkzdjtyxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 07:25:48AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current SRC/DVC/CTU adds kctrl for each device, but
> some of them shouldn't set *before* playback/capture.
> This patch control it more clearly

Why is there this restriction for these controls - what are they doing?

--saqineivkzdjtyxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljmHPAACgkQJNaLcl1U
h9C1Wwf/Qi+g6Y2umEw+gCTCojsyI9Q+yqWWHq/N39FFmRv4nhxufXspCjIpJTaU
MpCA87JDGK7khyxkNCgAiqM9JJ3QX4AltMNcg/vgxXOmSCdRqtL7t3tmu7g0k+2Z
X6CHup4+SsfGPr1pjQICvNIN+cHDXFA870UzKem9BJVXDC08eHxdnrRnL8qt95gs
YEUQld8kaJk5zBfZ/ghMt+NKePNku1iFZwh81PxXy8ANT19YSVs1YKMB7lAfwxoh
LSADFGPrWMJCfSFB13187ND9mSLiY6Di4T1RN7bdPQ4I7az/F9UvbIkNcA9iSDBH
FQCRCQgzCuVoAJvFKreJIN9oai7oNg==
=FHn0
-----END PGP SIGNATURE-----

--saqineivkzdjtyxg--
