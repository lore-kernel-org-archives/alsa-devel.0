From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: boards: Add bdw-rt5677 machine driver
Date: Mon, 29 Aug 2016 08:25:46 -0400
Message-ID: <20160829122546.GR8799@bill-the-cat>
References: <cover.1472071966.git.john@metanate.com>
 <e78e1411cdafcffa7e0693b257dd8e32571f9fc1.1472071966.git.john@metanate.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PY8tzLeNxmyMVNR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e78e1411cdafcffa7e0693b257dd8e32571f9fc1.1472071966.git.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, Genki Marshall <genki@genki.is>
List-Id: alsa-devel@alsa-project.org


--PY8tzLeNxmyMVNR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 10:06:36PM +0100, John Keeping wrote:

> This is used by the Chromebook Pixel 2015.
>=20
> Signed-off-by: Ben Zhang <benzh@chromium.org>
> Signed-off-by: Dylan Reid <dgreid@chromium.org>
> [john@metanate.com:
>  - forward-port driver from Chromium OS 3.14 tree to master
>  - remove wake on voice function that isn't supported by upstream rt5677
>    driver
>  - remote owner assignment in platform_driver (Evan McClain)
>  - convert to devm_snd_soc_register_card (Evan McClain)
>  - add a full copyright header based on module license and Chromium OS
>    Git history
> ]
> Signed-off-by: John Keeping <john@metanate.com>
> Tested-by: Genki Marshall <genki@genki.is>

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PY8tzLeNxmyMVNR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxCnKAAoJEIf59jXTHXZSoCoP/36eiINgQXJGMCJsXWYCuQ1J
pxroa3zwSSifHThcGZo34a0dF3bP0xi1Pyc9zX2B4GrDw6vPOQb14hg0fDKju7Vh
pUUQWGrvQyuZ37OVtK9mSrTXueNbaLruSu4pRwUIFpjXIgGNe0UJJThAnwb6fHnz
e/y4uJ/9P8znJuEkilhMi+74GDs2JFnxlXTB3HUCsyPfNRg8ud4izJzXql9Ua0ZQ
D4Bg8+HpX4a9DP/m8QXeoncZ1uKOxj/UB1UgRo7eMSp6j6ikN8QINr8gU3M5Gc6O
N7abAnYnGsSqebVFxUUTJkl+aGt3wgRo7Yw6cApZ6QwdfZvG9ZcmRbZ6M58wlAnh
wg1LTcI2NwFkE+1c6LSpx4cebeSUKQFWYuYgRXxS4pH0QmvddbVYdJ0ljLL2HheY
hnqsAgmH9AKVbw6GoWil+8Rw5H/stAhlheSYpq76UGMocRAmp67gg9vAlH5jYL0g
1SDMTt4HM3BEbCl/ojV9EpJG4DuDZ0e/6dE2comKQrSTMp4RgVJpJ6q/fwnaIRr2
kai3fI8hHX7MVYKLzQQ5zna34kMLOT1DRb5kU4CIMdSdCsPQlXw/L2l6qUoPvnpd
cCAtYpnOcHmhi6J5bjaYSFvf+b3QiUs+s0omLRugMgGxhWYPn7yM+rrhVtrj7f0q
4hdhnLvwxEtEnXHF31yv
=8O7e
-----END PGP SIGNATURE-----

--PY8tzLeNxmyMVNR3--
