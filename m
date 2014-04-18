From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: document that the regulators are
 mandatory
Date: Fri, 18 Apr 2014 15:07:24 +0100
Message-ID: <20140418140724.GL12304@sirena.org.uk>
References: <1397779590-4128-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWvls6SgojIh1mq8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397779590-4128-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--pWvls6SgojIh1mq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2014 at 02:06:30AM +0200, Alexandre Belloni wrote:
> The driver will not probe if regulators are not provided. Move the regulator
> properties to the required section.

Applied, thanks.

--pWvls6SgojIh1mq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUTGZAAoJELSic+t+oim9fyoP/RGkHO6OtnXy9E1NNJldYqb6
LdNxpTDCwRTdi1e4zSEGg9r+J6zJn762It3QW4slJVL+XmY/zUudIVLtW3cnwPkD
yDLncC0p2LzLqHlRyD4j3cvrPrcGB4GYVizSI16VfaLBm7w83Bq1erH87eGEhB3x
vE+yZs28PDJhxasoWOsAioVCJU6QxLs8W5e0UjeKkVdHYul7fhJGVFrSkO5QYHh/
jJsfpiFZn36zt3cVioqqilPDCrXXVw12ix94XM7LoPLGSWqNYkTBrdzbQePBOub3
W6MgpBw2SQikGz35H8EVcwRsBXY3XCeApifIDzlkPppxd1R0RhZ4FoGoG5fpyLcA
mjD3znfIkyIH7k3+FYy3Ck3MwUdePMoDVsDHM54dcSL8t2be1oRS6SIgq/+xSWtr
yHshLNWYj3Cf7YYHBa2UaXPh8C0b6o48CFuqCZZAqZNBlf+a1Xl3zVTWdIm1xphV
YlAxlsm6K02Wk+dt5mFNBD7nx1amjLqvA+RG8NrqOHuTe2TpZ7zqQljccSx7Ih0s
UYfNIhEIApWaAbrO/2wkn0O83xrBzSG5/lMRIFxiFqsP5QJ6J0QN9wybWzHUq7Wt
wIuPDV0rkP5IzESuTnn+D+qFVCpj0a/NIwPcQG4gORBbzqaGf/e4VZAx1eT1xvs6
Gcvq5FbGFTSC1OYSfnkr
=xqYX
-----END PGP SIGNATURE-----

--pWvls6SgojIh1mq8--
