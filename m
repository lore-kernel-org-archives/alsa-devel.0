From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/11] ASoC: Ux500: Add machine-driver
Date: Wed, 9 May 2012 18:05:21 +0100
Message-ID: <20120509170520.GK3955@opensource.wolfsonmicro.com>
References: <1336485457-27441-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4358492837617426698=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80D61104540
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:05:23 +0200 (CEST)
In-Reply-To: <1336485457-27441-1-git-send-email-ola.o.lilja@stericsson.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4358492837617426698==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qE0/TkNoJLLGUzs4"
Content-Disposition: inline


--qE0/TkNoJLLGUzs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:57:37PM +0200, Ola Lilja wrote:
> Add machine-driver for ST-Ericsson U8500 platform, including
> support for the AB8500-codec.

This looks basically good - there's a few things that were identified
with regard to the CODEC driver but otherwise it looks good.

--qE0/TkNoJLLGUzs4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqqPJAAoJEBus8iNuMP3d78cQAJMlWTz7OvGrTKcAwnq5g+hc
axkZNQGt3ArrCja8fG1njbS1j2NTxgvY/HyL5yqESitXjisafV9FfUR4KX+TWbiW
zU2c99j3sQfPAAzr/CrqX7gtKvDYE7/4OrcVYwaFOIACYcBP31rntzNBnEF8ZjhQ
em5491C9YbZFnL07HZRhsYOvr/btFczBhIOdo0x6BNDhQDsUHi7iD8AZGAeGzha3
bwI0EySPl4SwD9yaL71C3Eo76WSIrMYtlDHt4W4hIsv2DQ6dC2EAwl9PKtXKX8jA
pglBZxeSDQa1AmHizVRvr2ZsavaFVQIInQWSrFy89g8QbsdagRx/Z0vPRUYB5i7a
sdSAk/Kt5n0+/rNxRd7t+kocuq1Ybb88nfdhClbABBOolGS9Hexynr9RoRTJQ6lR
AqOvWRSdjcfdAF3dIc5v+BFmeC3LWm4gdKtu1J0GRm3rFNDPNugjmUnSwo+E94+e
qE5v2Na6+/Zsu0TX1vOqyj0Lqif1qGg3rMBbcraRF5tdUW/ou6RVtTWonZpvtF/6
Jpu+dugyEoL3fYvp0ton8P6QJK+DAb6knzSobB1A5kkENjytYwr+LnL4siqrM3xj
OeVGHnRjSRGjtqLZsDPdaI+D7rfjy+IXJpqZKJu3PbRsxsy4PZ7Gg92beqI+KEQ9
kS1gGmoGobNQT1edQYye
=tFzF
-----END PGP SIGNATURE-----

--qE0/TkNoJLLGUzs4--

--===============4358492837617426698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4358492837617426698==--
