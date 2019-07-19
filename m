From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt1308: Convert headers to SPDX
Date: Fri, 19 Jul 2019 17:46:23 +0100
Message-ID: <20190719164623.GA14800@sirena.org.uk>
References: <20190719063302.18858-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1864013101081493516=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAEADF800B2
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 18:46:26 +0200 (CEST)
In-Reply-To: <20190719063302.18858-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: shumingf@realtek.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, derek.fang@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1864013101081493516==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2019 at 02:33:02PM +0800, shumingf@realtek.com wrote:

> @@ -1,12 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * rt1308.c  --  RT1308 ALSA SoC amplifier component driver
>   *

Please convert the entire comment block to a C++ one so this looks more
intentional.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0x89wACgkQJNaLcl1U
h9B+AAf9E9BZcbSfTKdxzyf7U+gjcQSaWg2uf7g1ap+OsTkiRMcxzywh5/mUuE1g
e5VpDIbswG5vepQ6zmPhnuWogz/iq60G10FDXCPdORI3zZbEVm7vpk8DwbiHzpUZ
TclouP43BaUTT09mXnYuJlsWQAgpSh6e7T83CN3sMuiLae0ZP38eeIWIpDximNaL
qgGy88/auxbXHzPRzb2+au43tgRcGRpMu1Jx1Yzvlrme/QRktbzMFjeEfWVWpgQm
Rt3VA1Kx0xlTL2MRuG8Pl3Byj38uQIc3clt4gHTKrV/wM45L6CAUbhEiN/mipBXI
zUHo3L9ZRhpiXkfSaQi7tCjojxXSqg==
=HupK
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============1864013101081493516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1864013101081493516==--
