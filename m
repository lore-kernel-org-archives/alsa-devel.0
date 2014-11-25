From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5670: check if asrc is
	useable
Date: Tue, 25 Nov 2014 12:13:05 +0000
Message-ID: <20141125121305.GT7712@sirena.org.uk>
References: <1416209243-4879-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2450173709237869034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C2F32657DD
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 13:15:07 +0100 (CET)
In-Reply-To: <1416209243-4879-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2450173709237869034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cUlGATvL9lcudEbI"
Content-Disposition: inline


--cUlGATvL9lcudEbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 03:27:21PM +0800, Bard Liao wrote:
> To use ASRC, the sysclk should be faster than 384 times sample rate of I2S1.

Applied, thanks.

--cUlGATvL9lcudEbI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHJQAAoJECTWi3JdVIfQzzgH/2d7KU3Kw4ivHpxATrqBweqU
MAWglXUBLWf5F83srSu0Fmwc2a+87xUr/wCMWJlNEp+aEHrpvQWQCF2m99ELxhcE
rqvwvo8RV/5Zr6Ej5QO+pG9kPssn2FOOTYM3KEJlTQqOhwYqZ6PZDGyuzSA/8TYX
aKeLnKXLWl8ydL+h1x3SCcuhlxkJTlASCBq9BWMWKR5fYVIwuIEjo/cNPs1xRAce
wQiKLR1DAU1Hi1LHjdxNraNPYDUprvvqiAZHIkSXEINy9S399iJKW2dLA7okOuLz
4gEVaJNousEsraFHn8rfU8i+NS2tzJiBGGqo6BvQIzWPVjvy1d2i9uz/n1H2CXk=
=l08F
-----END PGP SIGNATURE-----

--cUlGATvL9lcudEbI--

--===============2450173709237869034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2450173709237869034==--
