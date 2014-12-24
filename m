From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ASoC: rockchip: i2s: fix watermark to 16 and
 maxburst to 4
Date: Wed, 24 Dec 2014 12:43:51 +0000
Message-ID: <20141224124351.GA17800@sirena.org.uk>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
 <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cyl6hb1YSGs8e3xM"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419413822-11539-1-git-send-email-jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--cyl6hb1YSGs8e3xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2014 at 05:36:59PM +0800, Jianqun Xu wrote:
> To make Bus DMA works more efficiency, DMA may work in burst mode,
>    we set the watermark of transmit and receive reach to 16 bits.

Applied all, thanks.

--cyl6hb1YSGs8e3xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmrUGAAoJECTWi3JdVIfQtnUH/jlUIaFclxbl8kbSp3+66qUd
tZmX+3g/aZl5X0D+LrfEzi2AbpZkA39YO+8E9qUT2lITmRQ+ubq0NLcLp5DyTZqu
Hy4hsYkky+Rf3hCEZUfNteusKJAYZx46cebpYZTQh88CRv5OU/OfGNjyk8f8IVJr
EsDzXMcSOTxGWrjPgoPLctkRzOqLq1p0WHEGcB6xTSIYmQ7IWAf8TinGL97RXEYw
1SHb+i8L0RaWsrHSA35NxKk0wqCoV52QxCwUII7VIsRdtBC+PGEnufOvgrjtWNkP
1MjbSd2NguOMu/XSuFtb1u7MXVyGkirmE82mzHNOtp3SmHiED4MjLQR169+L5u4=
=9RR4
-----END PGP SIGNATURE-----

--cyl6hb1YSGs8e3xM--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
