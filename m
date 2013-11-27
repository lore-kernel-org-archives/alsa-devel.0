From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/18] ASoC: wm8988: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:21:24 +0000
Message-ID: <20131127182124.GD14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-17-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5108667884312401301=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BFF52651A8
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:21:26 +0100 (CET)
In-Reply-To: <1385044736-14911-17-git-send-email-fabio.estevam@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5108667884312401301==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0DqEFmQYKPWH7Vlc"
Content-Disposition: inline


--0DqEFmQYKPWH7Vlc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:53PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--0DqEFmQYKPWH7Vlc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljghAAoJELSic+t+oim9mYAP/jiPPYvZmnUii8Y+XIANLUxb
BT/kSSyQfH6ygJ/L+hwl5T4GS8/M//v/FTXGSxbi6HGDwJ4z8ebDuZAmrvaGWjuJ
59q5hHHTSP7wfYD6Z4BqwMiH0GIPecZwxrlisECGHygHWtM53clElSSJWRj1puCw
aoLIhnejrf3vDEjb2dT3SvXOt/5cC7e1lxMjvQ8RcETXy6s+2laMXC7ddph3d1p8
xwJOKkGfskrG1HDPvL6HzGha5yzXS9PoW70mLSqtKfh6BjH8dvVoDHA1ALkFxPKp
59eDCcyzK+ITax3sLXoxRnJJiXHtGs24Usd7+uyYbe81QUcwjJg6QkOvYYaBK+xu
8GZkA/H2httY/Po3X8hUNONcEDNZ8a6PxwJKvH70Wuk8esjZvmpREVjJUnlJcJRU
O7mxgh+APeKg51V76QjoZwd3Gz1qe1DmIgjGU180otVkHYF5bRDRvaH5I6McGQVS
SZ1FK6Ez46xX1u36HsmmqegcRsWiGjk5r+BLHrdrXO/n6oZmvqefUpp7P4hQrYPW
gEWIYYxEDwFTsag9+KCOQbu08r0cUq/4fvrP7CEh38ZrDNDlz89aVEfX4VhOOO+o
c8GLWwaRAcCrDFhhTgf3JZHFu4gPS+qtJHSSbmsx4oYSsq98urhwbKwoy6pci8RR
wIlgdQWUAG1jxWUvk4oY
=CsH3
-----END PGP SIGNATURE-----

--0DqEFmQYKPWH7Vlc--

--===============5108667884312401301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5108667884312401301==--
