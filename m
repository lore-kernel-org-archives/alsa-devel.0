From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-mc13783: Make
	SND_SOC_IMX_MC13783 visible again
Date: Tue, 6 Aug 2013 23:58:33 +0100
Message-ID: <20130806225833.GS6427@sirena.org.uk>
References: <1375822987-12830-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4734768722379304705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1C02616FF
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 00:58:38 +0200 (CEST)
In-Reply-To: <1375822987-12830-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4734768722379304705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqSMaTz1cCSspCQ4"
Content-Disposition: inline


--tqSMaTz1cCSspCQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2013 at 06:03:07PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Commit 02502da45 (ASoC: imx-mc13783: Depend on ARCH_ARM) introduced 'ARCH=
_ARM'=20
> as a dependency for SND_SOC_IMX_MC13783, but this is a non-existent symbo=
l.

Applied, thanks.

--tqSMaTz1cCSspCQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAX+WAAoJELSic+t+oim9oJUQAJthHVy63chC1U6nahiKT8OO
YyAu1exqwu79w2JCBGjMA+VkTonXALYCBjIyyUvt3RV01/p23PuE9ha/S4MWaYAD
KArtbPdOoN+SN4LrRxXVUKhKYzvZm3pZLwzpL9HUgb/5FMGDcObFrj7afVR5RtUO
cL4vM2OVIyxV/utt7cXVo+3pc54WuBt0Ej29EbkcuHH0Rz4nPLdVfCmVWvKgmu0v
c3ErdGFZP6UXDQQRbRsBfE6lDLiUqyDc5frxkBxBf8b7c9euRiEUceyqYlnfnQuN
/K4R7dOTSdfpNgxIAEXb1F9xLkMAjUkvKcF+AcURvzN0MV4ssopUqFGQDnWRLcXR
OoP7UpAbnDsmPKG46sMG7HCPxClk2xne0EyxG6LceBgWTEMhBusM5cPXOfAXzP9b
cEUg/6LXyquPwjhinEOxQw+DEUlca/EzyZ8xnDoXcs/CHdPsME0KBqrKrEPD0RQ4
svz7zEBfh3EOVl6MAQH6buAXWgfUNN+0hipqhI8ZxCiqQTaD+Oj/HCrSKo49mCyR
YaAzknIoVsmDZWNQbtg+9E6AHMdRXUH4KjJnGM+3ASfmpG+H5o1u/C4nLM69dOwJ
O1PTjkulDmB0bHaCFf/YM6ACer5j4NBcNAcUcvIlGk7dNODuH8uh3EV143RSiMsB
Ol12+6FechXqxnqrCeAO
=7ReA
-----END PGP SIGNATURE-----

--tqSMaTz1cCSspCQ4--

--===============4734768722379304705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4734768722379304705==--
