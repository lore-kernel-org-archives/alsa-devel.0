From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: Use 'unsigned int'
	for period
Date: Wed, 20 Mar 2013 10:59:05 +0100
Message-ID: <20130320095904.GE28775@opensource.wolfsonmicro.com>
References: <1363756960-11386-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8160449867504619221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5FF22616E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 10:59:06 +0100 (CET)
In-Reply-To: <1363756960-11386-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, s.hauer@pengutronix.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8160449867504619221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2013 at 02:22:40AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Fix the following warning when building with W=3D1 option:

Applied, thanks.

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSYhiAAoJELSic+t+oim90QEP/A3MrRhUMR89eBk0sdfVT2vz
KJHP7wttEvnOZwFQHoTm+nNsYJBb1qYC83FYJLxXmEnEM1PGoJxMSH/Gzj5SQ9XY
c/gtuilwR2TIXQSeqpMkN4Pju5CFTL8VTRSP2Tt7jdMdx72Q4/0xGqgRn0q7xgcC
QbWgeo7eYG0rsjVzr63av5X5vj/ZxCTTCjA+lcOsjip8VtUY7UBeLPJQ2CSinZI0
w0PtECeiz5BbQMtzLeVzGUVJFsQQsSJI0qQqwp6bROPM93Pj4iTp98fgND3MQY+e
evteHWXyuEkBehYzLgVDlfJWAfsiPWnAkwrHBavsjIb7qlos0S0YVx97arIt6Rum
BWZb3OH4Kpbr2cULXgQIRW4FZolmCXKj/Ls/O5SjeYxOv0YN+ovHBzhPUOXbHSi3
pL7+2ZNyd9S0sJSFigtCP+W8b1rG7Vw8IJtDna+0wC/WEdjpGYh5dnDHzAhs2vlV
p7bHn2l8myv/XuMndCFid+XuTFUCeFzm9s1A08p2g02NN9rolHwyFQ1aQCoK5DIk
6XKKiwog1mg6EBy8gxs3yM9vzBMKTzigMSC2Q6VKnR4hp+o0zr3GGnq/VWaF9kNe
HEtZUBC7xGkOcjePXgFkRPNCIjPo7fcVmrW/ozNakooAIk3QAR/VUSP4EnYamj05
y2Z2DxBp5f5rA8SU5bdd
=tWFf
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

--===============8160449867504619221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8160449867504619221==--
