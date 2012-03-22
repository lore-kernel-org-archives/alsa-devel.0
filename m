From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add extra parameter to
	device_prep_dma_cyclic
Date: Thu, 22 Mar 2012 15:39:31 +0000
Message-ID: <20120322153931.GI3091@opensource.wolfsonmicro.com>
References: <1332422343-18814-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4332262956006234345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3521103E85
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 16:39:33 +0100 (CET)
In-Reply-To: <1332422343-18814-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alexandre.bounine@idt.com, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4332262956006234345==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2012 at 10:19:03AM -0300, Fabio Estevam wrote:
> Since commit 185ecb5 (dmaengine: add context parameter to prep_slave_sg and prep_dma_cyclic)
> prep_dma_cyclic() got an extra context parameter.

Applied, thanks.

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPa0eQAAoJEBus8iNuMP3d3EUP/2eSHuLmt07Q5FB/y+Fsu5jR
05Q9/zES9tTbOeWqKOziWMIzlkJ/jvpJShOcw5PBGJ8bw6/AoyjX9heABXb1jsJc
8w6kdsTMY3DG2YsErVcFERgqZpClfWuEWCds8UABNGr4W6Z47BMcS6AWtqlaxwzG
4affpQoFqpNtdG5WQcp9i7+no6hsRhoxmE5nM8py2SFJAJHnbUz/8lbVzWuCyU62
ASNS68BGGCueZ+ysWQxzUmurptW6r7pmBhqTzrbekvNtulv9fNS3/34lrYGgOfJR
4w++dREv/iOeJGrrOF+5+t5mGlIaNz2YwjEs08k4ToZSG43fPsELF9rJbNIdYrum
HWV+GKmrE8x18LBo/iefbKe3rciiTo4DV60aR3XbeREWpp7q01cwkW1kRn+ah8eA
hz03gh2rbETfjAsdrAU2YAbrmBhmVzoxiTL5OO8cg/6RYOVM6Z6przij3OE7y6re
CxzcqiAcj8OO39bnfR60sLdKJOs//79ClKr4xNxkPfpgXq5Fz3QDnVMzOXMyu4ez
E+TX00I+sD7fBSubwTdrg4f+qspzbEDq3oj5aGMe3FJtXNoUZ2w0C9LPS9ht+0u0
wEvlsiRswnLdpWKCprlSTlEKfLMZcKT1t2ggkCNGellio6yorGpa+YpnCw4XXAm7
tF2OrXj+PcmykuLb1vdg
=wMKi
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--

--===============4332262956006234345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4332262956006234345==--
