From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/9] ASoC: fsl-ssi: Add imx51-ssi and
 of_device_id matching
Date: Wed, 8 Jan 2014 17:18:21 +0000
Message-ID: <20140108171821.GL31886@sirena.org.uk>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4958884735190060327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2242E261AF9
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 18:18:35 +0100 (CET)
In-Reply-To: <1387545096-2334-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4958884735190060327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0lEVOnlPgANL913"
Content-Disposition: inline


--f0lEVOnlPgANL913
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:11:30PM +0100, Markus Pargmann wrote:

> This patch introduces distinct imx51-ssi as compatible and adds
> of_device_id matching in the probe function.

This is missing an update to the binding documentation adding the new
compatible types.

--f0lEVOnlPgANL913
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzYhaAAoJELSic+t+oim9gsgQAJUa596lH9kZ/azGEdDswJuS
4wt6r11S+d86RS0N1q/Vwa/5Ye1yv3g56yvRn6VrPVu8EXRF9IHBd1v6LaRbBJTE
Tfs9Yf6Kb2PUJdQjgxYv61yqyNGjlsFYryE8y2oKNf5UwlGaKr1Q61ueZLu2EO+8
MfwG2CjCG/YpIGDc51Q7O4a9U3FYHomAzkyhXHGQki/cUbFuw86zuHFNJJYXemEn
BSxA6QJEutb13/gvQRYEWiW51U/x7uFbA6lP93BuGL/AYmZPn/wdYc+Rs9TA1OPU
+uOgtzRR2dOIow6vuLB2IzGFeqTXipflav59RK6pgGjO5mvPgOxRFOBVOdsm3pEl
H8Fx7ggOPMJCGwNurLAKc33MzTSCGKqxLWXFN+l1w436z2oIlRoe3ymztMkk2XA2
Lx4mG7mZykPRxKxriOiOM/ae+Qg8n21N/Nk+TrH6O8NlDw0J/y0mcnUNcXEuwXT7
AMc4dnTcMefGelwRBpqdbb2I9UN9b8V/slkixQAKGpoxqBofWUIVQ1xB7mVdkncp
rTngsePVQP7/jFWJUAAdf29Pohu6QIxlL8g1G9ffpEHBq9RpUchzU+HzXp1E5dJk
pJfqxiiOlTg0XsrbsCg1L30DwspmxraltxtBUmY79I8pj3uqN4YT6VbCS7JM4Dao
Rqudoa0LEOkfhJ5P/0pN
=89Md
-----END PGP SIGNATURE-----

--f0lEVOnlPgANL913--

--===============4958884735190060327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4958884735190060327==--
