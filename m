From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/2] patches to add support for rockchip rt5640 card
Date: Mon, 22 Feb 2016 20:04:16 +0900
Message-ID: <20160222110416.GC18327@sirena.org.uk>
References: <1456127815-68575-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DLy7ErigvZFpjC4N"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456127815-68575-1-git-send-email-sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--DLy7ErigvZFpjC4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 22, 2016 at 03:56:53PM +0800, Sugar Zhang wrote:

> Sugar Zhang (2):
>   ASoC: rockchip: i2s: add default values for registers
>   ASoC: rt5640: add master clock handling for rt5640

These appear to be commpletly unrelated patches so should each be sent
individually rather than as a series - that way there is no confusion
about them possibly depending on each other and they are easier to
review and apply.

--DLy7ErigvZFpjC4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyusvAAoJECTWi3JdVIfQZhkH/jNZD0jV7sEbj+S5zX225hTs
fnDTx29It6Yyw87P+vtDI+kM/MU8lMbxXJRV85sF+O/atiGwc0yrdKmLekkyRhrI
eEsJQbq11J1nN31aYHMcOeC9oHx1pDSedTkT3z4oJDE0WPADaiPmLlaGJR/u0+Oh
rA94BGqPQ/spz9FZY5rxb2M3lF+VD9eT8gWTES2v8T+k0VYjXvdSyJwbJPG7/SSe
NU3ZIwk3e/AoqjlPWt/ZzbUKnK2C7CHzs5x2FLLsv3iwTrEussk8x6oGXoKoOw65
8PBk/6bbXbhFfdwP9ZKxohbplfVubXZL5ho0G9PK4icp8s3Y7WZRliPUTZCwfG4=
=+0Fx
-----END PGP SIGNATURE-----

--DLy7ErigvZFpjC4N--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
