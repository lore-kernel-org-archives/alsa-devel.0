From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: brownstone: Automatically
 disconnect non-connected pins
Date: Fri, 8 May 2015 12:05:18 +0100
Message-ID: <20150508110518.GD22845@sirena.org.uk>
References: <1431026869-27206-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3174689495024219482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2D8F265B65
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 13:05:26 +0200 (CEST)
In-Reply-To: <1431026869-27206-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3174689495024219482==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9txOV/VkvTinkpci"
Content-Disposition: inline


--9txOV/VkvTinkpci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 09:27:46PM +0200, Lars-Peter Clausen wrote:
> Most DAPM input and output pins of the wm8994 are either used in the card's
> DAPM routing table or are marked as not connected.

Applied all, thanks.

--9txOV/VkvTinkpci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTJhuAAoJECTWi3JdVIfQ5X4H/2QmrvpbjrxkdZps0CNWEfSy
h4q07c2pb6y9OBInvfz80bB7anWOo7s4oj8kEQ899ZMXA2ZLv8SUprs/8QftW9lF
ukwZhuM9MGzcaBM/gt45X5NDOEB+I0D5jqgl0YxbTu/KvO66pQk6xqfs6OUZ6ya8
xgAtg+5kjjQ/gy0r1vzjKMrmHBpo4KPb7YmWx0DJhmoV1SJr3lNSwm23e42LIrVO
9712mX4VQumL/EA6bnaRFtITgx8ErFxbyrd1zPfzJVJiFkUOubKeNsRAqRgG0+yc
KQiiLbi0Pmb+ldmVzye+4EC8SwKAUo677JZZH1gLkTq2oAFb30+QDMBXc5pcwIU=
=rYrX
-----END PGP SIGNATURE-----

--9txOV/VkvTinkpci--

--===============3174689495024219482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3174689495024219482==--
