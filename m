From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Mon, 12 Mar 2018 09:14:55 -0700
Message-ID: <20180312161455.GD2186@sirena.org.uk>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226183407.22335-1-k.marinushkin@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 07:34:07PM +0100, Kirill Marinushkin wrote:
> Hello Mark Brown, Pan Xiuli,
>=20
> As far as I understand, the suggested commit *breaks* the functionality i=
nstead
> of fixing it, and should not be applied. Please correct me if I am wrong.

This discussion ground to a halt a bit (nobody from Intel seems to have
looked at Kirill's patches?) so I'm going to drop this patch for now,
I'll keep a copy around at test/topology.

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmp34ACgkQJNaLcl1U
h9AQagf/YP+4voqHwXm613u/swphoy9i/dHKeDk4EIB3PxB1l1+Gelsevaah03E+
o6UnhdriUyx7txNPuBJiYxMRaF6kMfXF8fLwSSVoOpllqaIKN61NpUcaXBQ5lCLc
/Ez7XSN98djslex2/4tNDRkqzyC9wIuiDnrz+mcVUTrCDmtFH9nlT1zqe+tYX/86
471CDcjTqIdiU9EWVu1k/EkXR3+9KTJGlnU3xP2hlEZ3mcflFCnCySm1EUtaWj21
wDnI7auZL88fjY6zS5cA8t3lAKz/Ug7RtIuHk3VuwwqdvdUbV6NI3TTNnJgM+I8x
KpBPo9bxzDZVqo/IBVBF2BjLToDz0Q==
=UMCH
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
