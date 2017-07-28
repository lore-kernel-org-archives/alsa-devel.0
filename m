From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 4/6] ASoC: codecs: msm8916-wcd-analog: set default
 micbias voltage to 1.8
Date: Fri, 28 Jul 2017 14:40:38 +0100
Message-ID: <20170728134038.y5wnrurmwn4bxxsh@sirena.org.uk>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jtadxnydk6j6oohz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726003512.18965-5-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jtadxnydk6j6oohz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 02:35:10AM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch sets the default internal micbias voltage to 1.8v. This
> default value is required for mbhc buttons to work. Also adds dt
> bindings to allow the board level file to specify the required default
> micbias value.

What was the default previously?

--jtadxnydk6j6oohz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7PtUACgkQJNaLcl1U
h9Bdzgf/W1nQMB13RBksnYf8Xsw77buLMxYwQM3YoKwDN6xXs/LvrZywBBtUZvKI
x9jeptyuJLImZXooxAHXfMn6E5RiVrRFB1bdf6uh/WQsmrZX5syMLahtifPLrXS0
LLm1ABzGLp6Hnr356xH5WpprURpS8Q6rk+D+19mH3CHfP4E/WsA3gvfOcBJvKdOL
2uvKofYT/J3GXvfVkeGw5HN6lytGei212dllXYjQUoel6P7yjFNtwEbolJt/Wy4I
sGs4xBJOCoyrwF8oOCQoL8RgSQkN30LYuDFvsE9+PfkO/46HByrRn+8GxL3HCRMg
PThOfYdr6BVyQY7eMCYIRxsbG3Pqbw==
=0NER
-----END PGP SIGNATURE-----

--jtadxnydk6j6oohz--
