From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] ASoC: fsl: imx-audmux: Let device
 core handle pinctrl
Date: Mon, 6 May 2013 20:21:29 +0100
Message-ID: <20130506192129.GC7478@sirena.org.uk>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
 <1367863561-11534-12-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8202546552913010959=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 76EA3261B0F
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 21:21:34 +0200 (CEST)
In-Reply-To: <1367863561-11534-12-git-send-email-fabio.estevam@freescale.com>
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
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, festevam@gmail.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8202546552913010959==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2013 at 03:06:00PM -0300, Fabio Estevam wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for handling pinctrl.

This doesn't apply against some other changes I've got on my topic/fsl
branch.  Can you check and resend please?

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiAK2AAoJELSic+t+oim9HhAP/2P2nmrGvTAlPAIbJ2EJJIJu
NSYg8ruHOTC4FTjBC4bvFarLtV1DfUV8X+ZOANliaRSlcGYGrq9H5MhrHwx2JVd6
f8Sz0rpZSQzv1EbiEg0ZYjQb3sMSLLkIHBqvALw66hImlBMZU+nhHrz8D1nVoCud
bSJ30px+GsQ2QJZ6/o/RhDtF7tp+L8XN92i64t88Xcjs5DC3+BFS8MYpXunPnPJx
/LNfNypOz8OvbppigV9974Ao07qf9LRqD54BAdjA4b1PHXnq0XxuwYvGMew9foQQ
c4mN6f4Y9MCZ/pYPrDU3lMaZilUuxCy0yDHs91aqo+ekabCGNqLwqIrF0v23+EII
V5ym8+ZVHOwEEyH86PN/Xtr1MhoOFjIMf5DhGbIXn5iHlVbkTfY2apjHFoaWtEnZ
5yPDsjm6Xp98iC3Tx6utTzqxLSA5fljriKQFI6IhHQ/F0e8MNhtKnzvqhAf3sK7m
p7XB+UcwWyHvYLaGQc7sTRZyoVVaFMxloNlL95zONnJJT6/4NXs81S6iaMJ/ep+X
2Smo2jHkaGnAoAKI/sm3P0uw1cEZ/soIKOHsRbiOYAArBu4n1NNK3ukJ4M9lAbGG
/y5NvKSdeDHoZW4gx0k+9+qJj3A12bZvK2Uju3cU+4zq7+j5lw9qGfEIMye+a76J
j6Iw4ZBDp8JCwiUtb1R4
=T14q
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--

--===============8202546552913010959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8202546552913010959==--
