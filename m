From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/2] ASoC: qcom: document apq8016 sbc machine driver
 bindings
Date: Wed, 10 Jun 2015 18:29:43 +0100
Message-ID: <20150610172943.GI14071@sirena.org.uk>
References: <1433938505-18006-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1433938544-18076-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HpDjbfe7vL9q4QWh"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433938544-18076-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--HpDjbfe7vL9q4QWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 01:15:44PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for apq8016 sbc machine driver.
> APQ8016 has 4 MI2S which can be configured to different sinks like
> internal codec/external codec, this connection and various parameters
> are controlled via 2 iomux registers.

Applied both, thanks.

--HpDjbfe7vL9q4QWh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHQHAAoJECTWi3JdVIfQr1cH/j49ZJ5Y7wCDmVU53fn7Llxl
qQrRhovEb0ffXOYPAXoVYf4YAG3VX452ssMFK3H8jkdhDfIMWIo7pbsCgQQpjpex
bhLmKsSMOabzNLRQejavDVw53gMcRowtho9PXRmFOZ73dVTAVnZ4GiwwuuJ6GaM6
ic/tTdFignZUPC2//qG1PbLIz3uQtY+7EzjO86BS67r/YzGY3R1o7oyM/CYbbtMx
JHTvF75NSBFPH5vYzpayZM8PVPfiKoQe6j5qPKAe1XqAs4ksqY0uX07MXHjZgsxm
ykR/s9k3KI2Pyb1YkuAbUdcH2Ka3+tPADCNaYm1Cr4dOi2zHeoDDDS4RhRCisXo=
=AKi/
-----END PGP SIGNATURE-----

--HpDjbfe7vL9q4QWh--
