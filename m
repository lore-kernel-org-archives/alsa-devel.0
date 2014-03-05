From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: tidyup cpu/codec
 dai_fmt settings for non-DT
Date: Wed, 5 Mar 2014 14:11:06 +0800
Message-ID: <20140305061106.GR13126@sirena.org.uk>
References: <874n3fyk9k.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6112182702122407565=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 600C326515C
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 07:29:01 +0100 (CET)
In-Reply-To: <874n3fyk9k.wl%kuninori.morimoto.gx@gmail.com>
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


--===============6112182702122407565==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3DE4SGaK/gJt4Z8"
Content-Disposition: inline


--h3DE4SGaK/gJt4Z8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2014 at 08:32:43PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> 30d0341e7da0c012f64fb290dd1153360fb49a8d
> (ASoC: simple-card: simplify the daifmt code)
> simplify cpu/codec dai_fmt which consists from

Applied, thanks.

--h3DE4SGaK/gJt4Z8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFr/3AAoJELSic+t+oim9W3gP/AijXeqT5J+QjktZFI10TTkh
0Gb0CcBFs5NJ3mvGNOIUXbUDeKIYQExMzSNtnEGKEIO78zhZcsRd6pmukPRwHQT9
R89dEXJH3cDeAsASEccM0vUQ8iEdSp8CdUy+MG9esknROrJuZ74Vdh1ZnUkLISvw
TMsGlBqZnuE6KODsl5lBahtC+Q+TOsdBR8V03wzSMD5w1RH863jUOx8ise/hm5e9
/GLBEDnVTkd5dsMVWcsfxrWItep0CkEmTCME+WEeicrfFLouePHePFpBpg2ahdpu
61sMQm+JdQQfw/PMvb3MuPzn9npBofFJuJHOXHE3vT4EIFhSihV3Bwc1CLgApCnF
9T5+CJHknGnURxRa1sQqeRGvXNQpoJtAflkCR9qW2vc6cUEYDkifXQeLyqQP1K9l
Gj9wNmhvt1TouPtUrkS3E9I7/HVB11P4KwqOCIW7VR1RlhgwFw56K/ikGBlV4oPA
6XlaXUnn8A0shLBCD1J+axv+/lpTIa04f2KecT5d7JpqFDNGJ7a5HYwcBD/ODB0H
lDNQoV5Uacty2EWEXQnYXiaFN0tTvT7a2/IhXLqVde+Hhlo1+k6aSLB7Tzel8EBv
BVFjMtw0VYElNGOIdFWPmbzykBr0xAx3lH2xF6taUeq6dH26ZCCcFAFKECSFMMpN
oH8+8EKj7naeqzT/esMy
=xGPO
-----END PGP SIGNATURE-----

--h3DE4SGaK/gJt4Z8--

--===============6112182702122407565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6112182702122407565==--
