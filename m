From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Implement capture support
Date: Thu, 3 Nov 2016 17:26:45 +0100
Message-ID: <20161103162645.qrfrvp7hkawi5g4h@lukather>
References: <20161103102048.17125-1-maxime.ripard@free-electrons.com>
 <20161103153218.fibbz7y7pqwqyo7r@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bzanw6fdjnhlfscb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103153218.fibbz7y7pqwqyo7r@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--bzanw6fdjnhlfscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 09:32:18AM -0600, Mark Brown wrote:
> On Thu, Nov 03, 2016 at 11:20:48AM +0100, Maxime Ripard wrote:
> > The i2s driver was only implementing playback for now. Implement captur=
e to
> > make sure that's not a limitation anymore.
>=20
> This doesn't apply against current code, please check and resend.

Argh, yes, sorry.

I'll send a new version.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bzanw6fdjnhlfscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYG2VBAAoJEBx+YmzsjxAg1FsP/igf7SFbR80qo9BSIaOjuFGJ
12uViX4etBx6wzUIU7e8zxadkprXzHeRlHrK6AQgOzVjSYJJKzSrdUaNXy7ZwP5Q
AWiiWjsrWp0kQW8X2YGK95QIYJPl2fJpQh8BF5fi/XVjQXYTJK9lljDZMei2VhDi
D8+wvjvlCB9f7L2i9McBPlHLXL6iO+/Xl60BtMFmCFJ1XB6slaiWY5FP+9yvJBHj
Cxke+ER7aO4fpodb3fHK48J0GjXB7KjVEasX+O8T9jbyFCLTL2qRxDpwNGo1Yl1R
yg+I8MZ14lcztFCrgkWtZn+eyBKv/ZEGCON6r3LEynyZsqxxE+235bCD0xhvIKxH
njxo9sibHO4cgQGMk7bvQF0ajL/nDeq4IfZgyUDOd+DvTe+zB9QL/KffooylODSz
GJLaaHBej+QWYueRYUVbG6m1fJO5c665QzZ0eDLLddhJqu9+Y6khIXW9GLnqkxt9
CZ0akK3EOP/yRgTw3fRgh0cSmdPgyx9t4MnNRYlIqJXe9RlJMUQeG2HfK8JaLH2/
QvJxAKjyCc/i1PbyINNGM3AqRP1FLliPH9zlVe1XjZfOXZocCr8vM6o9RzcMw24Y
alem+5e9wuOE4VIdUs+2eHIrKdXWhTyoGVR7R3Z4ZHwBpKkkLU8pZA9tMAihqOQw
9ZOgngsefUgs/bjH+TLi
=1NXa
-----END PGP SIGNATURE-----

--bzanw6fdjnhlfscb--
