From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Add a configuration option
	for LDO2_POW pin
Date: Wed, 24 Sep 2014 09:59:11 +0100
Message-ID: <20140924085911.GB16977@sirena.org.uk>
References: <1410984860-40626-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6804006202092384410=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8AB5261AB7
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 10:59:15 +0200 (CEST)
In-Reply-To: <1410984860-40626-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6804006202092384410==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2014 at 01:14:20PM -0700, Anatol Pomozov wrote:
> Some boards have this pin statically tied and do not require any configuration,
> some other boards allow to enable chip using GPIO.

Applied, thanks.

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIofeAAoJECTWi3JdVIfQ00cH/1y70mbFxw0ECGX2FSm2mYW3
UHrHlszZcP4CFDxHTOmIQ0vGhkJqgBJAX1Odr1acNh3fbNP+QRe74SGHtbg0egqJ
SbZsfc3kN1UffGo/WyAK4Rnd86SV816eBDMvMvQzPWwXS3Y7eQg3sCMPHDHNgY9m
KmOCQNxNHZ/WaoU2zTUsNPRO35v346hX+zufaOJw+T0KTpsc7sprUC7quM3fXsIQ
azlz7dOIGG6yx5OGLp4XA3OSjnHavBkezr5GtKU3DBa4/tZeAz0baxCuuvAC9Qqd
6Cs6knu9P3BDZ04xPSzTZfcUZgnMa7GphWLIWhL+zqpJdXWv6b86+j+EDNvu1To=
=BpzP
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

--===============6804006202092384410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6804006202092384410==--
