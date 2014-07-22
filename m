From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: add missing src/dst_addr_width
	for DMAEngine
Date: Tue, 22 Jul 2014 23:17:13 +0100
Message-ID: <20140722221713.GV17528@sirena.org.uk>
References: <87sim0ece5.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1594915872280734771=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C71DB265176
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 00:17:24 +0200 (CEST)
In-Reply-To: <87sim0ece5.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org


--===============1594915872280734771==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z5jwahX8Ql4zxomt"
Content-Disposition: inline


--z5jwahX8Ql4zxomt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2014 at 11:18:44PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Renesas new DMAEngine driver requests src/dst_addr_width

Applied, thanks.

--z5jwahX8Ql4zxomt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzuLmAAoJELSic+t+oim9l1gP/12tsrtmKW/XiRJxGanTUQWl
XlXExl23JwrM/whMfkYB2LPphYvGvoiHcd4OL3ESfv0RKziUrpuR9jWTIoI4yBTM
eTs/BxL1BMqzKQRp4bBkF8gecNwoTOT4tSL2cuozbQap6jRv6B/3nALBrRWyeGbC
OsCQELfK7IumZUYQbJ1XYm1tR35yP0ajXpptuhVvoQqfGjw3Z+nCnZHdf91PjxEk
mBJ+NHfw8wEyBYr0CuLFDfzdBd1PR3OMHS3J+etqrBYSAUlSkzd5oJ16cCzWUIE+
W65yMzr70TjMS9+U0Jug8YAss6wbdfgreB4dY5Mh/xpVpagzLReWuvDl0XaelGWE
hlxWFf0s8Ijh+SZ4D9XaWQ0l82z14nwISgWQ8bdh+bp9gaDNMg+38TqL8qUBmZij
nV5TrUlPZHLzt4qzKrR4SZrzCJy13EmlR2bC93mVHBtjId+6tK73TFtUKnzrSFo4
Ko/D3b6k06M+U5s1krIA1EvltLccOEKzfMO8DdWOH3SfT+ojchH41mdQU2qpMI8I
KqSDiUVnc91MXtdJT3Sv7wpElZPvYqYCJjFc1JmTRTL52jlnw/kchZDLlvKOZnXe
8HkdQge6gereSuMdsYvxz+Gge57PQvfwTGUr0X/wwJmtoAsvyQ6fI0CJTTHjuc/x
Wn6LUSynJQxzs6xF5/Jt
=Y2Wq
-----END PGP SIGNATURE-----

--z5jwahX8Ql4zxomt--

--===============1594915872280734771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1594915872280734771==--
