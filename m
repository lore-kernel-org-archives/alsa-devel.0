From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Don't try to round-up for PM divisor
 calculation
Date: Tue, 24 Feb 2015 17:26:42 +0900
Message-ID: <20150224082642.GZ6236@finisterre.sirena.org.uk>
References: <1423993031-29474-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mDCy6lndoo077oG4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423993031-29474-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, timur@tabi.org, mpa@pengutronix.de, shengjiu.wang@freescale.com, zidan.wang@freescale.com, scerveau@voxtok.com
List-Id: alsa-devel@alsa-project.org


--mDCy6lndoo077oG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 15, 2015 at 01:37:11AM -0800, Nicolin Chen wrote:
> According to i.MX6 Series Reference Manual, the formula to calculate
> the sys clock is

This doesn't apply against current code, pleae check and resend.

--mDCy6lndoo077oG4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7DXBAAoJECTWi3JdVIfQcEwH/1VnA0Tx04nXjTcHI80uVXLf
XnnuSZSM0KOpTPGvuK6V3+u/OzWICGmJ6qb64GW4M/yJiz7BRFn0ywf1FhBXrIhF
82K3tBi3opb27SAXG8SGseyS81kRqgh1JHw4C3wKEKuH0H0H12e3O5SqW/xLOU2n
N5dyUnEQ118WZPOoSHwbtEleygYN4DPqJhqJqSv/3V7HD2f++Qa5+S8jFzPFzCp+
tFsnp/AKFwnw24YFuZpGXPhMlDD3NS9xWNqaxIQXtV+6MADeXj+/Nwbj1zwm/Xaf
1ffVFhdkK6Oze37evlnbDwJUn/HMXVByEkALCIkz37lnFxMua78wxOBgDKm7wHo=
=EM56
-----END PGP SIGNATURE-----

--mDCy6lndoo077oG4--
