From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] ASoC: Remove codec field from
	snd_soc_dapm_widget
Date: Thu, 15 Jan 2015 11:57:50 +0000
Message-ID: <20150115115750.GY3043@sirena.org.uk>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0945423145694471022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F4FC265857
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:58:00 +0100 (CET)
In-Reply-To: <1421322737-19077-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0945423145694471022==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lPJ5i9rX1WvdYcWF"
Content-Disposition: inline


--lPJ5i9rX1WvdYcWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2015 at 12:52:00PM +0100, Lars-Peter Clausen wrote:
> This series is the last part of the codec field removal from the
> snd_soc_dapm_widget. One small fix for an issue that slipped through
> earlier and the conversion of the TI and Realtek CODEC drivers and then

Applied all, thanks.

--lPJ5i9rX1WvdYcWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt6s9AAoJECTWi3JdVIfQ0eYH/iX0RZ/5/QYN4rrkmKq8HmLP
15bVNiEqcpYoVOdnEQmbV/sHKjfPOz0+XxKcfwIkOibwWXYUoK4KMB9MYDszNqDj
wYfSNl6tXmmNG80Zz0l6yn88/zYc3BoS2naD7ivUALcWEIG/loH+iB4JCDgUnqQD
65N6K87Y7Vg1ZgGvNuOaTso0Ti6q/9/cVfBTsanUk9lOvdaMdMVg6ouXR+zKE7pO
ZNlptUHkhdqDxbGAik+h2bYySxsOGJB4vqwti12C18Bm4+RrBe19OOwsTtaveiZ3
b+5qOghWB2ivfy/kkXFrHZt2/7CBHJVTUbU9iWzfuDzyR/tdwmWsQGg4zT467r4=
=CxcG
-----END PGP SIGNATURE-----

--lPJ5i9rX1WvdYcWF--

--===============0945423145694471022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0945423145694471022==--
