From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 054/102] ASoC: wm8940: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:37:55 +0900
Message-ID: <20140223023755.GT25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-27-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8643680640308550980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC2E626500A
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:38:10 +0100 (CET)
In-Reply-To: <1392723517-12772-27-git-send-email-tiwai@suse.de>
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


--===============8643680640308550980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5fM1MC9alg+yIaL4"
Content-Disposition: inline


--5fM1MC9alg+yIaL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:10PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--5fM1MC9alg+yIaL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV7/AAoJELSic+t+oim9ifIP/2ewqA2R/jCoKhd8dehqutUl
GL3jns1fdcf1noPzuYQ2FoFGYoG/M/cpcGStPlsTX8wIGTEPzmbsgafhJ19tYXvk
V7aVJeBiN1NSs5D3woGA8QF5xEOCUtCJy35JYxlO6PLtsPwZgkw2L/xn/GFPT+ob
f7TuxhjfHdU9TjQQsFRJNWCQszDL5EI/VkbDRdZxRB1sYSNq+35xMqcbKUlSiyux
WuVn6IiAMCf/FuoyyNXl9fajCObKvQHZ+VPiZFKHfz+p+jzD+KOr/x8Xv113KlFT
YK4fW5c9OfuutoyCye02vlbUJk9sPh/WVcQWDQsJyb/NuBEMGhtC8fui3ssFKe6Z
0JwopWurd1Uq4Dx4+w7ZCAMvABHjqJCkRg7hT6+B5h3zzCvj+ohkL6wmclJyfFir
f9g0Ad4LDySL+LkOaUtu4zTM4fbtUYHAfuhA5xyQl1K8jOfKEeAFfjvX0NenRS08
wj6DfQ6MLBoI0sbwbUy5wKPqzcC0izUf+GtJKXUCfCYYF11iEnuTlwKa+qavL28o
gj3+RRiPUpUxnRt+KQ5gEbVB5oVvtAosNJVE3KYFgSX3NZ6LwfttbsDjDmNo57Ig
rU/pklzGPgkoZyQF+MRp44rPPLRE2DysDa+L2Bv0qm20OO3bc6TDlllDg97vPhZ1
WqgGOIlcXxc9GDD/vZYu
=dWAQ
-----END PGP SIGNATURE-----

--5fM1MC9alg+yIaL4--

--===============8643680640308550980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8643680640308550980==--
