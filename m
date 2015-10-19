From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: rockchip: i2s: add 8 channels
 capture support
Date: Mon, 19 Oct 2015 16:15:25 +0100
Message-ID: <20151019151525.GA32054@sirena.org.uk>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
 <1444308009-29088-2-git-send-email-sugar.zhang@rock-chips.com>
 <CAG5mAdzfoK_rnQhu=NGMzto2K49uKT4eOotRh3uGX=D6KOB5gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG5mAdzfoK_rnQhu=NGMzto2K49uKT4eOotRh3uGX=D6KOB5gQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, tiwai@suse.com, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-rockchip@lists.infradead.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2015 at 07:30:43AM -0700, Caleb Crome wrote:
> Is it possible to allow channels > 8 if certain requirements are met?  If
> the rockchip supports 8 channels @ 32-bits/sample, that means 256
> bits/frame.  Can those 256 bits be sliced into 16 channels of 16-bit
> samples?

Please don't top post.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJQkMAAoJECTWi3JdVIfQD2QH/35lxehoSqChGjdt3aRyIgA8
j0BNpcF9szWwSpKpTFSfBYzCer/Cm6yyQSFUKYXs4DEY57AgMVwbcjcqYLNmCzNJ
DB3PHugNhLssaZZeRxTLCfpJYVMhCGUzcoC8/9SXSVx0iTssjbLFH0Bx7pHPbrHo
NZcfn2Oq2Q231WjYAX8pOlBk//AYaKcDNob3gIx4dnyYfbfJ/w/yLj3u6/sybqnF
KWD308NBu0o+90Lpt9Di4Wg9vvWRdzm9XOZ3nbXIVxBiCljXRlbcPYKdZpiZ6XP7
Rd7zETtxgUjSEL0NF9fIYDSYKstWdlDZSA41vcqdPtQEjJCl4j/fFOhY8nk6n50=
=k8uM
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
