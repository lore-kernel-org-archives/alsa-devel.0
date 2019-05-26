From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 2/7] ASoC: sun4i-spdif: Move quirks to the top
Date: Sun, 26 May 2019 20:22:49 +0200
Message-ID: <20190526182249.nx7ql7bghzuah7rd@flea>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-3-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6o7q3ljfvpuo6cyn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190525162323.20216-3-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jagan Teki <jagan@amarulasolutions.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6o7q3ljfvpuo6cyn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 06:23:18PM +0200, Cl=E9ment P=E9ron wrote:
> The quirks are actually defines in the middle of the file with
> short explanation.
>
> Move this at the top and add a section to have coherency with
> sun4i-i2s.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6o7q3ljfvpuo6cyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrZeQAKCRDj7w1vZxhR
xYznAQCG1ejGnz0/Amek60TIzTGn7GCQXJ14lwLZt7fBCIsxdgD9FkDn/kl+sLzC
xhVYYDDY3qXuamvmvEtLHOuGs4SYgQM=
=+pbe
-----END PGP SIGNATURE-----

--6o7q3ljfvpuo6cyn--
