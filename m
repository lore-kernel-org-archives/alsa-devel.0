From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: uapi headers - add missing
 include for stdint.h
Date: Thu, 30 May 2019 17:01:04 +0100
Message-ID: <20190530160104.GT2456@sirena.org.uk>
References: <20190528200206.2793-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4259184781253772828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E77AF8072E
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 18:01:08 +0200 (CEST)
In-Reply-To: <20190528200206.2793-1-perex@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA development <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4259184781253772828==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ep5m4srWGXPl6O+g"
Content-Disposition: inline


--Ep5m4srWGXPl6O+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 10:02:06PM +0200, Jaroslav Kysela wrote:
> The modified header files depend on types defined in <stdint.h>.

This doesn't apply against current code, please check and resend.

--Ep5m4srWGXPl6O+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzv/kAACgkQJNaLcl1U
h9Chzgf45u8mFRSS2x91VfzxXpKA182jYEMSNfLkABrgLvzgyJqXGiO/32nNdEOe
LMhpwVDUdsw15uFPRaGDpbwZKFRaMgnqDhNyDxrmOFCuKdBGXoxiTkIs/oBKZXM3
zRyJ7ROQrFYYL0PY/zhuQ2ws+VifNYKMC/kIp0mIg4p6fVCCyK/QqlirvkYt61iE
VAE3Z5figOtl1+rcSuMC7anbpzKTRQ2WEN2Keruk9pNpSYA3aXY9voLzXMctNNt0
q4Fbn3oPDxyuuOZ4WCGdBs7hvrExU5nv5cpfgFZM9TLDHenVy6kjgSGdd45xwBOm
O7v2y0LeCmMiDjNBHylSX+KEmwYM
=H0Gd
-----END PGP SIGNATURE-----

--Ep5m4srWGXPl6O+g--

--===============4259184781253772828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4259184781253772828==--
