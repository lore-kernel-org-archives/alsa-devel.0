From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codec: wm9860: avoid maybe-uninitialized warning
Date: Sun, 14 May 2017 19:05:24 +0900
Message-ID: <20170514100524.7rxtz7v3omjwonzv@sirena.org.uk>
References: <20170419170449.2965453-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hteqfnvwvobitfyp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419170449.2965453-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hteqfnvwvobitfyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2017 at 07:04:20PM +0200, Arnd Bergmann wrote:
> The new PLL configuration code triggers a harmless warning:

This doens't apply against current code, please check and resend.

--hteqfnvwvobitfyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYK+MACgkQJNaLcl1U
h9D7ewf/f+H3NEKn/Un8+9OdaqUQN++JCIHMJrjlGxzAbJhP3E/LY7KVoRgb2ovt
5Hyc3Tb7hZUxonS/6Mp0UAvhViaMtV45+nJAax0nEKmbzaGMsMprrKDePzcZ5TjH
0Jvkpp5O7rKWCNrjGKqNC3hyWSvJ0nSg0YGSbVcCPafYaB22vqLHITYVfRok6iVc
9fI49cnYSLmk30Vx8c492wpMfFWpHV+gYpjpf/9rrE/pWIwlP8JZb4iHxnShuRBC
hs18BkYBiomkOD8N5Rv7lVvgTeRH7OfS0zbcb2NgeuD2RdOiQWYBgZPiZf9xIjxn
FL9JhFvUHWyQDXym/KDCOk5MzvLG4w==
=sKdm
-----END PGP SIGNATURE-----

--hteqfnvwvobitfyp--
