From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Crash when probing imx_mc13783
Date: Thu, 26 Jul 2012 21:20:26 +0100
Message-ID: <20120726202025.GB4560@opensource.wolfsonmicro.com>
References: <CAOMZO5B4Z4jACQFt5gy2o3VLqGrQg+bXcN12ChysrQphYNxQBA@mail.gmail.com>
 <3192997.N5KLupAYnr@laptop>
 <CAOMZO5BsOV3X09DKc-uexe9mqhYhkbmKZg2vh_h2-hBB=X1A7Q@mail.gmail.com>
 <50116D38.6050001@linaro.org>
 <CAOMZO5AFifTGBt1=Z87pqp9Go9PkS_a5Mcu2+MMLCzFGrzqANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5639248029264085111=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3B50265F2B
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 22:20:48 +0200 (CEST)
In-Reply-To: <CAOMZO5AFifTGBt1=Z87pqp9Go9PkS_a5Mcu2+MMLCzFGrzqANA@mail.gmail.com>
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
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============5639248029264085111==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 02:16:43PM -0300, Fabio Estevam wrote:

> +	codec->control_data = priv;
> +

> Will submit this patch shortly.

Yes, this looks good.

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEaaBAAoJEBus8iNuMP3dTtsP/j7cOLtTrLajlEqAKsbLZMeL
QIitmAXOyBf0YEkO6gYkjfsFW2AC6M75+kgwSyFEgFYqMqKfhkLQmYKlfvqg9dGu
0BQ4qZVYKPP/mzJhGm97p1QeiPBIXJf28TFb5zx+sJ3WgjalRLAszc807yzNTz1v
PHwFdQGwr3yBu2dj0RdFgD6qUGs9ECL/k1sJbQd/28Q1/J7Yer7EkJ7GFakDyirX
njQ1jpUcj90uzpPr2cCqONqEwBz+NH0e72I0T0ML+Odmx9ThW22/tMwJ7eQaDzJG
8JImS4qyFBMFchAYQyHv1oXrc+SWsEGeuEm3Pl4Uzf4l8MpfmMbW9A6M9lTRdo9R
u/S6AyC5RNklUQ+7P+tXsvKuJVmd1k4dzWU7P15pBpYMXcGxQe5i7bt4wzey+rdC
QT/viTsEz7S98UhkXhFJ3rg2S7wsWSC0H2xmOH6ZvGyfW5H/wMB9G5zvCKu7Kh1l
vR0czKThXbRfKbZwXbRAOs7EXNO616vjMbbbi9/xXZY3TnRjj6PlELQwzOBwInkZ
0w3Cj1AdnAxzZUeH6bidlmQv9YP+xcwmk1+C9znVSDzYUDm+sTe8cWn6cJAdai7t
3NHKDJp4dXr0p+yraN4/jXwm64dyRNMpjAq6y7dPhT6VC95fOyt5BLxDR/Yw8s/A
tcYK+2KcSyOIOBeQMvg0
=gBgV
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

--===============5639248029264085111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5639248029264085111==--
