From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] ASoC: atmel: fixes for working as module
Date: Mon, 4 Feb 2013 18:34:30 +0000
Message-ID: <20130204183430.GR4720@opensource.wolfsonmicro.com>
References: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2013 at 11:53:36AM +0800, Bo Shen wrote:
> The following patches fixes the audio part when working as module
>=20
> Bo Shen (4):
>   ASoC: atmel_pcm: make it buildable as module
>   ASoC: atmel_ssc_dai: remove error set private data
>   ASoC: atmel_ssc_dai: correct sequence when unload
>   ASoC: sam9g20_wm8731: disable clock and correct sequence when unload

Applied all, thanks.

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD/8uAAoJELSic+t+oim9fI8QAJhfjNvAMLWfOh9D+qNvZ9wX
Fpxf9Dvk4Mx8IBUMWALzc55crUyUNef6NYMcahStxXp3UKLDcUGLrgw61Lw9soT7
Q2vwnh3X1Wbd6EI+4NnzULSv5e6kJDSooDfrQbg53OjRyiK0p26jy3GFD497OtGM
XIvwv+Egtz+C8kd3UNiEZ+DRZa2iqISGw71SigkPUjI58pyTSk/5TAB7iS+40IRC
BY0DTEWRYjyKl+Kgf4IF+rKOIV8qekqq0kCpmkV5J6wNyFCt2/SKoNG2h9QbSOyi
C325yyE+DC5ng6Dm+BHC96KAZ29ivKPb0TEmnDUfRC5in/3pdw4sc/07HPEXxPZT
jVH1mtmG11y6vGtR08V24wH2MzwaZ4eAMYtmVG+pEmk15AKZvhHeuV2ZYmqsrhZV
YyhYaVaXRV8E9lRncbGqO3/NRCz+zecqjKXz9bPqAEXm3yHt3qe4z7xO68aBbnTH
0UWfL/ooyjucl4mXdZHjHO1d58y1FfW3Lw088hYvc069bLpRJ+c/AyNLpILIX9Uk
b9u0ba/tAj6nO2VEfCscGXbk+nM5mX143hhE+xfrRhvpdn5fyESeVGpuJCFLXUAd
gOL/3dbAaOE7TMZnFzs7lOqCKnL935abQicjnZrroeqYdKRmqeu1CtPAQCP/Y3ab
PgXzM911iVH/FudDNMqW
=FkwC
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--
