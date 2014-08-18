From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix the compile warning.
Date: Mon, 18 Aug 2014 11:42:46 -0500
Message-ID: <20140818164246.GJ14537@sirena.org.uk>
References: <1408345215-30783-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3021079655104001200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3917261A8E
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 18:43:37 +0200 (CEST)
In-Reply-To: <1408345215-30783-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3021079655104001200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fze0sZZmuBV4A+b2"
Content-Disposition: inline


--fze0sZZmuBV4A+b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 03:00:15PM +0800, Xiubo Li wrote:
> sound/soc/generic/simple-card.c: In function simple_card_dai_link_of:
> sound/soc/generic/simple-card.c:198:10: warning: passing argument 3 of

Applied, thanks.

--fze0sZZmuBV4A+b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8i0DAAoJELSic+t+oim9bwcP/0vAEi0N4JrCACScewFLYdyc
VeRM8R/RhfAZiCLo/YfDxxR/OFG3j1eiSHFqtRGX0bWE3WDvsvxXCBlEiYH2i6w/
fLJUwNKF0Tc7zlXwG6CGbvp58oceTuMdcRFNyEhVVuuaAKi3TOaQv4B8Bkf0n8zT
PD6lKKTmLLAuHIjLsICdyh1+HUdSiP+I4gIFjwawIhVIKTIepIXGAwFHDWCtVDLJ
vFWgkV5LKw8RjTCXwmNrvgVbmZwLeIv7q6q/AYHEzXHIjccMWW9FsyX70r6uml+Y
7nzkG4qzT7alFcONaFW7yv7SyUdBe/OUyimfRCt1uUu37MDpqxcqzggpnPVzj7Ov
FAwvQEUobcuu9Tmx8FlP/e7AMMcfYZDz0dHuCG2kxqZ0hx7dJNe6KPig92O8/8cB
mJbbrgvLNuQqWI/Z2w9CG+lnrwbK0419prK97SK2WScZEsKJSZjmZuNJUqrM35cH
Pju4p9LOuhBM4r8wsL2UfrrAIh+4OfzVEObZZsPhP2QjS+2FGS5anvejAq3vvZAW
lfRQy01mzVsR0U/NjYMJMRbop3tEeh4wyeGPyOgEQE06bcbLTh1UJ1hqFLKjWAs/
X1GgpdFKc+tVV7UX1rjLRLNI62g/LKFo3vI+CoG4+F0iCPY1TzQZ2AllXKXmVFXZ
aZhpOWAWh1hRoVEcwQza
=a9gF
-----END PGP SIGNATURE-----

--fze0sZZmuBV4A+b2--

--===============3021079655104001200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3021079655104001200==--
