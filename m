From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Thu, 8 Mar 2012 11:51:27 +0000
Message-ID: <20120308115127.GI3638@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<4F57CDAC.9030604@freescale.com>
	<20120307210833.GO3107@opensource.wolfsonmicro.com>
	<4F57E924.4050208@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6301857068253185764=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E57B610BA33
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 12:51:28 +0100 (CET)
In-Reply-To: <4F57E924.4050208@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6301857068253185764==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6THr7QwYWIbrk6Kt"
Content-Disposition: inline


--6THr7QwYWIbrk6Kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 05:03:00PM -0600, Timur Tabi wrote:

> Our exalted maintainer apparently forgot to apply this patch in a timely
> manner for 3.3, so it probably won't make it.  But that's something I'll
> just have to deal with.

Probably work asking for it to have a CC to stable added (or ask Greg
directly if it gets applied without one) - people are getting better at
deploying stable updates so it'll save you some pain if it's in there.

--6THr7QwYWIbrk6Kt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWJ0nAAoJEBus8iNuMP3dLHEP/0dRYff4VZ8zOYSU3qJYtseV
3q+vXiKdbxoPbOQGKp1MG9aeJXpMIM3Yz0Ba50AACCwFt+pg5er59zxwPtlQTkth
oeNU242jhc49pisAw0pFD0ZVvzhJEc2I5PzmwApHv7jErU9MzgwxkZLc5xRSGpr+
mYqduhC4n+SJixenB+zQ/oyXv5NZ39Tl2Rt4aFICQHRVObnlv3o0mQ97DYxGYPCP
9DQH6UIPqevu4snm6yUdrEh26WMKUxuFMiTNtEREJuCPZOnu8TyWGVBUQ0QR7uIB
qlSOifed5ka62GolhGsLNAXJMT2Uuaq4QOvCl7RHmAH159MQjprp7rVidsMXLeY4
5V4N7pTsTVWpZlp2tz4eQxoek2fSzABvKx36e3AbUIlc9alRWUHZayWQcpFyKHq3
Wfi/Bly4s3VW+2rkpFrTFaU/vP7HzNUDd24tj4SSzXtHKk3bKeXVjCScVJwO4Ebl
yNQc5DTeJpR3d8WA2byEEFosse4XXvJPzB3U75f6ZjCAXPqWfnXyE83fh230xgA7
JAe31lAR2PB4tsRptri/LndD7M0qVDgb1w3EvSn5nO7cmDjYg2MTJL9lipqPDfpP
ltQGbgIgjOf9dG8Gkusfs7N3NGrnfUXTg3AuON2OnpUXJ/r3fbpf+8bHAg5X4m8t
h57ESwegb+6h3l/K305t
=tU5d
-----END PGP SIGNATURE-----

--6THr7QwYWIbrk6Kt--

--===============6301857068253185764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6301857068253185764==--
