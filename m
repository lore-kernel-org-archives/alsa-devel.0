From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: hard freezes with hdsp with cardbus/pci adapter
	card
Date: Tue, 11 Aug 2009 07:06:19 +0200
Message-ID: <20090811050619.GA12438@pengutronix.de>
References: <h5q3ur$13e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0356126169414248694=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5203524A18
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 07:06:29 +0200 (CEST)
In-Reply-To: <h5q3ur$13e$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: alsa-devel@alsa-project.org, linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0356126169414248694==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> i have the suspicion, that it is related to the combination of the hdsp
> with the cardbus controller of the adapter card ...

Full bootlog please.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqA/EsACgkQD27XaX1/VRuQEQCgmYqdKULde/OaVILlH4jwhGNi
uTsAn3AP/U2VaK27ae6g90Z1JN2VbEPF
=UYyd
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============0356126169414248694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0356126169414248694==--
