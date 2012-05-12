From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcpdm: Add device tree bindings
Date: Sat, 12 May 2012 11:15:34 +0100
Message-ID: <20120512101534.GD1781@opensource.wolfsonmicro.com>
References: <1336478312-27595-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1806460639056275895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C55CA24414
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 12:15:36 +0200 (CEST)
In-Reply-To: <1336478312-27595-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1806460639056275895==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 02:58:32PM +0300, Peter Ujfalusi wrote:
> Device tree support for OMAP4+ McPDM cpu dai driver.

I'm still not at all happy about the use of hwmod with no regs or
anything but

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrjhAAAoJEBus8iNuMP3d5E8P/R8KDf54VBE57bIqyq2x5qPa
qZzk2zyNYAe5IFD+6hXzIt569jLhR1EjTVBQGiRa8Fvqe7HWejgUNPvCZvypUvBW
2Ya611vJoA0mWBNa5SWuPgL34aOwjt95kEQ+CRL/mDARMzDHyjSvsIx5+aPb6fIG
dhuVkMs2DGWnX5qxc1Wiymh1fn/AJUCXdNHwHyNNwtGsqLTA43bDizVZny2RvQ0w
srIRX4jXdBh7zuU/ykKE/KaaLOEm9AkNrpO0y1hmxhWIfewQparhsxN7w3PMAJSk
p/EaDx2LjDLRA9MoAD99W7mYqjXVrwiv9ozNo9a+WmH5zjEwemD/WciqbeNHTN5U
PqibFUGKNrV8jV3eBfWgXnW/4s9LOYghfcRT8HXflUY4bMIJ8UmuKRmWLaLYEy5+
j2n2zKrp3esJ6eyBBd8mNin7rwJR/e9QZ0zeNY+VKjqLFCcy+9Zd/YifxjzpCBo8
iFd9edCKQwC/4BDIpD65nsJQIWZsg9LP9Hfkgmi+xCQBA+lkV2R1lCtWbn7gITH2
1tvEkj7oLZwJUrOhBvrEiixgVT1TGZE2JrS9yS1Nk5bNvxwqgIa5fpf+xv9vRqj+
QULXHJkbE/N8SjfzvNz7OIe2w0YPSC/BdP6F+6uKLNCMUnP/n2GjhhVV1FsCiNzj
OZ5NtTvCqjSVMcyLD3NW
=qJCN
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

--===============1806460639056275895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1806460639056275895==--
