From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 022/102] ASoC: wm8400: Fix the wrong number
	of enum items
Date: Thu, 20 Feb 2014 10:21:52 +0900
Message-ID: <20140220012152.GH2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-7-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5185683429465969490=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B73B265375
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:21:57 +0100 (CET)
In-Reply-To: <1392723422-12689-7-git-send-email-tiwai@suse.de>
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


--===============5185683429465969490==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2HJCx9CofP1lSo0n"
Content-Disposition: inline


--2HJCx9CofP1lSo0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:57PM +0100, Takashi Iwai wrote:
> wm8400 codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

--2HJCx9CofP1lSo0n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVitAAoJELSic+t+oim9a3MP/jKouzaUl1Q9pNBXBjzj2VkQ
H3x3BcofBFeZZMlF0O5GCIXThpNKUUwScTPUMQnCfsPn7YdU8VAKEBssJNc8TQIU
X4/+I/CQFFlgkCybYc60f73ioA+pOtUlFhRhoy2LO4stuY1J/Jc9XHEBPbqk6Jyv
UaBRNSl3zhIQ5tA83l1xL507AyMxh2r6azh4FcDWlUwhH3aDl0kML0PKti39MWLI
dB3ZXvDV/h4L1MHEJLg4uluCBGOFqzd1jLt/2ETjhmpm3DfRJfKobBrinZ9zKjIg
N+lou4roD+fIo6bMCy2bdxhTxDpqYyAE+rGiHFiwFlKN6rofptnGaQtZdBQA4SGM
E79npFhtIWYJPPxH7/+/zVvYxMJNZF8EMGPJb5YCqcC+djJv6iMGARF+75qOwTz0
+dCdypYpOmpx1xnMW0ZlD7lrZItzcoQ/KD6Ktfu5NXa6X0zGQSDYhT9zryveib8E
1KnsihePzAC9LdRybEmHfOs2FQ3tU4IECp53dUHU5hWZiroj5/RuuqQQtYYOa3Wp
NfM+xKoEm3i0OANHR7mhLm/Yf6ZIrfuk6wVOKVbeDGHLVI0V1YC04ubbLCivZPpZ
hs7VITjHbA6ZYsR+h8q2tG1c6r0X05cjN/wevJGb9jjiQzS6V9riszGvxME2QZ9G
Hf4+OKgfQIhx3ATkGY0m
=0Ka2
-----END PGP SIGNATURE-----

--2HJCx9CofP1lSo0n--

--===============5185683429465969490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5185683429465969490==--
