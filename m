From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Wed, 6 Aug 2014 20:43:23 +0100
Message-ID: <20140806194323.GM17528@sirena.org.uk>
References: <1407183077-23807-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XC5GIdCAi0ueCExh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407183077-23807-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--XC5GIdCAi0ueCExh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 03:11:16PM -0500, Brian Austin wrote:
> This patch adds support for the Cirrus Logic CS35L32 Boosted Amplifier
> I2S output provides monitor data to the SOC/CODEC/DSP for speaker protection/enhancement algorithms

Applied, thanks.

> Changes for v2:
> - Interrupt Status Registers added to regmap volatile

Please word wrap your commit logs and if you're going to include a
changelog place it after the --- so that it gets stripped out by the
tools.

--XC5GIdCAi0ueCExh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4oVYAAoJELSic+t+oim9a5AP/iAIJMTzpmPt/1sndDQcy+Uj
lV0l5OlwPq5fz/1l6ykrCqLUDeCR/nLeMMU+gM6vWaJ1kdsE3rO359k6p93gtQzp
VTKGmod64yAIoveedIWWQtjczVWJasnn6bZCMndw1g9UvYYs51N2JmKmw/2AVMb+
T0UOWoOL5tBxqP+6uge2zWmXhTRUw4ADbY4dogRpVDnDkUan+kxx1HuV7LvKL7K/
2F8P/uGRr5tpvd9AXCow8Yqo8THj6ysU4UXQhgGobjTi5GNl/u1c+em4sBLXH1A9
kvAMDkQyM8D9fXBB0RdzYGpAvMW4Lt8xvIMbsKhIyu3DMu+lHCcSNqoV5FPKmRIN
LMmuyRkF4xMeHFg8+Atf+DSNWhbfj2El5xkhI4b1no7YaURnFE7EGEgAjl5MEVAe
7IoxtWDRwsn5vV3LCwSG0QpYFpG2lu4K659itE89GCMzUIIdJUir3ZcX7ZtkyzIw
uXKP0B8fppPhFN3X1DCNVX+WFhKZNjwvusp986gVR8krq28DEWBsHW4h+V/pM4nm
hMr7Qb8lSKdd+rJqPx9owaWKj8QdEJsd0UEtSS5sl5E0xldJdIn4t9WeFEQAMN0t
w2/v4UMi4GofkCROWcByBgYWWUjJKfqJtxvubXMC1SbvzGUx66ZC9wG2VK13Pcbz
+oApceOmjX3PvpxXd1Ol
=1FIR
-----END PGP SIGNATURE-----

--XC5GIdCAi0ueCExh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
