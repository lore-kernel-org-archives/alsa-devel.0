From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date: Thu, 14 Feb 2019 14:47:23 +0000
Message-ID: <20190214144723.GB11988@sirena.org.uk>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
 <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
 <20190214093747.2414-10-s.nawrocki@samsung.com>
 <20190214130747.GA11988@sirena.org.uk>
 <94582faf-3054-9b40-8c15-15b70f984286@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <94582faf-3054-9b40-8c15-15b70f984286@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 03:32:38PM +0100, Sylwester Nawrocki wrote:

> Hm, looks like we need still to keep that data structure field, but=20
> remaining part of the patch could be applied. Do you want me to=20
> resend it with chan_name removal part dropped?

Please resend.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxlf3sACgkQJNaLcl1U
h9Dd+wf7B7ZIMmY5ipI415Ue3HfBHNnUClUqoTZ3CiLtqZhLt7fWKljOtbB37nnl
JjpDKk5wDvQvPWltRQ7mDFB9NUX3HfxL2Z/XQ9vTcXzNjamou0bYyoUrO3AvDsyW
xeus7Ga6YBMnOee8ZT+jLX74mrFVXn23pcvQY0irJvc7jWM6+oHtInuxjUL3IX4m
dehRi5OlEmoh+vvZLAabm9uz0haw9rsnTsF4wp3OArX+D0nns1TBfwsAJFYsivSA
qg2qgZ0YO3y4BfEVFQzX1nsbW1feuk18Y8AG7nrp/pAsnASRCT39S1IzGkll3mLD
7NjGUiisJtgDrXGYsHmnDC33f7MQeA==
=6Epj
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
