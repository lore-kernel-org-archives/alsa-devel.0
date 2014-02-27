From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Asoc: codecs: Remove tlv320aic32x4 from
 compatibles of tlv320aic3x
Date: Thu, 27 Feb 2014 13:14:09 +0900
Message-ID: <20140227041409.GD9383@sirena.org.uk>
References: <1393431273-12170-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9172521182163970672=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D4D261AF7
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 05:14:24 +0100 (CET)
In-Reply-To: <1393431273-12170-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============9172521182163970672==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 05:14:33PM +0100, Markus Pargmann wrote:
> This reverts tlv320aic32x4 as compatible for tlv320aic3x as it has its
> own bindings now.

Applied, thanks.

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDruNAAoJELSic+t+oim9lUcP/3Q/TnVVHRMx46pDF4MxgYeW
R/OGbSl56CPcBBhbvgMyPsxYN5aVOrisVzCpssgN6qQLtqVS/sRZu+/GVIYRfOSZ
prEr+A6D8sm/JYISA/lfOF0vrZuhc8aqefHAH5C4qoehOp8aui4oI5ZUQfLs74bw
FwjjhWMu2ka6KCXWJDR94qULVzd7eRP52bB6hqAWkmLNkIr+voh5rAcGLbMcUb9z
tlMHvD9PHkevZ+F5xMYq4NQcsxOv24g0arlHoL6OWRiag+DihPcMxL6uLqjw7//p
Z/469kQLzjgJOTBEMAH67xyVzVufFmfvdBWO/dOPlk0Aj6AA4NvkLjhTUVJlgwAd
uhYGfynqxBvApVx07VaV1Yh8g3D8kIpa3ZV55F/3ZKnExfdwG4E39lq2nX9ZZIZ7
7IOBRFooGtgKH7w80LvpYV4w5vJTNFGGle56Y278vt6FlC1LLjYv92T00iq+s2Bx
tKkZ/bb3pYdnIS+Q0QHBrMaOt6QeBPPT/gt4w6/QljgBUW5U22g/2+J1BgcAYdkn
8zLUuW04cJ7/5/ZMuSV434Tm3QuVnY7pbmSbwjQJUUsLivJtOna8UdeHhrQgMjfg
eS84wa3SmBSEh5er7Ju8yIknomSs0/CASuGJ+rmOie6rO8lpYB/BbeBmVzBItE3X
++Uz8H3dEc3SAow7xLsX
=r5Sn
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--

--===============9172521182163970672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9172521182163970672==--
