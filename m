From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 1/2] ASoC: fsl: Add S/PDIF CPU DAI
	driver
Date: Thu, 22 Aug 2013 10:45:44 +0100
Message-ID: <20130822094544.GN26118@sirena.org.uk>
References: <cover.1377054540.git.b42378@freescale.com>
 <03182ed7464c156ec6345194d3f7ec920f753c2f.1377054540.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7043115622386094512=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 377C726545A
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 11:45:52 +0200 (CEST)
In-Reply-To: <03182ed7464c156ec6345194d3f7ec920f753c2f.1377054540.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org, festevam@gmail.com, s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============7043115622386094512==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncX6roZrNNHXnAbh"
Content-Disposition: inline


--ncX6roZrNNHXnAbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2013 at 11:13:16AM +0800, Nicolin Chen wrote:
> This patch implements a device-tree-only CPU DAI driver for Freescale
> S/PDIF controller that supports stereo playback and record feature.

Applied, thanks.

--ncX6roZrNNHXnAbh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFd3FAAoJELSic+t+oim9kQgP/jDdirjb2Fn6NIfXMXDpTmjT
Lk2cjI5V6CIT5bhAwMhyStETq4vabJZkqNrURenq7y8yxd7dIcTzI8lDcdMR2iFS
DgifVBvOnhvpo2JYhbgcPiM4q/rwXgveN/j/0mmsyx92VzA+7AMoAGrJ9Bzy6paF
WEJ6cGv2ccLSMbIlJyYzjVhASZhZe98KFvQg6c+qU0I+muu1f6x2gk/7YsXhpEAy
kPhGesXZW6JDrXa76FjzyPi92VksvtFrIsTy6w4qD/g+O2DjE1Acp4MMLSHPAmZo
YvUjEzJhwL1FC7d/rRkEiS2PJHpvYIaIWL6XMJDGv5ARet7xGwOPKxz2tSCG8kPg
I0/DvhTYWFHs4gPQGWLHM1uNrhdeWJXbQPS6XXgFh9FbTaai80JqWIjnTKfWntpr
+Z3UJy5BQ6z6mCUSspAPo9J7diVRe9gmZRHgWzrv000n483qpGufVmCEIRKBf0gR
+cWfkgXUwXxsUrILWuc1gNlENm67y1a8azsQDo6DLnQoXhZZ0NkQQzs8XeyAZlqQ
tjal+J2FggpRu0ZBkZhhuEvPEcOBxIxjmQw9qOGdQ6jN7KE7D8RZpd4yoWMtjWer
vfvwV1Z9ulKyL+YfwEwpIitzCUeMp59RQltV4FPc+ji3L3vWrrYIKZ8Kxvy+SeBm
2NUR8bPu+Gtqgqu5S/sS
=n3i2
-----END PGP SIGNATURE-----

--ncX6roZrNNHXnAbh--

--===============7043115622386094512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7043115622386094512==--
