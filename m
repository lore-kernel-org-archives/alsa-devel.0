From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 24/28] ASoC: intel: sst: drop owner assignment from
 platform_drivers
Date: Mon, 22 Dec 2014 11:46:16 +0000
Message-ID: <20141222114616.GD17800@sirena.org.uk>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-25-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419196495-9626-25-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 21, 2014 at 10:14:45PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.

Applied, thanks.

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmASHAAoJECTWi3JdVIfQgA4H/0dwQoP2nZcP5uyxPZFwUN+V
EJ3afFfJ7wi/m03A+zFafcJDHPrQwHy1uBR+8cd7INSdJF8rz9xX89Pe/+rPiM2f
vJyockqQH4a+3eQsFKcO6muHFDGcWQBu4ukYJ2udxt4U40lKcvMqpPecBMluJr8Q
FLl74lsVgDwWOOdnX+EYRHLtSJhdrpGLOLusBcdIybwlAQX/VEixamXY/hXjj8ew
WXHW24mh0927U3fNejO1nXFP8MmzHStNLr9yzggWSKF7ZuRUouJlzQUYy4FlKEz1
yAeWcxJPIRgQvwukvf09YJ79jw94WgMIuf8s/+WY1tmQwrhrQ5Ejn5ZgId9zxas=
=Flip
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
