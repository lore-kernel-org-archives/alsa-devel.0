From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 4/5] ASoC: compress: Prevent multicodec
 for compressed stream
Date: Wed, 16 Jul 2014 23:07:00 +0100
Message-ID: <20140716220700.GJ17528@sirena.org.uk>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
 <1404854378-25828-5-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8653554063867150267=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0A4E26535D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 00:07:09 +0200 (CEST)
In-Reply-To: <1404854378-25828-5-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8653554063867150267==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gqO6s7S91gFL8ZIQ"
Content-Disposition: inline


--gqO6s7S91gFL8ZIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 11:19:37PM +0200, Benoit Cousson wrote:
> Multiple codecs does not make sense in the case of compressed
> stream.

Applied, thanks.

--gqO6s7S91gFL8ZIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxveBAAoJELSic+t+oim9B8kP/1Dh0L+Sjp4u2lPCqE5b05Ut
jxYZCRXFLXvfvroJYBquowkd8HQfb0shjvMedWpnCAR4UxH9udmrQIpYjpCU+4/a
+ct81WJQpZSTZlrHIZhrbzMvbNaLLKg32vsh9YJhTekh1v8Atk5lOW02vxi/m2OT
/6Qqw+HKlYiRmnGLX1chIQb9tKr4DhNO/zmET1arE2+zqXlf/G7ow9HUFIGBFFnH
m7kDB4yHWyZUB1V9HKiyQ2m/ByOOWTutbcps3DdL/HpBJGCySPzc1h5rUpdnOzVM
0MnpqJh/9YKh8TzQ+SnqDwZNR5f4tEM2QANHzTWogDyPoM+/Ge9Pti3Zn4xsKg1a
oauBQzI4vVjiepUdrUxm6c7cgAxoD3F9XFEXWFnShOj6vB6nkhZsW0e+6RKR0I9S
M3X53cyXTNfz2/yzz+3IGA112pUxj5ybndd2w577pX2EMKlWBBaP2hCRVH+s19KI
S3HlaUr78Tbd1WSCOEs3gP9P+Foy7sRoSJKsRCGSE/zk/bQRKFqWBto/XsIr9X+Y
xVsipy0nKdlYqOVFeiZyqcsqf1KkGe082HnhrMDj8v+hG4CiRg+/k1RvslXmHnBX
yswp2uNOMkwqPnD/u3uvYbMUSByCvaV23btRA78TZka+nA9qSKDlj3Reg9SVBo/a
JGv1NhtTh9dFbY/tz2NM
=7v2t
-----END PGP SIGNATURE-----

--gqO6s7S91gFL8ZIQ--

--===============8653554063867150267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8653554063867150267==--
