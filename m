From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 26/28] ASoC: pxa: drop owner assignment from
 platform_drivers
Date: Mon, 22 Dec 2014 12:02:24 +0000
Message-ID: <20141222120224.GF17800@sirena.org.uk>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-27-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419196495-9626-27-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 21, 2014 at 10:14:47PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.

Applied, thanks.

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmAhPAAoJECTWi3JdVIfQyx8H/2O0X8TpMNyaEo+Ek+COW0/w
bPmORMs8j+IRVIBct9gNlsnjPg3RKStb8/M8gklrSauVnV2R5VLE8e7yzZqWN+Tv
vsMp1nijA0S7ydUKfCotRf1esoGk5K8Cqrg6cDMRQMJeoyNo4HoxaajZs76OC03s
0Mgz1OXUqBt4k+balFUIAu67a5Q+HtROMu9J4OdW9Zs8txGNpQ+Hg0RIQTZknKZE
BW0NOJzEOIUQO6ds8DK0D6GcS2qJfAqkWLH9j32S5P38aokped2XWtkxDghcrnRi
uIfARcLztkTj6kY5tXRY+DPDENnNUFf168S6fT2OP/zCCcj6U6tNwS+QvzQg15U=
=8GOH
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
