From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: blackfin: Use dai_fmt
Date: Wed, 1 Feb 2012 18:30:23 +0000
Message-ID: <20120201183022.GH17170@opensource.wolfsonmicro.com>
References: <1328120661-28586-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0883259283355244644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E0852457E
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 19:30:26 +0100 (CET)
In-Reply-To: <1328120661-28586-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0883259283355244644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2012 at 07:24:21PM +0100, Lars-Peter Clausen wrote:
> Use the dai_link's dai_fmt attribute to setup the DAI format instead of doing
> this manually.

Applied, thanks.

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKYSGAAoJEBus8iNuMP3dsyoP/R+QWHn/MWwvGvgnToJidysn
xlNi4oi0twICILotuC9wm05dejpNF2RCOLMYIaVcm2jDIGbKVLtKF0ja1QSb8wg7
p23PVtOxfB7oCE355pB1xyASnPuri8Me3suaHKOKQEcbgl5II4+f+28NK4qQtOL4
6uhn8Yzm3JMHP11Quia7a0JsFZZh8m3F7Zr8sWGst0+EnYrJN8PcmaKFvjkKrGQg
cIq8O2oRIv5HYn0w2PjPX5rqfdGCEC8mBd0jTeJacF0yWAqT+XIZgUsxpuDRk7OF
gAbwHptdwBh9b4DOFiiUjzKTCr7j9YQtpFTICaw7x5kRkpauuoG92fCMZ6+65Vsh
D+nYq5fXDXXZuQnauqRo/+USlsbytA54Ya+s4V/YzGvoqA6J6k1P0MgwN3KPbYUn
Cs9R6NRa+O/lZIaM6fyoRjjGtsH/NPLRz4ICid69TADgpEPOM0kweEfDxPAp19fK
7UafrVSX3x1WXXDJCWNpqwAxrgDk5lzjdT/7JUpAs1+qChlMelJdO5XvJxcuD+HW
KLobQuD9O2umTQRKTJIXvQjPikt9tOrD5CUlMPmY9P0ZX8Mlvi3kbmOjfC721w91
Dj+BokQJ0nH26T1zh8AwlQk4tH1MtAFjUrM+8FKaHjGZMg9nedMz+/iLpmkQ3gmD
yiKChZ4XEuSuS1buuRqS
=HW6w
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--

--===============0883259283355244644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0883259283355244644==--
