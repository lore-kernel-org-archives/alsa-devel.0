From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sgtl5000.txt: Include supplies as required
	properties
Date: Thu, 18 Apr 2013 12:16:42 +0100
Message-ID: <20130418111642.GE13687@opensource.wolfsonmicro.com>
References: <1366243839-16908-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4098908087535689719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22CCE265E5C
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 13:16:45 +0200 (CEST)
In-Reply-To: <1366243839-16908-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, rob.herring@calxeda.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4098908087535689719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBZpvCNcoXwafAjP"
Content-Disposition: inline


--zBZpvCNcoXwafAjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2013 at 09:10:39PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> sgtl5000 driver cannot probe succesfully if VDDA and VDDIO regulators are=
 not
> provided.

Applied, thanks.

--zBZpvCNcoXwafAjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRb9YOAAoJELSic+t+oim9bgoQAIe/asqPqDEDYWMVjLUex8rO
7Z/87y5dkAH6LpTUVh9oiH508nsLl3Uv4wFFnVB9qZAw9rbyZ8APbrlUNxuGzR+x
mh0RvbzB8lwH/U2qCHAx/dmc+jXB58X4DrZLESDWOlL5ueYOwai0IUjDNUvjN2GZ
uNzQgcZhbrpP1GV/LjbrBCK19VFQGPR5nZjdV1L28Urv2zrB+JVrB6LkvjOjlW0R
pFlLY8/qC8EfLH6bSpjEwfipo+DtG9dv1Mp7+WDyPOuYFtGJlRc9qCwd51n+Y9gL
l+HBiyhGoPLFk10Os8fPQiz/JePgc1cQanxHc/rw2RDYX0WPQe1FPuaQqZWHtK16
ydQOu9jdA8wl5+FZt0JCzkDqdvBPci4FXYXGLaFky8efSdEvnH5J42YwMwBSoiiO
CjUi8LQ/v6Ei2aBt+YkVG4f8W0RD4pRbvfsztpvvEr08psAvmen4Ic/FaiuraPjn
6ayL92qV7RmyAc+LxNa3Esx93RQwgE9+PXXcm65YAfuxKNZG+qjZNyOraEEv8h1z
H1FKVLmOJ2WlXAcmmGRhqNpaPG3mQfAjDtARVaPDKLxFNRwGjzWWHrDiXr0r4rwl
qPjcZEliExDwIvVc2bcUqL3Yo7SflT3LUkUvsnjJB2qgkFRYGv3rF+pt6ry6ib+Z
A9A/H3TSz/VytJ/USFk8
=6k+k
-----END PGP SIGNATURE-----

--zBZpvCNcoXwafAjP--

--===============4098908087535689719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4098908087535689719==--
