From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 7/7] ASoC: dt-bindings: Introduce
 compatible strings for 7ULP and 8MQ
Date: Tue, 30 Jul 2019 13:04:55 +0100
Message-ID: <20190730120455.GA4264@sirena.org.uk>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-8-daniel.baluta@nxp.com>
 <20190730080135.GB5892@Asurada>
 <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>, Mihai Serban <mihai.serban@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 03:02:30PM +0300, Daniel Baluta wrote:

> I removed the 'or' on purpose because I don't want to move it
> around each time we add a new compatible.

> Anyhow, I can put it back if this is the convention.

You could convert to the YAML binding format and sidestep the problem a
different way!

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AMmQACgkQJNaLcl1U
h9AMEAf+L6HeZMKwL3JgS35lz8KJn8puYlz6JlAgu8b5kJD5U15z/ScSQXE8uJOt
CMauZ7x1gmPQXGEdGQHFSFa365yso1EB4MgsReZDTurM0YYdi9I2038gqzLrtKB0
r+avuU0EzhaljA0ZugeMbEN6v5YiZGf2yrlzOFUyyUb83zTCFQsHscmnH+cw5QCH
HhjVqWPaGLUKuPmJRWO8ol9QMKghvRP5y5N2e+Yohj+mb3xNHdHvXN1Qa/G9koeA
uJU3R7ifuKcvxbGmu/HoWpcvfpWVMPyF/ej2BC2i1uKdiwSsvxFrN3OP8EfUlL5p
syfgAj372TEvfhTQ/2190PTyHrr++A==
=VqB7
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
