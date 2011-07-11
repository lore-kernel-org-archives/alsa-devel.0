From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
Date: Mon, 11 Jul 2011 12:00:04 +0200
Message-ID: <20110711100004.GA11153@pengutronix.de>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
	<20110709025252.GC26900@sirena.org.uk>
	<CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
	<20110710083359.GB23199@opensource.wolfsonmicro.com>
	<CAA+hA=SBP3Qv0x-9KQMR+iT9nT1E6_HamyM7zeNd1p8rfE6V0g@mail.gmail.com>
	<20110710092623.GB23521@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0384324328=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110710092623.GB23521@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <dongas86@gmail.com>, s.hauer@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0384324328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Also i still do not have such type of codecs integrated on hand.
>=20
> That's fine, audio hardware is so flexible that it's unreasonable to
> expect that all possible systems have been tested.  So long as the code
> looks sensible it should be fine and if there are problems people can
> always come back and fix them.

I will get a custom board with a different codec in about a month and
will happily do tests.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4ayaQACgkQD27XaX1/VRvYCwCfSHonkrKxTOIhB5F+oXTkJ6Pt
5uEAn1UbR55TIU5Tt1GokiaQdqnFMmwE
=tBEb
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


--===============0384324328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0384324328==--
