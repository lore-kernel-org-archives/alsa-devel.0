From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: rsnd: tidyup debug information
	when read/write
Date: Wed, 22 Oct 2014 23:46:48 +0100
Message-ID: <20141022224648.GF2344@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <874muw7vp4.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7113538943690192355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C63B3265308
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 00:47:01 +0200 (CEST)
In-Reply-To: <874muw7vp4.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7113538943690192355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Iv4H2WyLgK50POYH"
Content-Disposition: inline


--Iv4H2WyLgK50POYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2014 at 06:13:46PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> b8c637864a6904a9ba8e0df556d5bdf9f26b2c54
> (ASoC: rsnd: use regmap_mmio instead of original regmap bus)
> added regmap_mmio support on Renesas R-Car sound driver.

Applied, thanks.

--Iv4H2WyLgK50POYH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUSDPTAAoJECTWi3JdVIfQXVAH/jW+g8ft6/ibbiA3HGzZSVwU
Wt9hfsxB6ud6jMsCDOVvIVDrLBBFwkRKR792NA141zQsc1eY18QDZ7wfhPP0RMpr
voSZAqDWMxpZ5p8sku+ldSHKvLthWWRl+yFDwGuXgzddKVDWwrTlH6i6f9cUZ3Ek
B0514tjaFhMATRMMk7j5GTRlmXH4i4gZTCpSJz44coHnHxvHpmVzxZJpSPxHLn20
Id6FmGw4FJUQ52go/tyYlrD7U+RUYS8iLJ2UYm+d+QZLwED+t6R5oS1Ffe/U9iDh
74/ezWIOkkdqvxRuZxBJk8DOAs/VT4C6LlfMnSmDlgPcOjrA5CVb/veCjidGLXY=
=QyY8
-----END PGP SIGNATURE-----

--Iv4H2WyLgK50POYH--

--===============7113538943690192355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7113538943690192355==--
