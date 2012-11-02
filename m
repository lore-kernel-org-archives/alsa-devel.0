From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/2] ASoC: mxs-saif: Remove platform data
Date: Fri, 2 Nov 2012 15:03:13 +0000
Message-ID: <20121102150312.GC4413@opensource.wolfsonmicro.com>
References: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
 <1351792632-30649-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1089967643044408775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CE1D26509B
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 16:03:14 +0100 (CET)
In-Reply-To: <1351792632-30649-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1089967643044408775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ITEy4z2kE7rjCDPK"
Content-Disposition: inline


--ITEy4z2kE7rjCDPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2012 at 03:57:12PM -0200, Fabio Estevam wrote:
> All MXS users have been converted to device tree and the board files have=
 been
> removed.
>=20
> No need to keep platform data in the driver.

This doesn't apply against v3.7-rc3 (or against my fix/mxs branch) -
please check what's going on.

--ITEy4z2kE7rjCDPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk+CnAAoJELSic+t+oim9kDcP/0FMi49z/08rd5z3oNPUDLSq
SzMGGEOl94GqTfTt7iWbFiUxgrnjmvucfkJ2dTa/KdBttAZA4TmXNUIFv7DOqojz
m1k+GNAWKETnTVvIz3J5KJ2AEl1iHN/nyEulK1kLG6l0+K3cIjZkc2R/ftB1uDMn
N7dtn7U9XzPZQEGJn1GcxbiBKs1laHKMFnpy2PpiWD1A3c8PRIxvAhOOEDYbdGBv
XcqHUdIMFAkjr1BE1lnvTaBo+gIjRHb9EeCUk25XKJI7ar2uiN/x8FWQ8qEQkzDE
LL9r1Z7SODtVdZTe384cj9DF9n4whurAMnOJmAtZHc8AFxgA0TCavoNRRm2/gZbl
tUi8KX0bwkFQsRcbYWrFul5Hq4Ss6HXwb+KziGyPDtYA6Cp44HlB7/nKTp8uaX93
j1DuoOv+OarbuGGRnpbS9mkWN7Od/QR9EugcEuwsSCCwVm+ngp7he1jLRbMRXYZ+
zE1AUtqLr13VIvxG6PdLY907YvP7sQtRDfv2huqf5VfV22IdhuH4w5rREnRsrz8h
ixoHnQBQ+7l1s6gGzDZUSApqc1arC9Hq7g+uJHmPuOvwIZI2ryqPa/KJC0q+MXIT
Uyid+byVz0hTuGOakgVZahfhQS7xfUVKlUYePLvpYl4qw8xLRlC9Q5h/WebeUezO
eKgGIrdRxCJqDwx5geRv
=0dGP
-----END PGP SIGNATURE-----

--ITEy4z2kE7rjCDPK--

--===============1089967643044408775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1089967643044408775==--
