From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Show device id in the debug message
Date: Wed, 15 Feb 2012 22:20:47 -0800
Message-ID: <20120216062046.GB28006@opensource.wolfsonmicro.com>
References: <1329359625.29391.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4112987796379761896=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22382103F5E
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 07:20:53 +0100 (CET)
In-Reply-To: <1329359625.29391.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4112987796379761896==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2012 at 10:33:45AM +0800, Axel Lin wrote:
> Show the id we read when the id mismatch is detected.
> This is useful for debugging.

Applied, thanks.

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPKAUAAoJEBus8iNuMP3d4y4QAIvNdjqsqLVmJuqCOaI3VA9h
lnpsVS1a06Qntws01loGrMHLlV2V/E2chA3kmrLEUSZbcjY4qbFkvUnsL1Vv5OyS
kIqTCIagd0UFei4NFt5D9pgjcLkuf6BgY3kagEOmoHivhFe33LC8/dfLXrinHj+A
NYN/bLbPhtGdg6F+o3MPtlzBBEaXC4j52Wq00kH05MMHKG0repa3bNzQN4Xh/WCJ
eB1eipReikOW9Cd88lVxkG3BISZXtYf13KHcQy+GAoZwE7hntF2dqAF7OKubZrwP
R7puA5U2HTTukIfGgMSGZfrdNB86LB8ns8aOkLVquMr+H8QEdzQ7BYzO8jUgn4mQ
M9s6In93vcHHo1ih02aw5ZrRIyyWBhwjCfrYm3E+UsnuaAfx5MoEnOGfBXqgehxA
zP/balcNLZJNDIvWmIQB/qkQRLhXn1Vsvq9GjEWgmci8gdavsMXCgzRxpH5w1frP
DlD7OG5+8FhNwQjOGnzMH4ttYvuOYFrytQeYYehTf2VPQM+1040tNtpjN3xj9+AT
hs8jVMG4iE8MbXYnwUiVN6N/eAWAnCXegUacDZKMLATAQM1BA3DYrfyNky/VfTtq
4NglDaiVWPM3pd2jTkzonj47dlrGokly4EJiOuWKlHPc/MvtUNmi909MFHvi7dzJ
G0rV/ODJpNadV32D76e+
=6C7c
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--===============4112987796379761896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4112987796379761896==--
