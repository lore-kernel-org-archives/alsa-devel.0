From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 18/18] AsoC: wm9081: Use IS_ENABLED()
	macro
Date: Wed, 27 Nov 2013 18:22:31 +0000
Message-ID: <20131127182231.GE14725@sirena.org.uk>
References: <1385045312-15092-1-git-send-email-fabio.estevam@freescale.com>
 <1385045312-15092-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0062434679035424451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EA8822651E5
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:22:33 +0100 (CET)
In-Reply-To: <1385045312-15092-3-git-send-email-fabio.estevam@freescale.com>
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


--===============0062434679035424451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="npS0ES1SXSoP8oeu"
Content-Disposition: inline


--npS0ES1SXSoP8oeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:48:32PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--npS0ES1SXSoP8oeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljhkAAoJELSic+t+oim985UP/32uX0Fq4KI/+nj/S0Dyc+wa
HLiA5FE/FDd8vFjeX6Hfq3MQW2liQivmrhcqBCU0ovmg0RNqGQlhEVrISWOtWnKc
pbTstxGaY1NobSHKXZyrlu77us2wB4TxMlDMWxY035+wYxmL2/JP2RnYopQ59AU+
7YgB6S23GxD4N1xDyTLaf5Orp46ASC3mdbtkwHyKhYC1IFcdfVrVbtrnBkhfzJSH
+VDBtCXzaJ/12nHRqcDf2PXFgiM2CqUsCTXqcyjT/hn2O7KSpEVt2/asxaxuRvHX
OLtrq8HOcJ2GoQ3pkRELzrF9l94hwyNC+QWAml5vMecVmGAZVqYWiHgRD5ObljPP
Gb3/ywwVpTcLdYtJwm+XmIxuAsPqo3yx99HtxemSX/+FCMi6cw4xIUbTHg2P+HjB
dFT99/xj3rvkLFVg1bOPAt89i5HCs/LKUAJUHrcI5bVRCu107VfQGhrkQds25oy+
gMdjj+2P9Y2aut0U7VjJtsBQ7h+sXgblK86AU2jJ+atKSgksx4FBwOTgfAUAqQJE
AprYkg1ZnVlZExIP+xEqiUwPMw4xkkNMrLZE4cFxqi1sufJ1FDplREuLOVmj/l71
fHrG0oLmPR/oixdysAj7RsdR8AKxpGrY2n9A8V6rmdAU/NcojFkOt867/jwFl53L
zmLkKlsbxL0VIUvml5pr
=8zlg
-----END PGP SIGNATURE-----

--npS0ES1SXSoP8oeu--

--===============0062434679035424451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0062434679035424451==--
