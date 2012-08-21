From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-compress: Remove unused variable
Date: Tue, 21 Aug 2012 14:53:35 +0100
Message-ID: <20120821135334.GI7995@opensource.wolfsonmicro.com>
References: <1345556910-24729-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1990935179260591853=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8AA5265F1D
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 15:53:34 +0200 (CEST)
In-Reply-To: <1345556910-24729-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1990935179260591853==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 10:48:30AM -0300, Fabio Estevam wrote:
> Remove unused variable =E2=80=98codec_dai=E2=80=99 and fix the following =
warning:
>=20
> sound/soc/soc-compress.c: In function =E2=80=98soc_compr_set_params=E2=80=
=99:
> sound/soc/soc-compress.c:156:22: warning: unused variable =E2=80=98codec_=
dai=E2=80=99 [-Wunused-variable]

Someone already sent a patch for this.

--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJQM5JrAAoJEFJkBDiqVpZ4TNcP938rcc/POaY0oeTlw9t8T+jS
PIyu9mVXKE7vv/bEM3vnspT8O2EidKabM8QXRiK5blLOk8SOHwwE/hUZjH3/gTNS
dqWmN/0Sd71Fs3+k3goAzXjTztg/W3xkBjjigxy1zGENWU+oydfCT7Fzck9DVILw
u0YLfpi51cp9lq9CpGRIZ3/Jni8kF00FmFVsYCHiX42unQ6aMLjity2UxWKnE7cK
uRth8ca+VGcUW446HW3XOG7Uojc6iMuwDLng2fXtx8KfftSSmKZltDtsqFlgywo4
rtOMo9aipizEMskB7GXDCO/f/lCL+rv/ImMSg9mvErHYTK/h4QOTMLDsClVy33AP
KSHBJJN90QXjNwVKS1RWgEsIVyxo7EzoGexzs/bd5fyRw0xqBkqW1/8DaHOy4wIE
p8uSf5bXo+DgDE5+DETbGg28ov7GVEBnrJ5BPRbX0xBCoQRGFgbVQ83BByrX4wO/
WqljfXPOucRKvH+tA+mCmrBripO2SyebVrhFP1zF2sapaNZvm1Imu7RonpN1aeE5
vPlBCcEdnqsW0SZW0p/VpenMrC/LGTTn23KPBCCwsEgNlJzKMo6pC1EnTHwXbQV3
xKLqg5LTc0FHLRSSlv9mJzuVzD3FWz/x16Zl7YPSYPJVSycqLuTKIPydQBKfMOLy
AOS11ugeu6wGMV2nm80=
=kr4h
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--

--===============1990935179260591853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1990935179260591853==--
