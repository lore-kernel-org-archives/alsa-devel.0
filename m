From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 17/18] ASoC: wm8995: Use IS_ENABLED()
	macro
Date: Mon, 25 Nov 2013 17:14:38 +0000
Message-ID: <20131125171438.GM14725@sirena.org.uk>
References: <1385045312-15092-1-git-send-email-fabio.estevam@freescale.com>
 <1385045312-15092-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7751742789364053143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E1A462625E0
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 18:14:40 +0100 (CET)
In-Reply-To: <1385045312-15092-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7751742789364053143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="np3HfElajyDBpWGr"
Content-Disposition: inline


--np3HfElajyDBpWGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:48:31PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--np3HfElajyDBpWGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4V7AAoJELSic+t+oim99K0P/ji5Hs+kHEDEg1joOMJZoS5I
TqmsbaWpYI50RaMjwWdgq0C2ELayp0X37Rn0IxEg0wIVSN5t4PLfyiHwUmOSsFf9
ZUfazg7e4GJr3Csu7IklyHqU7/A7Kg24LZPigJpWTaouEIiHg7BQFeimT/d1iQgf
pJNsr1eo7xVsHpTcC2qks9Yl0+5aE8QYhNjHt7dEHaerXsxdWIrvlWJUgizLE9sS
uaxiCZk2KuQbKxhpvdJJ+ySfleu1j8a9GuFXexhlqMmv42KiFg2zm8jR4qjEeIE8
doEWii5HATJwYGpuKmEN3D0Yoe/YwU/tXplGL4k0mLpXx+VdFfERShk2h9MJCB8Y
TbcPi6pRhr90INEOGEJcxwXPyeIyKSn5mILKnU5QEN+vvnxZLE2Fd/ghABNuDv3v
rQJW+RjyXxPuD2JhYcBTzdBFTwuMonbzmoGxP2V69gfQe6z91gZt7mt7sGk1Yndy
hvYrKOOUMZOR8KxuiwPbJzXVHI7f6uhI9G9hA3BBwP4oygp49N6T/RUK2ZSUD0aD
75ShcljuITet0IR16+ZSktCx61ll9NI2sd8qtItrKvfzndqehl4kaNmfthI7ZPb+
TWj+tuyEtdMM2wlTPXn5o/zQ9X8XVOQvm07KAiBRytK+xkj/S4BM/U+IV39Pdv86
2+lGXn9nc0oo6BWqrO2h
=Kla1
-----END PGP SIGNATURE-----

--np3HfElajyDBpWGr--

--===============7751742789364053143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7751742789364053143==--
