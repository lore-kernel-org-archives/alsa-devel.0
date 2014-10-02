From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Date: Thu, 2 Oct 2014 16:53:50 +0100
Message-ID: <20141002155350.GU4273@sirena.org.uk>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R9lH2i8s2YEs6mH7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412198720-2326-1-git-send-email-dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--R9lH2i8s2YEs6mH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 02:25:20PM -0700, Dylan Reid wrote:
> Allow Headphone and Microphone jack detect gpios to be specified in
> device tree.  This will allow a few systems including rk3288_max98090
> to use simple-card instead of having their own board file.

Applied, thanks.

--R9lH2i8s2YEs6mH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULXUNAAoJECTWi3JdVIfQKY8H/3bwSnGiY0yhRfJ7CxbA1qzw
kHX9C3U4qI4WaSRH5lc8tFVxbTALuPz9MVXG3AwBqhK92iDtQokx30aOLjIkeFC6
EjQeHhJfxm4gqQcvWQQ5kXB6768NOoDoCupxJS4x+WwneXkmeMupJCtrL2xtBzuc
cIkZMGV1OFJRBpxyabiz0h/xp2S8bF9zG4TM03MRCvgm8ixOVE5xUgOSI4slIewC
fn1fn68dzNgK2BGUJOY/YvOvwcc6x98nqoYqDnAR7RGKXQdEsg+2ovWuF0C17aDM
X/5wdx4vS1UzgAA+5niMwvSQTgtFIGJ5Uy7VhFemjSXbSZ3SuH19QKlyG5ekTvI=
=HWVJ
-----END PGP SIGNATURE-----

--R9lH2i8s2YEs6mH7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
