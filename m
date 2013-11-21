From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/11] codecs: Use IS_ENABLED() macro
Date: Thu, 21 Nov 2013 13:35:05 +0000
Message-ID: <20131121133505.GR2674@sirena.org.uk>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8349554114625074451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 79DB72602F3
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 14:35:07 +0100 (CET)
In-Reply-To: <1384969072-25906-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8349554114625074451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qdUnDMrzfAkbfH6m"
Content-Disposition: inline


--qdUnDMrzfAkbfH6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 03:37:40PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied all, thanks, but please do remember to use appropriate subject
lines for commits - you were missing ASoC here.

--qdUnDMrzfAkbfH6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjgwFAAoJELSic+t+oim9VosP/A4v2AM99Z93rO7tIk69t6Rl
Y7pX0v3aCy6+xAH9nX2fdO3eoRZFGonr3dlfgFxvc3bB3LvBXCXr6OcDrbSYLM6Y
Ydi7otGzS+ydAMO+E156qAsUSW/elG4+otYUUTSSjbkgL7oIVNdu5BGZu395RgA0
ym8z62223rLpQvKLKKUw+dmeAt+XysCGqOVSftJUHoBv+LDHLG5TGNHj7xlC4gSn
Fvu4y9ivK8ivVX7Alw8NZwwZrYVsXLS/+o0qp4dnayH/ZeeBn66M756wPYnq+nS6
44J4SKl630YQehAkhCYvCB3DZ3n4U/jNWurlEnFVK3xrlrhoKnZIhOcHsFDF+KOX
InQNg6qgNZZkSDKh8M13IUmiCcDCch78O8Wb0FQpUE5qQeEVIV4Kt8s9azVy454d
J2W51d9RmwBLjmKltKbNnhxafn4Yreom8FlAbTe7h+k5HKIm8ukcDnxiZ7f+uiWv
1+bxWJ81tPuF6EsYpnIvVkcO64aBtvqVHWCu0+QFecVPnquwep4NLggsHrnW4nX/
DL3tMe8Bq4MzhmD0rxblI0mCh5/oTlKf1T2d3IxkFfvy6Ao7o96BHcy2H+q7PA1H
T/SwciY/61lgFo/U04/cEsqKNVQrfd4y0weMxGnSauVlLSoo1Ue7F/qgfM4G9PUZ
d8hA/fZz4FG2I3WbRVZO
=wcHD
-----END PGP SIGNATURE-----

--qdUnDMrzfAkbfH6m--

--===============8349554114625074451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8349554114625074451==--
