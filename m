From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2 v2] at91/ssc: fixes on ASoC tree for 3.8
Date: Sat, 12 Jan 2013 00:04:47 +0000
Message-ID: <20130112000447.GD7873@opensource.wolfsonmicro.com>
References: <cover.1357912706.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1357912706.git.nicolas.ferre@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Olof Johansson <olof@lixom.net>, voice.shen@atmel.com, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2013 at 03:08:29PM +0100, Nicolas Ferre wrote:
> Hi Mark, Olof, Arnd,
>=20
> This series goes on top of Linus' v3.8-rc3 and fixes an error that
> we have while compiling DTBs for AT91:
> ERROR (phandle_references): Reference to non-existent node or label
> "pinctrl_ssc0_tx"

Applied both.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8KiYAAoJELSic+t+oim9F5wP/ji9hCzTqpjUdKy0K08VSPkQ
3OC3C3O5RGovPzIdIyauHB56LdT1UeOxIi7B9KbG1BZxLsNpSWMhWjnVofOpWmsA
dYqlRZHgXquOILIyJ88cZkj2wD3OMfuWBVdJAg86yzaWx2c4NoRNlQrYpiPW6DFT
S31jJu+P8ilzKa+Xq2xr0PEvhptsRlwGjBhoGRqtGXLhAezya8mE2GEzCEwxJR+D
OKTip20pyFFRHrhcxUXXOBvQz42HvZqgI0RsnymBMfWr7GdssnSUiJsnHsKUa8P6
3cX3L7t43lOtOyFRjo09rVXXo2c68iu5M08J/fFkEwHeN+j0lW0fKy9iV9Jn97pa
EFFkCprL5Gqmum9ekuYyEYnB94puNx0Co2aNKH2FxNVcH7cXfw7nyf1YvPxblHRM
RVIHoIXWgFXcnvuLQqeIhuddY/cWSK/mNf7Y2d1wdMF8FIn5l1kPgHgnN8Abv9GK
xMMDcaIScKLbXNp8OETDrKPOgRGMzTrI+sh+mLY1iUrv1V1h0GcyBY5Hkr29xj4t
gqZr+xNN19xgtG3p6PE795t66/0ebeoC9KBF83z0RaXIIizRC4HPk/P2gtn4WPei
1H1NmrH1CKLvbATy2tObhh+F3iheFLWKImZBUG7JFya/FpQK2AlaYn04gbUS81Bb
ZiAaLpLKxSYbs3jsUp8E
=KBEf
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
