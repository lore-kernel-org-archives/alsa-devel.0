From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1761: Fix input PGA volume
Date: Wed, 22 Oct 2014 10:24:28 +0100
Message-ID: <20141022092428.GH2344@sirena.org.uk>
References: <1413967878-15145-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413967878-15145-1-git-send-email-lars@metafoo.de>
Sender: stable-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2014 at 10:51:18AM +0200, Lars-Peter Clausen wrote:
> For the input PGA to work correctly the ALC clock needs to be active.
> Otherwise volume changes are not applied.

Applied, thanks.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR3fLAAoJECTWi3JdVIfQQ78H/2zWN0ikcuA/kFQjmRaFfBVE
0/weCSS4iF1Iv0FIjQhT4UzkEdfQCDvnH84Imvc5Or9r49vMU+d7sTfaMUs0kTL+
oYcVdQPcPKSRiSSYdf8FE7JbdUyIJfvLVgR0rw60GfMkGsCQLOVRYYDd56ykAVZI
+qdw6AW0lonKm3EEhc05ukU/J+kp35IcCA2iasgYveSlUJbUtyrmZZ1uwfc7ScIK
b15mjWAyQJrf3yscN6cXdg63eteAl6iVXFOgeld7ZStgQ3wtjofvivmKEk9enFDh
DNW8VfYAl1qkzIKyorTWYp6YKSojbyESLFYsk4ySu5Qm18dAL9o/OwOBa7/nI10=
=qSHD
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
