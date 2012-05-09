From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/11] ASoC: Ux500: Add platform-driver
Date: Wed, 9 May 2012 17:39:04 +0100
Message-ID: <20120509163903.GI3955@opensource.wolfsonmicro.com>
References: <1336485444-27369-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8550712524382333523=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE3D4103EE1
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 18:39:08 +0200 (CEST)
In-Reply-To: <1336485444-27369-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8550712524382333523==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p14GW7TY4DvKqgVo"
Content-Disposition: inline


--p14GW7TY4DvKqgVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:57:24PM +0200, Ola Lilja wrote:
> Add platform-driver handling all DMA-activities.

This looks good but it depends on the first patch which needs a spin
(and review from Takashi).

--p14GW7TY4DvKqgVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqp18AAoJEBus8iNuMP3d7OkP/A5azm6zYJxUV6+yyoVoYNce
pOzrAd18anjEOB2AKwDJ+D9mS9XVcVOfH/5AFmzo+TI/N+zLJgb0B8UP1RBbHFkP
cjTiDhlW7niHAAsop8kdM0t/TfW4ngwvEckPSCm1vc2p24BsYvHebBibkUW0PR6A
WlFy8UEmNQpbbc9BJtb792GoqVUa3CYVuGQ8TVL3htzbn1Z1Wa+5p2gZnLhoEz/J
TCgNGdfeyvPuInwzH/aKM+pW8oeenJKJgLkp7K5jcPwjMakfV6bse0a2NCMfnwa2
dn8CU+gciBQGakiTEX0SPBLPpsz/+ymZDPqCzG4YP5IRGt9pqROe7ZaUZKCq1cIe
2DEKna+qoClk65HH97EktjXCe13RIt08gN74IO4YFAlqAx16dO3bSijYCwopSxDA
0qTnplonS8Idp8uV9vgshWLMksMzgkXPIzeJNY1Ro39ZjYgPCkBv7C2IppprCKHu
7a9TM6cjW05FvQWiIoxhKAc4HNodwoZtp+BMzuWmVoHsJR7jZxOMFDkaKzVg+xBL
SGvjFF6YLscknTxGV9SzIXuz3QX8yy9IWLxx5mLLnesAISupeOqa383qGNJo+k2Y
RZENMG+MqQDu6Q63BjpJ39RSC89PTRaTHMlzbuf5vCeP6aHt8x5uTLwVVI++R/yE
mXmqoK2YO+levjPIsBN9
=FCxg
-----END PGP SIGNATURE-----

--p14GW7TY4DvKqgVo--

--===============8550712524382333523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8550712524382333523==--
