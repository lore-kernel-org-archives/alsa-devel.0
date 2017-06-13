From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rsnd: don't call free_irq() on Parent SSI" to the
 asoc tree
Date: Tue, 13 Jun 2017 19:41:56 +0100
Message-ID: <20170613184156.h3rzrjngyy6y5v7i@sirena.org.uk>
References: <87d1b9y3sk.wl%kuninori.morimoto.gx@renesas.com>
 <E1dBlJN-0003b0-AZ@debutante>
 <87vao2ghs8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45bza2oa2zydlouy"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87vao2ghs8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--45bza2oa2zydlouy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 12:45:51AM +0000, Kuninori Morimoto wrote:
> Hi Mark
>=20
> This patch was accepted on your topic branch now
> 1f8754d4daea5f257370a52a30fcb22798c54516
> ("ASoC: rsnd: don't call free_irq() on Parent SSI")
>=20
> I'm sorry, but, this is needed to fix branch for v4.12-rcX too.
> How to handle it ? can you cherry-pick it to mark/fix/rcar or can I
> post it ?

I picked it over.

--45bza2oa2zydlouy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAMfMACgkQJNaLcl1U
h9BDCAf/Z95CqxtH1egzZRTFuqME3VWxbi70pe6YA0CQw3LEtKcoujDNzm3UV+zy
+0A1F4rmC4RSXFFnMV2BXTqIl/FPzW8Pis7dlwSD/MG6jZzbmzvfr2Plbz/NMKEg
gV3aPTY7LKhjcM3g0Bprija3apDcySziAPsZV4tEsLSmsP6h2VErjzC+foHEuzzA
RBg1OnEDUnMmoy9vxKKy/WYcZuINLSsu0Ka4BaPhM7skS/d3iKzBib9afPFTizfZ
bNuK0JCB0SBtrpqvr15mOSgSN7gGPjXXWVqoGtcICaS9WdtpIgo0UDb+y6nd5Gdm
6KU9q8X2zRlw2Ggj8zgG9RDpSbz2zw==
=+kKC
-----END PGP SIGNATURE-----

--45bza2oa2zydlouy--
