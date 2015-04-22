From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: arizona: add defines for single-input gain
 control
Date: Wed, 22 Apr 2015 12:05:22 +0100
Message-ID: <20150422110522.GT22845@sirena.org.uk>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1429619636-25478-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k8r0khnpBuGu0wUi"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429619636-25478-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--k8r0khnpBuGu0wUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 01:33:50PM +0100, Richard Fitzgerald wrote:
> Adds convenience defines for declaring a gain control that
> has an input mux. These block are functionally equivalent to
> the existing mixer blocks but only have a single input.

...can only have a single input active at once.

Acked-by: Mark Brown <broonie@kernel.org>

--k8r0khnpBuGu0wUi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN4BxAAoJECTWi3JdVIfQ4jUH/ibPLw0K0Wfshl8CwE4B0fXl
TknXldYJ3asYqhKKNPEzFnlKCVGQ3mFD25GCqv9iaPDI/lUbcG7/yZ8yMtOYPuzf
VKJjc+xjSnwpTustywpa2hIYmSmTf+NGoadARCuGp8cQCIaQCB5U0HzTtr57yeOe
CSnvtpY35H0pGyfnSlLRGWnGDQl/trVyme1Fa8zxzwVAcsM3HnOFjOLmAbwcKK/7
5vQtQq7hYDnmwx7njYghcXW3LgUKbUznTG+I/lEbQh0aLlk0d0nyWD+UzMbIZdpF
g4F5RCHjx3iFMjqh+yn4nGx5XWAwSaGfJK0TVfuf4PzGbpLbgfJqBZNLizIj5qQ=
=Dujh
-----END PGP SIGNATURE-----

--k8r0khnpBuGu0wUi--
