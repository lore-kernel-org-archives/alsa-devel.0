From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: cs42l51: re-hook of_match_table pointer
Date: Wed, 12 Nov 2014 15:56:26 +0000
Message-ID: <20141112155626.GN3815@sirena.org.uk>
References: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dq1bAwW2kQB+exoT"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, stable@vger.kernel.org, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org


--dq1bAwW2kQB+exoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 03:40:44PM +0100, Thomas Petazzoni wrote:
> In commit a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver"),
> the I2C part of the CS42L51 was moved to a separate file, but the

Applied, thanks.

--dq1bAwW2kQB+exoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY4MqAAoJECTWi3JdVIfQAHsH/ibdJY4F94w+8etIt7AaHp/X
iKbkWLT1kX1bUmztXp6p+Cjhb3st6ihAmGwNOy2wD3KAZihVmixPS1JBUVQ5Rf/3
E5uWeGFzCndHUXqGNH4A/KtsBEI3xi4wzBdQpv/G0NB0EZ1ePOhdmUwJiOpx5lHZ
JXwf9tmmLrl6dBfhoJsUxC9D4tpTyl5qrQNvdKx/GO953YyDk6BXNN3xtby/EJMi
FlHbL65YObqIYFm26FZ8CK3dsJbz/t4Nev+TUK67WTqPu/d3NdMcW8HuC7mW3HpK
CHQ6iSls3/wQFPaKGstgNMw/jMyNRF8MLVI+GMNKzrnHhoHdfn1rBP8+i9Uex00=
=ZWzQ
-----END PGP SIGNATURE-----

--dq1bAwW2kQB+exoT--
