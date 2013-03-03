From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: max98090: Convert to
	devm_regmap_init_i2c
Date: Sun, 3 Mar 2013 22:48:40 +0800
Message-ID: <20130303144837.GB20331@opensource.wolfsonmicro.com>
References: <1362300546.9569.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4221917119474025814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ACE4261731
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 15:48:56 +0100 (CET)
In-Reply-To: <1362300546.9569.6.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Ralph Birt <ralph.birt@maximintegrated.com>, Jerry Wong <jerry.wong@maximintegrated.com>, Matthew Mowdy <matthew.mowdy@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============4221917119474025814==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 03, 2013 at 04:49:06PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks like this needs a refresh against current topic/max98090?

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRM2KsAAoJELSic+t+oim9MHwP/1YEFmFaqaWN4/NZbp1OsLP/
Cf1+hEoFPBkVgR1s2vCHtNztS6YI8JP14rFeHxtn0QsknObhkK5oSj/ulU0XQXMc
hOy9BQ/9otmvyBUWz3HRe9KyrhtpfGL7cTrTvGUEQedSNSt9hJQBIXqrSRjLZcRW
tOWk0YbsYVo7gxft7xTm/eVVtYOGD/OdUw+rjZBrEFc2TVi+egBJjKIMS1tDzzGK
UVjIzmk1hYrjlT4sEJVJEmEE921PNKGdcpMUhm7t8Acb0KBCmMpj9oeis5D5o6Ik
YiO9re8C1mFt4+vSNwuRyDMumLqTe/guwKJWMhzFbi8kb2uNIQZe5BtNY/IMTz1B
y00FJTxesgMro12J9rLpLGaal0Pk9nLh7c4Q+uYsNZWx1+OAEbOleuWSVdlSw7oz
N3LbaOerW9Vae/1uv7Qz6S7A8Zx1gt075IfjKpkACR1C99uCvh6dZfo2X/s93png
gEW1D/Jba2ozJsXpY1xz12C2y1yv5cMLh82IHCn7vqJXBqUfYL11frJf8qPqS9S3
uh5tqGRW+flrtUhQJ7ShFpOJi8AnHWFyEVspaYElGrOdZ6T4Aa07mDH/rRSdEde7
liU85QTH1IBgdVaO6rnU/dV4ivs3i2twKbzoNfbPFPmA02S2DZoh/qNIplNSZmBu
jjU//6aiuKPCE4Pgjlsn
=sqnV
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

--===============4221917119474025814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4221917119474025814==--
