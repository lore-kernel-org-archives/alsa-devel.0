From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [RFC-PATCH 0/2] ASoC: simple_card: support for
 hw-params rules
Date: Mon, 23 May 2016 17:59:31 +0100
Message-ID: <20160523165931.GY8206@sirena.org.uk>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
 <573F6279.8040008@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ELMKpCVvjiB+uwRu"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <573F6279.8040008-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ELMKpCVvjiB+uwRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 20, 2016 at 09:16:09PM +0200, Lars-Peter Clausen wrote:

> How about allowing to embed eBPF bytecode in the DT that can be installed as
> a constraint set? This would allow maximum for flexibility and also make the
> implementation a lot easier.

That seems somewhat Linux specific, I'd like to see some DT maintainer
buy in on that one as well as Takashi's thoughts.

--ELMKpCVvjiB+uwRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQzbyAAoJECTWi3JdVIfQs88H/3IgsBaXk7YLTH2r/SkMnmVO
9Fs9+x0HMcyGkL0RRVJUOqI4sISa1d7cnmGvzgv0CnONGST/7I8tfQSVGZ6JKrMK
CACCMxw9QfyGzpCD/3w+xtsxnkNr4cEvGCmHeA2JdxEIShIlACVcym5e4uH+Sh9t
ApTvXuuihoqmmJG+qovkuW8wJBDJNnnegjUP5r2V47xd3n5t4lBOcK0Br3XCYsru
SMAIYxdaGwUI3qRVNhd8e3l2dq4m1ko9aUGdiw/8J83gZu5QqdWh6yjdIm3AHKMt
er3mfVDfOq7ywqePYMVSjKMfUYRFenhTicctcmlmIFvjkWvcEkJ7IDbTUuaRFGY=
=NCt9
-----END PGP SIGNATURE-----

--ELMKpCVvjiB+uwRu--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
