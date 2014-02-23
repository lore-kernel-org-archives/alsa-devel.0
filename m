From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 053/102] ASoC: wm8904: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:37:19 +0900
Message-ID: <20140223023719.GS25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-26-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8741434906154124634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF2762650AF
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:40:40 +0100 (CET)
In-Reply-To: <1392723517-12772-26-git-send-email-tiwai@suse.de>
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


--===============8741434906154124634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PpHgzJIASOO9qXt6"
Content-Disposition: inline


--PpHgzJIASOO9qXt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:09PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--PpHgzJIASOO9qXt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV7cAAoJELSic+t+oim9Jf0P+QGBVtwWq23J8h6v3GSq9Cfc
GBS8+GaAxxe4kr1IVBfQi6wz1VynNJlcaJ2ixF3ffvSqegn5qQ1ZtY8KBuhtNG4o
Lr2R5YVZi2arK/sL+eUtbzO1t/CDk2j5o7ICH3ySSszkId3GpGmJc75qfnJTSTCI
Z+xaVfC3APSzXEBqxRHSYutS9Desei17y3xSy+9HII+IzZqrEePPumSS1KGRoMq9
GTCvR+NrPAcUYiXHilE+UBYKJGPcYuZLZfmszGJBvf/4wf4Q8n9Ew3eO3FUtzsIt
9R8pm198L0mFIMj2o2R+gqBsqGKtxOMvOWprwA3xJ5d4lZrozVwpsOJPOgFcTsXB
uKKzwbXW3+ke4bOQkuO1+UuayRHldYHW0hytqPaeEWqMlzTebxRFbTGfeKPT7m2D
/ezK/4xm9GZGLsa1HR2QWgCyhSA6Pycj5DEAS8xcHvoTdJRUN++welu8oi6VaJQr
abcZdtt8x6fk20rtMMLZR9DTH6MlAk664xm+DIbvADq6bYLt2gmJEjKDTqzmasFR
Jtw3u9VR/GnNgu+R4tgnw58MVDQu4htIGKqhI5AcZQW5Nh3GC/Sx3Hx+iVv2pv/E
/BQEG6zmkVON15cuHHG8FlWMLV+tBnA0mnHSu8Xd8ufQOG77l5LDgu3XWfoREHhA
qaCzSEhfrMsCy1/btMM7
=sF5u
-----END PGP SIGNATURE-----

--PpHgzJIASOO9qXt6--

--===============8741434906154124634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8741434906154124634==--
