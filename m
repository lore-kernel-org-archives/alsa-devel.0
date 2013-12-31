From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix the DAI name getting.
Date: Tue, 31 Dec 2013 16:30:01 +0000
Message-ID: <20131231163001.GI31886@sirena.org.uk>
References: <1387521591-15262-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4cXE7lVpOAUQvDc2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387521591-15262-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--4cXE7lVpOAUQvDc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:39:51PM +0800, Xiubo Li wrote:
> From "ASoC: make snd_soc_dai_link more symmetrical", can we see that
> the name of CPU DAI maybe omitted. If the DAI name is omitted, try to
> use the component name instead.

Applied, thanks.

--4cXE7lVpOAUQvDc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwvEGAAoJELSic+t+oim9eDIP/2whyUEEHZPryiJ8DMM/MPWH
kz4nRphdoH/9biYL5Wo57VvswthxxgIcGSFciVXJnFVBUVSwcm0eoipuuRY8eMPD
1rx2IEv1qfLV5hwyd2L1IuFSw0zFEP2GxUZDVbaEoaErAsA2izG7K7xedUHOrDl0
ZUg9hmGqJQ+mK1nCMOpZ+WPofOlolxGyNusNsy4bASYcWqfxTWtGfT6G4Q+8ryq3
g9RYHC9g1qOmsNI5wDW8+3YGKUSWKw8EpPSvH96luSCjSXYuQpESLyEnrQluBdky
37faJUhxWLkol7ru+2dceHcoPTJiBXWjuLXxk5ehIkubeOoyGvcXQSOfyg+zBYMI
tfLvHijLCg3WgbzOZ4iMpAbeKxRCTG84kALJOdPzGdcWROG8c4yxpOT2RpaJhJ8s
fH15XUnaXb/mXJ2hrDcmSg6opbusiafkaG006aZPFNUVmsW7kLbmd2yjg9EReOdY
SfuEy4jy5HKTRoi/CSCMbysGwuuvpo6G7nVyq2WDB9o+Tgj/hvHAjdpe8vRDU8oU
kUlNIU8wv852GL9THAyNn9Wi+ohgcxlHa0+exzhJQB7U/piuFHx+3aek3s0EDc8B
ZK7KcOwTp9+yRRuhqN1PPVorDO+mlDW5/M4M5c/M1F858Bq57p4q+A27MJvAExiv
y/Iq/uG3/KaLhpB9/5o5
=81ZA
-----END PGP SIGNATURE-----

--4cXE7lVpOAUQvDc2--
