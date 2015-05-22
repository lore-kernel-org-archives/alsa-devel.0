From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 06/10] ASoC: qcom: add bit map to track static dma
 channel allocations
Date: Fri, 22 May 2015 13:27:53 +0100
Message-ID: <20150522122753.GQ21391@sirena.org.uk>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432245201-9234-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432245201-9234-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 10:53:21PM +0100, Srinivas Kandagatla wrote:
> This patch adds dma channel bit mask to lpass data to keep track of dma
> channel allocations. This flag would be used in apq8016 lpass driver.

Applied, thanks.

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyDIAAoJECTWi3JdVIfQPwUH/3zl6xb9aN0vNsppvXW401Eq
ge5yry4JU2xes+z2ekn73xN2lRj4jAozrrR/2hVPKCsbpHOm87bjUIw9aiu69SPX
/8aPfcz6GJioUnj23OnVK8AFcBw4wnn3/r5jBIlpzaaqx/c5nC/enR4UuthdIYSy
Yl3q2SU3IsG4I/bCrO9/LX0hj3Skv9aTiO2RwhBAVChlXCoch4TETlEygj0oOajP
5VxGjkwqiy2x1XkDhVJytFmkcO7HqzygDdedO9YihYsjUDqXfz5pP6augG6hAyqN
SAIVoGdQeP87MOqn7f0Kpy/QbVbhPZmnB57fp6OKD4UdK5N/G8nmrQrnt1KUShc=
=4IsJ
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--
