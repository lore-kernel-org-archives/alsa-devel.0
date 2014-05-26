From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: alc5623: Fix Kconfig dependency
Date: Mon, 26 May 2014 16:11:17 +0100
Message-ID: <20140526151117.GR22111@sirena.org.uk>
References: <1401113317-32101-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7764781597323671235=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DEB5265056
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 17:11:41 +0200 (CEST)
In-Reply-To: <1401113317-32101-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7764781597323671235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6uWySOjkgtH+Mvsi"
Content-Disposition: inline


--6uWySOjkgtH+Mvsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 04:08:37PM +0200, Takashi Iwai wrote:
> Add "depends on I2C" to shut up the build errors from randconfig.

Applied, thanks.

--6uWySOjkgtH+Mvsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg1mRAAoJELSic+t+oim9o8QP/Rboopncuo7lW7p5tYlnXut7
MtmCcpPb647lKmI9NAZW25yhcj6qo848Ya0lIRKpb3VOLtksWEc4bIrmZJm+6re2
vbEOH22xNqf/oqkq6xUuShQmc72TDfT7uA6z1CpeppKGxZB6lU7jrjOSfZiLEJ5w
k2pdt5tEzQF9/gR/ELEvyat050W6HYTwQlPBjERdOqQ6Blfg9n13hbP0YYRITEwd
WjoXxFK6DZcwJfp6WQV5GNKgdLxK/keAdOeEK6OIGPbaDC3b0aQSp3zidSDG6X+x
NX8vIs5bFtatpu4ug0l9lGTlmPsXOp6QN9QbQnkGxuGBrdPWiZM5+bbeeF8ZqtYT
hMl/1y8m41ZAEwUVT91BSOtXWO637IK96EpK7fjP4QYjbP3/Pbojpc9ZpNjIVEp/
yD9wcHrkMJVmBFp1mNjlUmPzIU5aa8Ydy1y8cwafpba5u7kMapPhRHMOZ89m29Tc
dnk8C61XAVRDikJ7+ivjvDNycYOXO6MxA08r8EpjjL/aq5rV4b8bLfhU7Gbsr10U
jF8/NmqLsCl0DEDPEyOmzwGutPylHNJwCOV6eSjUAC9DsXlkN4fOsDNHygTWfKee
qepGKk95O8I/LMxDtaZana/1pSO5ZfOWc4lsTAqX/Ua/1l4zMKZwFA0s2N4iKzgP
KZhgIeYRcG/rpKIwhfyQ
=Ry2Y
-----END PGP SIGNATURE-----

--6uWySOjkgtH+Mvsi--

--===============7764781597323671235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7764781597323671235==--
