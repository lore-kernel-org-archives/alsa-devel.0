From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/17] ASoC: imx: move eukrea audmux
 call into ASoC machine driver
Date: Tue, 6 Mar 2012 00:06:45 +0000
Message-ID: <20120306000644.GA3201@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
	<20120305174612.GY3224@opensource.wolfsonmicro.com>
	<20120305192759.GB3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5260504621913691619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C73824149
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 01:06:47 +0100 (CET)
In-Reply-To: <20120305192759.GB3852@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5260504621913691619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 08:27:59PM +0100, Sascha Hauer wrote:

> For patches 01-08 I can give my:

> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Great, applied all those - thanks!

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVVRYAAoJEBus8iNuMP3demMQAIYTNEErW+lzE6hFHW2u/SLk
aClxF5Ze83edA/+8+n9juRIA7ADtGcTw6MbZJ0f272Xq3sfRBYDQ08HH9SfYDtfq
qZJlL/5l+I6TzMzasplwdJRVm+/ietLqIBCGs9CbCarnYGpJAhtt6n3lXm3+ldfJ
7cQHMganl7MaKA6DH5mGSnoJmjLb97KELidDZMRnxUndgb8K+J/pjoqSm+ma5FYG
f5uC5zFYq7pn4vVTKmU0+4rjVduhynbkNeSKymoxL/jhcVxhHRVM6rvOWGQgQ6eb
GbSRKCfJTIFzC67G7egY/rYoIkFxBSTbBJCdesdo5+TOswXi569WfCAmpL9jbNic
gamMiWVIHgSxK3pQutB8L9LFuqrmsF7QiKs0fBWHk1/7KxNxbQLMjH+Q8/ZlPrdO
9hVrj71a2AwR4XiRLMy8mA4hYzjs06XcAXzqtjwC02oDQuycswrI4cqpeZW7+kEe
2eVF6SxnLMNZUCcQNzquJGT7tNF+04YX6n6E89STlPzlo+x52vKjRaYMFk7CIsIu
a6C1jRTKTa7iZZAcWdXr9ZfxtneCog4JzCup1RA1U/PlhznceW8E7IBWEHyqsVE1
WzhZy5rWfDVW+PcJ+dGjPFYXoRbRFL6HJU+FwTPZmigtmkDOI+mKfMyPyhA1Ms10
mlpYpZRHzdTsJkYu6GSX
=5VQY
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

--===============5260504621913691619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5260504621913691619==--
