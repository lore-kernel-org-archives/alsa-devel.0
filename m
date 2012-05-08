From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/11] ASoC: core: Add signed multi
	register control
Date: Tue, 8 May 2012 16:41:37 +0100
Message-ID: <20120508154137.GZ15893@opensource.wolfsonmicro.com>
References: <1336485407-27186-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1792916147921475825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5DDC243D9
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:41:39 +0200 (CEST)
In-Reply-To: <1336485407-27186-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1792916147921475825==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Content-Disposition: inline


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2012 at 03:56:47PM +0200, Ola Lilja wrote:
> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>=20
> Added control type that can span multiple consecutive codec registers
> forming a single signed value in a MSB/LSB manner.

Always submit code against the development version of the tree you're
submitting to, not against some other tree.  This has already been
applied!

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqT6qAAoJEBus8iNuMP3dnNYQAIFixOVTCfhkvQOfAIZKJuAh
aPIB+W8w5XdHMBVEi6EBTW1mw5jSZEo71ugbrdua11MXUr4c8wiT720ud/ibWlu6
izM8Htp4NAQn3aYTfRkrCT+8mHTa8cBm3qYEnME3I2pSS7NzOOvgXix10Zz7Bs7v
q/QEmcIGmaqhnFHVtZj/ePWCIUAGVZ7qCc/ZUdmIGJH3ozGXTp81PXCYt9FUgAq+
mQbEEEqCz2Br89g1kn0GIsXUtwRFfDBXRomTERCV/2MR520YX2hjAByE9q7QXRx7
ISu1zSEHtJSx+4zvZaphAYuKHKDHsD3WK91mjGkMq7Mta0Kd5eSTsz4lSfL5mGbL
UobhXp3Qf3duiZdvpzzX2HhLkj0VfMLwgsdHmhDBY1SCbfwFKaWvNwtZGaBLT/1w
693sL8qMkggcJVBHK5OAcw6gkO/UodX0PIJVfX/IGVUT97IlWYruhNHkLxhSmVYx
kC0coWXED0+esPx+YSV4w1Nukj0aGH+cQKNg474lq14tVb1a9FK7ClcuEKK0Ot5i
qwIdf1+0EVxzsA4vATvK6sQmCYcOAJpOKz6vaAyafKR3vTTQLkTWVcpP/VT2k9Bz
so5GDOWmahjwNeYUXE/55vOIdP8OtfQUe4Oh+b2xuWUsgowgGQ7CtzjEDv5XTx+a
8ZDyN3otGqO5WI8j/Dhu
=cGKS
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--

--===============1792916147921475825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1792916147921475825==--
