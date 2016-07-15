From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] Qualcomm IPQ4019 Audio driver addition
Date: Fri, 15 Jul 2016 13:56:43 +0100
Message-ID: <20160715125643.GK30372@sirena.org.uk>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1468566426-19598-1-git-send-email-njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-A+ZNKFmMK5xy9aJCnZT0Uw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, twp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pradeepb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, snlakshm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, bselvara-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2016 at 12:37:02PM +0530, njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote:
> From: Jaiganesh Narayanan <njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>=20
> These patches add the support for Qualcomm IPQ4019 ASoC
> with the ALSA based audio drivers. The patches are broken
>=20
> 1. Device Tree support
> 2. Audio clock driver support
> 3. TLMM / Pinctrl support
> 4. ALSA based audio drivers

You need to completely rework how you're posting this so it can be
reviewed, probably splitting it into separate patch serieses - please
see SubmittingPatches for an overview of what people are expecting, and
as I said in reply to one of the patches looking at git can also be
helpful.  I'd suggest sending the drivers for each subsystem as a
separate patch series, there will be some interdependency in terms of
getting things running but not in terms of getting the patches applied.

--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXiN2LAAoJECTWi3JdVIfQ3JIH/37/lIH1kHbO9kE/nWm3km1l
nvCEq8vPeuzcb09Q7knbhU16bcLq2UMmCwsjWBON+RGdr6QI+JNVIEt2Perk3KZF
cxZb3ULPRxMOetxrVfngyhTWWmiyvHEqXpV2zqUTU7ed4B3KvITPvIh4AOqUIhYT
HDURwkORAzl6VFVtmQ7NlqvODlEWIMTZJBzmO/3acavW5GQ55W93G/AR8zCYSWQZ
62khTWrCG4Hz/KBq/ROYMv22Tk+o9Tv2V1V+q9SjMWrWBFlbHKr8p0eVrAqG3M1q
1HxJnwHfrYu1ktJfQc75PIHgwtVP7wqDjpE4vcp528TfeNj8Z0Q+y5MiYCbo+HA=
=kxnM
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
