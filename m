From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 04/10] ASoC: qcom: add dma channel control offset to
 variant data
Date: Fri, 22 May 2015 13:27:37 +0100
Message-ID: <20150522122737.GO21391@sirena.org.uk>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432245185-9119-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432245185-9119-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 10:53:05PM +0100, Srinivas Kandagatla wrote:
> This patch adds ability to pass dma channel control bits start offset,
> which differ in differnet qcom SOCs. On apq8016 dma channel control bits
> start after an offset of 1.

Applied, thanks.

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyC4AAoJECTWi3JdVIfQC6UH/jeVIyNOMobxuPEVoVE1Oqxw
VDHRtxPUDPAIx9T70oMMHX22r1+9JURdLO5T2C/02ImLGoPxoQAn5DlysSPjhRSX
bc4KkhbQhzr49aZLeMqVgQxjX4fIkaP8GKLGfEEYlJHeKWAnxwz5TfChvR9xDQ1J
KqphIhPmuylmiyVaxf7OISG9Ogx/B9DAxgUSxbOGAeCSvNwPe1JTjHrOcnClRjCZ
gTTV4Cxw1NsLTAmJVl2ZRCvta1lSmKI3SVLHFLN6c7fgkxcRQ8tslbP0qRcZvrr7
Z7F9wfKnJVs4zrRfYKrmu1ZeBn0KkJ5ir0O+zoaAlkx44jOfSMpvzFuLC3SnHcY=
=j/Q0
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
