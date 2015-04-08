From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/1] ASoC: max98090: add shutdown callback for max98090
Date: Wed, 8 Apr 2015 10:48:23 +0100
Message-ID: <20150408094823.GR6023@sirena.org.uk>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+rUxOyiVj+UVbdi4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, "jay.xu" <xjq@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Tushar Behera <tushar.b@samsung.com>
List-Id: alsa-devel@alsa-project.org


--+rUxOyiVj+UVbdi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2015 at 04:52:07PM +0800, Caesar Wang wrote:
>=20
> Tested on veyron devices,play music then shutdown device,here carefully
> to speaker or headphone.
>=20
>=20
>=20
> Caesar Wang (1):
>   ASoC: max98090: add shutdown callback for max98090

Don't send cover letters for single patches, if there's anything that
needs saying it should either be in the changelog or after the --- in
the mail.  If there's any content in the cover letter that's usually a
sign that the changelog on the actual patch needs improving.

--+rUxOyiVj+UVbdi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJPlnAAoJECTWi3JdVIfQVt8H/3S/rg7m4PNCvcH9X/0JlHwT
qEMkrU9OcBuA1QqmqU6ScXoD1s6MOkD3KoCYFb8bgtg6lK9dPGy7oRgo+qBvdxqm
v080kOS5m0Ii9pRFkVjXlpUKiHO4M8+OLwbqY4WzN/9jYK5j4ZRC6qMwDB5NjK0c
coIr8W9VcayZucgFtJuhxfzOEgJQWaN0KRb49KsZIEkscPQEbVdve9pfCO0pGK8x
qQI9S2zrNbjozunQ4YxufjK9V/zkE1TOM48bUY6Kvec7cRUX402nEDflMnfCiiu6
Qwo4cIYhtRBjO4NynESx+iQ2mViPeDZeLFJ5N597ZshkZT+Cw7Obkv2ob83EpRs=
=szdp
-----END PGP SIGNATURE-----

--+rUxOyiVj+UVbdi4--
