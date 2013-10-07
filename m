From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: twl6040: Use virtual DAPM mixer
	controls
Date: Mon, 7 Oct 2013 11:49:54 +0100
Message-ID: <20131007104954.GG21581@sirena.org.uk>
References: <1381059831-16074-1-git-send-email-lars@metafoo.de>
 <1381059831-16074-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0203374569909903465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 523DB265063
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 12:50:01 +0200 (CEST)
In-Reply-To: <1381059831-16074-3-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0203374569909903465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 06, 2013 at 01:43:51PM +0200, Lars-Peter Clausen wrote:
> By using the new virtual DAPM mixer controls it is possible to remove the
> twl6040 specific implementation of virtual controls.

Applied, thanks.

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUpHPAAoJELSic+t+oim9y1QP/jJoGYiky59EllyNjDteAvxn
tw9Y58sngB3mdrwqbq0UufBkd4Vbw8c+yxBYkydeBCwuhZ2ZfARwi7pXNmFrhcga
ec+GzV38a4/ECQgfus8FlgEQ/DySM+zuwTyOU1gbt11diTmaRLguBD6SxjHm2QtN
uTKpRUmyTQB5HhhHNf+jGzBw3//IakM8wv+yNPsMMJ4SYtiEjMbzxpR/TkIPyDed
C2bRuk8wESzMsOdyyoxfF+MowidkTlLPYL3WuOlFNgnoOTqANw1VgGLy3mqsJJ/u
88ZxNa4rla570ELxI8UNUUwEO2GFKPqME9jcnstdB0rjKA0KmF97XBT3YmxiPn4v
RQ5+dzJdo8PVzV95a+S/o0QKeJ3X24VAvQu7ovGh2IUHqi/ZevVzbEmW8MFDuInB
/eR9I7Rmx0Hte60TqXwD6/FU0OhN1RBrXJpkFIyeoAeCZMVi4FdFH/GI2AL+Dt+r
LSQl871lmCfgoFp4mxgEowqQ5ld4vwdWckL9ixdfkJKIQRrG+rxNR9FMUxIfSrmU
FteG7FE101T7wKJov0aMi7QOWvxfyKm0dJh475VIqUMZ0oQnW2flaiAc8ezbXAp3
ajWCqNvBrhpuu8FuRSi5nJ9klhmxvKhgei1SGi5FR0dSu2+9admYeyh3oLf2iS0j
H1rXwQ9WQp9OA3cDj7Dg
=0Fg/
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--

--===============0203374569909903465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0203374569909903465==--
