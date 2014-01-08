From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/11] ASoC/MFD: twl4030 codec local register cache
 removal
Date: Wed, 8 Jan 2014 12:49:38 +0000
Message-ID: <20140108124938.GA31886@sirena.org.uk>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QgrZH155mZgoxgw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0QgrZH155mZgoxgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2014 at 03:27:45PM +0200, Peter Ujfalusi wrote:
> Hi,
>=20
> After the twl6040 codec, now it is time for the twl4030 codec driver to l=
oose
> it's local reg cache and let the MFD core's regmap to take care of the ca=
ching.

Applied all, thanks.

--0QgrZH155mZgoxgw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUlfAAoJELSic+t+oim9ZNwP/RJWs+IZRPqhOIZeqe4GDHhB
c80HLhz0teCxgTRnc6vyaVG+EvKFTGkIxywiYsnaUlb35msP2LtY2gGCGmgVmnsT
D24J6ZGmSAXztKPLgzutkG3FBYRTTJgV9lMubRwdmocGPTTrAxpn9KYVwrppv+T6
R6hn33YFW3SuAHR+pnEhw1l3MQh9mDIQnyKVbwXaWX35cJfrAqzz4kD4gPAyM8HM
yAaWnAsV1f7K7PqJkjBXCzROoPz1ZByT1/qUxeLLnTBqm1/puRmM+soiQoCpyUvp
riC+rEXHgxzqqm2u2ulrLOYtev8IlUqbhuzeXxjnbK9KApnJ2sd1CffISrQCqIKS
Mehm8C+bMFigmlefxFu88CGR3CPnSk78V0Ik7OqWg7s6g/birb9yu+2rXMujeC/X
kgxPw1pyXH9qZ1dYy9ZolQyaZFiVxwCtPRPGBIecgPWuPI3O4pUtqtQ1yXKzCyFf
8pD+1jjqrKWA9o2JF/da1W2V5vnqZr35e318huC3G5xhNK+U+LmqSHCjMenRtOD4
VNjO6Uhp/pR1Y/dFih6tA1dKAOdB/ltHgq2TiGihaswnNRXBFEmLPEWYzKacEFwD
ZALVzN/q8nz3NSxYkn2xAvoS1PxOdzEnsUg5+KMNMLeLy/h44zpUXfLY4rMGlFDM
TWGyxX4dJqQI2JzE41Le
=ZQxO
-----END PGP SIGNATURE-----

--0QgrZH155mZgoxgw--
