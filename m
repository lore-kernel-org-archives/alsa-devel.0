From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 071/102] ASoC: wm5100: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:03:55 +0900
Message-ID: <20140223030355.GL25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-44-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7696446253204583650=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 702BE261606
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:04:12 +0100 (CET)
In-Reply-To: <1392723517-12772-44-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7696446253204583650==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aq8k2F4XKnGQvi/k"
Content-Disposition: inline


--aq8k2F4XKnGQvi/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:27PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--aq8k2F4XKnGQvi/k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWUYAAoJELSic+t+oim9SGwQAJeVZBIdAhwYsUhgOXldpofk
PH7YnKEdySPJPJB3187iclUZSFayEPkpJ7Nvbnd2B+jI4T1/ZEAAwmCd6aigLjjU
f0/VNrpHfDpj08k+WCMM8aqJCm9v1UV2lWKiWUB7zWC3IWwcmerKk9+x91jXPHp1
xSPbtJbmiBV1PyFwrBKd4M15A59jSLlxc0yGd3FETcZn9+xtfAQoC2O53TDRLiK2
1YlPNnEMUvYHMODGr83hRZnSbysZb6k/2dKF8Rmpjmc0DtywZE+WVwL21gqHABnM
yp3RjAWbscbpqquFhzQuohBLk84hZL/N9WW/BwS8cbuOK/Y6oWyzIu4wyFg7ePCS
daBkpLN+1Ss91rtRPO0sHW6TBuJTHS9vXS1UcuX3I3L8W8aqMTDEBrg1JLZur0RD
0LvMLa3bJrMbP+vU5VTOUxakW/uN9wdzWjTjymuIHokkAxmYmG4l3hSa2HGesX0v
tJcETM/l5vt+CEo7Fo63L+x6ozgZV7AbPwemOEH95ICYr0s2JbMfv+MCsXFZ3mS5
ROzPhYpKyYcaFaUn/pYTgZ8ENZYDP6AnUwwrxQmGxZ6GhI3HCbGlnADBsG+yCcg9
31hf4DH5+SDIekHCkmu4Git4Bb2sKIqscJKfGqMo9cB9oYJimtismFYfieOAXHTY
yHbk2vAFsptCSOkvEh6A
=+KON
-----END PGP SIGNATURE-----

--aq8k2F4XKnGQvi/k--

--===============7696446253204583650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7696446253204583650==--
