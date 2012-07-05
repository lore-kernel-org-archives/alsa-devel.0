From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: imx-mc13783: Add audmux settings
	for mx27pdk
Date: Thu, 5 Jul 2012 13:48:42 +0100
Message-ID: <20120705124842.GF4111@opensource.wolfsonmicro.com>
References: <1341341098-9510-1-git-send-email-fabio.estevam@freescale.com>
	<1341341098-9510-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3929352744387695233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26E35245AF
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 14:48:44 +0200 (CEST)
In-Reply-To: <1341341098-9510-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============3929352744387695233==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="34/PV/2fFpU6TJrn"
Content-Disposition: inline


--34/PV/2fFpU6TJrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 03:44:58PM -0300, Fabio Estevam wrote:
> mx27pdk board also has a mc13783 codec.
>=20
> Add support for it and do a run-time machine type check to perform the co=
rrect
> audiomux settings.

Applied, thanks.

--34/PV/2fFpU6TJrn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9Y0fAAoJEBus8iNuMP3d99kP/RrYWCPtStZtp11qyaUc/SSb
egI3pW7G7MtDueToRB1m3IagfIB6+LTOFgFIM+q8fMudjiJhbp4vr+XHwAvIOyre
EDuvOFONz4NeeAgDy/4ImPlTNWlikg+bG7+uLX8gYxoHjcuYvNOFTyrqYK7SbKE1
xliaL+2wnmIWDsoy14UjHdkBZyDOqrxt/hEth+hZxUNRY1sMliAziFCbv1Cw/9UX
z+5+Csa+BG9s02J5IcoNFfRsWBE5pzpw2sqZfWkhQcuNcxStRBkl0bcfuHbWVGu6
0x5nHjtGgn1Y9HhNwH1Sh1993X1jj23Hcq5CHLSVZQAHE2bRnMRdECfD6n1eHWpI
HRR6Ai+9hIS1XA/0IsbhXIlqskZZI3kE7G3k1HFT7Crk25GeSG8ZiFz3xcNp4BZU
4iJwQiBZ+qKttUMTDWh3T3CFyr7MOdcVVMKeH5wI+H6qvFHJDE67oUyuqBW9NUxq
datIbLvGLzu4/EKrUIvVSFuajto3MIsUQxc6J2D8r5YMffdXt3kV5durEa/pr95r
4XyR/J4aY24aKJUAM3GMID4CuNdQVDwWDebJ+5mOl44udUnf3C4gw24jWoCO18HM
mfVsYZAEedc8YmZVa019stc+fYb4tXASV9vyw/zNHe8NJOKmnxzec4pSTvJNmwL6
J3flCye5QexOopxJQd5R
=rkfS
-----END PGP SIGNATURE-----

--34/PV/2fFpU6TJrn--

--===============3929352744387695233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3929352744387695233==--
