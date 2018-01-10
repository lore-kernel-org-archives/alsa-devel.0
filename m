From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: max98373: Changed SPDX header in C++ comments
 style
Date: Wed, 10 Jan 2018 10:15:06 +0000
Message-ID: <20180110101506.GC9003@sirena.org.uk>
References: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 09, 2018 at 09:01:58PM -0800, Ryan Lee wrote:

> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2017, Maxim Integrated */

Please change the entire header to C++, mixing C and C++ on adjacent
lines looks ugly.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpV56kACgkQJNaLcl1U
h9CBNQf+I4hOC7KE31QvXpG0/dq5jgyUQJRkFBzSHc0Kmnhe/bE9s91KPyrfRl9/
Qr7+V82tUwmYd3hFNbulpkuM4C1T6DmojVNZq27IFCcGiWo8lEqF9gwugBUkU2x+
gbSXI8y1UhtQPawuicHUyQz0FCrwAZX8yqZcCQo3R4igbU50LFO7CvEHflRMmcjg
rjGoAEw/OymKr003tCM0dKIyKHXn4afhX0M/SFU7XHjUsJFzZsN5bNEkHqPVDyG4
0XEno34XsKFiGDzkKB/RorNA0jax05KYiNVNpOfWsuc0bTjFF44ZFV6SOCkK4qh2
oLmF6qcrHRmssIfWUAfOUeFC4Mnxuw==
=4QxB
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
