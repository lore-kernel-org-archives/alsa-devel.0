From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC: Atmel: ClassD: Simplify use of
 devm_ioremap_resource
Date: Mon, 4 Jul 2016 16:59:59 +0200
Message-ID: <20160704145959.GI6247@sirena.org.uk>
References: <20160704130352.GA16886@amitoj-Inspiron-3542>
 <20160704141533.GG6247@sirena.org.uk>
 <alpine.DEB.2.10.1607041651380.3790@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z5jwahX8Ql4zxomt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1607041651380.3790@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, nicolas.ferre@atmel.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--z5jwahX8Ql4zxomt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 04:52:43PM +0200, Julia Lawall wrote:
> On Mon, 4 Jul 2016, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> The point is that ASOC should be ASoC?  Ther aren't many patches on this
> file, and two of the three have the same subject line as the above, but
> with ASoC rather than ASOC.

Yes, that's the case here (this is one of my pre-canned responses and I
didn't yet figure out a sensible way to make it parameterized yet,
should add a bit about trawling git log though).

--z5jwahX8Ql4zxomt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXennuAAoJECTWi3JdVIfQKswH/Rk0C8E/nSwD3RcyV0hJOvbz
sU89bFeeGhwsC1ga/2o0uJOuXRQDV0sR1hnI6K9reCTwzKAhg0/tjO21jxkTnMjO
Ig/lvCoQm4wclkkZ9dov+dluq+nLO6A3PK/QH0uj/MDvohESWmC55symc4J0KVrO
8OFR+aKwbOrIj6UKz93WLE7zTwguai+2DqC9DpzmK1dQGxgzlHCuaoeqHL6cMF3+
9x9jKsKRxl5g/dynPGzybGXsXH4dfIQ9oxqoFtIA+62lfgUFvdeATkjm+kbYFTf2
4Ak9jquVoGvjSQdILTDfO0Xpo5tNWXL8vNr2TAcMkosi2ChMnVTbQjzN9WSljGc=
=a8tb
-----END PGP SIGNATURE-----

--z5jwahX8Ql4zxomt--
