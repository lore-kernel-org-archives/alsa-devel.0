From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/11] ASoC/MFD: twl4030 codec local
 register cache removal
Date: Wed, 8 Jan 2014 12:48:39 +0000
Message-ID: <20140108124839.GZ31886@sirena.org.uk>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
 <20140108114232.GI19974@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1157120025921098619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9691C26515C
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 13:48:53 +0100 (CET)
In-Reply-To: <20140108114232.GI19974@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1157120025921098619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MuDnMMoGCLJmcLvf"
Content-Disposition: inline


--MuDnMMoGCLJmcLvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 11:42:32AM +0000, Lee Jones wrote:

> are available in the git repository at:
>=20
>   git://git.linaro.org/people/ljones/mfd.git tags/ib-asoc-3.14.2
>=20
> for you to fetch changes up to 9146070089cca0fa5c396f1a4d0b96d675004c04:

Pulled, thanks.

>  drivers/mfd/twl-core.c  | 190 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------=
----------
>  drivers/mfd/twl6040.c   |  92 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++--

Wrapping seems broken here...

--MuDnMMoGCLJmcLvf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUkkAAoJELSic+t+oim9Z/QP/ReAlQY7Wb/OrcOlgFANPGW0
APtqhkZWChBFc0WX9PGI6Yh9iAWAgRAmCQ9vYcB6+FhTN+cxFBsxEOpy3oR7NT9w
bxWcSmV6t70re9dLEL3Mc2QkD/Q+7UFcVnizxXahXqG3KimjSd/zYZST/a8iW0LO
8GFz7UswkoB0B4wJ2uyh+eUZHeNIzJv7zFOFzy41Ul0vK3VWCwZg8DUvxam90mL1
eQKQ5GNtTA4GDzqbptNIo2nEn3N5UL7qo5WHYDc+KTO6RCmEx+Fv2V21OHTgeJlA
kUNVdCD00p1dphEmRDeBAKsVu3cyTMGisk6+fC09AaQRhrZNJHY4r3ESpIjhuPNA
nOwMZOmnjNHAbOcHAnAGinGujbiWC0TfATwRdjArvTGLovwLrhzgr1HtK8T7q5RU
GaEAqeTgMXm70gJ9SWq3cqVPRmtp66yiWza7ImFeUZKYd+LGVKWfc8ajWUE03g5a
vd0gdrvNVb7uY/Ci2bXELHp5h7heUsCtGOM62L6kev4/N9CZHJ7aNjzO2wZEebNa
OxgNpsrlhd/zTeZkb+SmwieTqS9fjbt9w+u9FVCjTlgWhfW4Oxx/eLUxSi0jLDll
cpejHJgR0RQKK5oj/OitjLiPn/uVltI5nRmS3zZMT9oAMBty061Rng9vA6uE6Hgu
oD2V1Yq4nTzzP6dluw0l
=peWa
-----END PGP SIGNATURE-----

--MuDnMMoGCLJmcLvf--

--===============1157120025921098619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1157120025921098619==--
