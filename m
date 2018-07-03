From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/2] ASoC: add es7241 support
Date: Tue, 3 Jul 2018 16:32:12 +0100
Message-ID: <20180703153212.GC13744@sirena.org.uk>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703132845.26554-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2018 at 03:28:43PM +0200, Jerome Brunet wrote:
> Add support for the es7241 which is a simple 2 channels analog to
> digital converter.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls7lvsACgkQJNaLcl1U
h9D40Qf/TBe4I8pootfIqHDb+wyZwfwj9U1ajEgbwLF8R+hrvuKkR3f7LuB6DfRn
oieN/hPIVQumKtQxjihCxXYS3DhEOPTpXR8qvNowneU5uKXBe/ZrHznXUqWMVFlR
jkLkEhrLzv9XZmsinD96kxiqrVpuhpfNC5+LMsSjELgGCIP4H98uLRcUeNStFZgh
8o2ezljBy0zfVpkfBafJP8UXnhSJ5spMpKmfPC+Eg20/OI4ICHyQfWVAXUNb21In
yCY5MGvgqSx2SpgmjEwAA+Z9DCytf3HFkyqmILpY1qSrQ5RjCy+cb+dcq3GnVP6K
M8ahIzv9qzF++IhN8GQjALhyNQfsXg==
=D2OE
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
