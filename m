From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ALSA SoC MAX98927 driver - Revision
Date: Wed, 30 Nov 2016 18:15:44 +0000
Message-ID: <20161130181544.lod25su6xu6ozcws@sirena.org.uk>
References: <1479877026-5172-1-git-send-email-RyanS.Lee@maximintegrated.com>
 <1480050167-83444-1-git-send-email-RyanS.Lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ijt4atgsdyjkmzm7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480050167-83444-1-git-send-email-RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org, Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ijt4atgsdyjkmzm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2016 at 02:02:47PM +0900, Ryan Lee wrote:

> Signed-off-by: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/max98927.txt         |   33 +-
>  sound/soc/codecs/max98927.c                        |  839 +++++------
>  sound/soc/codecs/max98927.h                        | 1463 ++++----------------

This is modifying existing code, you need to at least attempt to supply
a description of the changes you are trying to make and most likely send
a series of individual, split out changes.  Please, review the patch
submission process in SubmittingPatches before sending anything further.

--ijt4atgsdyjkmzm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYPxdQAAoJECTWi3JdVIfQxmAH/37fML9TBkAHI4XgnlSFiQNj
xGKKNSABhau/nQmPlxqlAmD7K1OPTgvxZYV3d3KLHtijEG3h1v/Dm0EW3mFjdezL
z6PQNftTvyi+8IWnqmj0avfTjnxsbi/yyDkU4VPU3VFbaqbX8N5loaIWBkXi5ys9
9l/yAggIygaXG/UYiauFp6assMrrpAi3z4rjKNZ7XIuAFN1ss9DS4aID3YzE9dOW
X/rIMD7rGB2OmoB1nHS3c8kX7/I9nDh7KAOFSERF3jtcSsSui7OclnUb49AW2tgQ
cZKVumFWrFA3Y1zRKTHANMW3URvLIDbrCuMrXARficFX+9U+6RE63cFLRVstN/s=
=6C9O
-----END PGP SIGNATURE-----

--ijt4atgsdyjkmzm7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
