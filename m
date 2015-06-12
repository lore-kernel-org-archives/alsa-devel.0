From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Revert "ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai"
Date: Fri, 12 Jun 2015 11:34:50 +0100
Message-ID: <20150612103450.GF1921@sirena.org.uk>
References: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2015 at 11:06:08AM +0200, Alexandre Belloni wrote:
> After discussing with the Kconfig maintainer, we found a better fiw
> allowing to keep each driver as modules.

Applied, but please use subject lines matching the style for the
subsystem.

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerXKAAoJECTWi3JdVIfQhYMH/Ro6d+9IfS1pDNElW6OLG+qS
P+vgmrS3x6Wmv5sweKFpDS564K7ngCmEDoTRot6OTWxHtSrrsZbL0zyoM26HOrg1
9YlEWScteZcjw1UqYwCKIkBjQfoDE9DNFSDmTP5/bXkrlFu7OFvIabgnymIfZhG6
vAl9ctMZnOn+C4lcv4NIQjBYfA87FG7K3DX5411zdX0WABZt3gaVH7YwH2cVYrvi
bf00rjwnNf8DG1l1E2+I5fEycZR6/Cwzs+8SQodq4gzhI4oc2Qq50Hu/0akZLMzI
u0yEwQrq3hVyBgaasgM/pPfR3YAoaZ5TrPAiZ3YRd4qhOopJeatMZrLN8sWFBwA=
=DXh1
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
