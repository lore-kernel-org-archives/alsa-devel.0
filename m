From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ASoC: sunxi: Add i2s controller support
Date: Thu, 30 Jun 2016 20:47:36 +0200
Message-ID: <20160630184736.GB5485@lukather>
References: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160615211123.31068-1-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrea Venturi <ennesimamail.av-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gianfranco-25KmuZRQ+wx0ubjbjo6WXg@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 11:11:19PM +0200, Maxime Ripard wrote:
> Hi everyone,
>=20
> This is the second version of the I2S support for the controller found
> in the Allwinner A10 and later SoCs.
>=20
> Playback has been tested with an UDA1380 on an A20-Olinuxino. Capture
> is not implemented yet, but will come eventually.
>=20
> Let me know what you think,
> Maxime

Applied patches 3 and 4

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXdWlIAAoJEBx+YmzsjxAgvD8P/iBqaG8lZ4MoiC7ATOQ7VZmE
OrYHOmEUURs5uq52azAUiN77xVSVdwZ4nRay0iQprLdXXNGVvxEtN1k3UKkwLoFv
118kfHQUZD46Q//O4ss80HKA0nTcEn2jMY3tUnBdrGXzJ03g/UiFNB0jNfxGm8sU
rTg5Mv4fAiZuTGbfKuVrOF1JOpE9SrmzpitSeijfzMDCWxDKoNvjdTBankc6a/Oz
IpXprfm7i93lSCPnnbAKTQqFEDITyRG4vbRdxxWwnI31b6GWcQgleodGIpKRQg3V
y6CaYjYSDoUpml2nrTGyC1yc4zGpC1mpNNrd3410B09BB1Zl8xS0Gp2/LbN7v/pS
Eh2NhhiVq9ycVgLsZ3pE29rlG/wcFgtOUYYVfkT45CI0O308WZgYH630djLL5rJr
fbd4I/XJKr1am+4mW4uRGp+2USPxxEoQp/zy1mT6L1K0VP0+Dna3Gjg1QwiO+4So
pxaY+rrsN1h5huZ6cwkW7GHneBoLie6qecw1J2PNyzhKBUPC8Bg0fBaqJPakb3JF
Q8KsQ3JgxCmzvxqWOIBb8FJF+Csz3Py0eKpm3au0rMEOjpH8rNFduDbmpsAwtban
Q9yRwr0HzRfhOwIQQbXVC3HaMxK3XN4StF2U8QMn6lvS2V1Un42byu72Cut5Y8Gz
cIVvu4IAaMTLiDYSrbe4
=Od3W
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
