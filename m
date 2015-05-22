From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 03/10] ASoC: qcom: make osr clock optional
Date: Fri, 22 May 2015 13:27:29 +0100
Message-ID: <20150522122728.GN21391@sirena.org.uk>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432245177-9077-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432245177-9077-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 10:52:57PM +0100, Srinivas Kandagatla wrote:
> Some LPASS integrations like on APQ8016 do not have OSR clk, so making
> osr clk optional would allow such integrations to use lpass driver.

Applied, thanks.

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyCvAAoJECTWi3JdVIfQwtYH/A5zmwAOkSheQWviP/LxR/69
DnAJksoZZ3M08DPBn61a7OS8sZQQtdV0Oka2TCjhw9LO+LFPESBhKGJalY1Wl7Cp
zvwUdzdvPN5/9rqJam41/ZLBWbIt0u/i5wakOnhu0xHnHdkURUa7CuJlfAr/6IBW
rKO3VeAISeUXMTgkvQYn3JzNTMbV+iRZHVS9kJAAokiVK+4CKWGkpVBmOKiv9M5O
Tav+IDEyL+FaIeKizKtR8mxvyGNZSz66vrIgsXYpRAbx0yY0wLQx8lMGSIeDkj/G
KC3cDxi6XBaQ1zchwssJJ+14b4NtD0rfRUyE7c7U5ukk9dcCOsRE9oqo1WTsDKc=
=XAfW
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
