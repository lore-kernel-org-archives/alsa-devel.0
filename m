From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 REPOST] ASoC: add xtensa xtfpga I2S interface and
 platform
Date: Thu, 8 Jan 2015 19:52:32 +0000
Message-ID: <20150108195231.GB2634@sirena.org.uk>
References: <1419614378-25229-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Av1MWY1rjlqAnvVo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419614378-25229-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--Av1MWY1rjlqAnvVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 26, 2014 at 08:19:38PM +0300, Max Filippov wrote:
> XTFPGA boards provides an audio subsystem that consists of TI CDCE706
> clock synthesizer, I2S transmitter and TLV320AIC23 audio codec.

Applied, thanks - the revisions to the RCU stuff make it a lot clearer,
thanks.

--Av1MWY1rjlqAnvVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrt//AAoJECTWi3JdVIfQpEsH/39taBhvaryU1iekn0D0baHs
Gu1Rx9s5Z2EUqp3nLOaGOaoeyiNfLO3LKdPffzNOg72GSpZV7rtDS9Sibi+LMQW5
l3HeiTEkGmeYE5s0BBp1rqImid7UScTWw6PR0QY07ECUKZAYc+hG9vh8hlwqly94
nif2mjW14hj7+nhIIAqZnhwnas9VkRRoW3/td463a3it7vqyIpYofp6TzhgOj05v
NBKBUTJ7KSmFcU9AQFK9Zv6IG8ZiG1M4pgWvHLBO35VtUiXa9E86D+g9GKLVA8ty
07obt3Srhk0t5CjSBHWuEnQEj2rfKmlz4Yz29hAuSlQQijR7cFdxjhnUhM7kKGQ=
=RncA
-----END PGP SIGNATURE-----

--Av1MWY1rjlqAnvVo--
