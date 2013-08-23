From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11] ASoC: fsl: Add S/PDIF machine driver
Date: Fri, 23 Aug 2013 20:13:53 +0100
Message-ID: <20130823191353.GK25263@sirena.org.uk>
References: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
 <5217B32C.5070300@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4351426326526686061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A74826158B
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 21:14:16 +0200 (CEST)
In-Reply-To: <5217B32C.5070300@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, tomasz.figa@gmail.com, rob.herring@calxeda.com, p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============4351426326526686061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RVlUGXxwBj5SDcM9"
Content-Disposition: inline


--RVlUGXxwBj5SDcM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2013 at 01:08:28PM -0600, Stephen Warren wrote:
> On 08/23/2013 02:04 AM, Nicolin Chen wrote:
> > This patch implements a device-tree-only machine driver for Freescale
> > i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> > fsl_spdif.c drivers.

> The binding looks reasonable to me now. Thanks.

Is that a Reviewed-by?

--RVlUGXxwBj5SDcM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSF7RuAAoJELSic+t+oim9+HEP/ibJzcTxbAHEbLA7SAnvPucG
+xvdOEwiXDFyGf4JTTxkiCcMhqnewY3ikII0orwtGDus9DJ0Xdse0PKlaiiBrITN
lVgVfmtDYH2qnricsoDM5LB4Au/cmCYI7NylX9a1KI9pNfyv1qT3l9gnBqvUizop
tFE/48Jo3ubXNvhwVqW2rNgY1M08hsSsPKcH+k5oK8SU2jvsh6ItEXkhpnnyGF00
uF6a4F1zEbUo0lAWRjzeqzJgAXGFGNGLLsOf40J2Icluq+ehi8gCWAk4ViXcJNXn
mmL05AdQNvzfRv0Nwqz1WDsdOl3Hc1LcjeodgXw2IJvT4VRdJahec94p3fL+Q358
jUkz2556CbkWMbla3pUjJkikqapw6MzK4uFnOv5fg4LoGPxt9YXei0iSI4ULiz08
oArT/cg46//MJxRjjc/ZJhXen1vRH9G+p/QXi7l2KYZZOU1t8izIj8oANZCI29hL
be4zHBKk60295SL7VsLGeg1hrUXsgg5jfUvLy28mamVE9u7KbHw8wB2evzUd+1Wi
W4MII2l+mQzGpKiVd/AJwq8TPvnMw2mH3h9vJQEsaP6EcJSc9t2E8AqpGhfnFbR1
nO7qSAGyXSTBhWbPgJfxL3duKGgYRijKDWmwsfU7inM+85AW4e2OBTFySzjZvEhc
taESuc53kqRsYweV2hDU
=qYva
-----END PGP SIGNATURE-----

--RVlUGXxwBj5SDcM9--

--===============4351426326526686061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4351426326526686061==--
