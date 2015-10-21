From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop unneeded properties rockchip
 i2s/spdif bindings
Date: Wed, 21 Oct 2015 13:28:43 +0100
Message-ID: <20151021122843.GD8232@sirena.org.uk>
References: <1445242539-9098-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445242539-9098-1-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 10:15:39AM +0200, Sjoerd Simons wrote:
> Neither the rockchip i2s nor the rockchip spdif binding support child
> devices so #address-cells and #size-cells properties aren't required.
> Remove these from the bindings.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

Please use subject lines matching the style for the subsystem!

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJ4T6AAoJECTWi3JdVIfQDH8H/j6i6DoQFVBR8WxRo8MLyzge
shApzhJKDtc4fBb5laviTf2F1oDX3347A1Yynn2GLVEjQnL0s5Jty12Swv2fGStZ
Yr5nssU4Ck27ko9QJClUM8KKF+KZvyZxwljvLSr2guyd10S78M1QUNmfhCZ/h6cM
HOvlJEdumd24nEjwqxB9Jff8yFQhN2MGjtWoAzHy9ux+Hpfz/kxg/R8u5A0WGp7N
o3q8PV20J0aCk3hardponMm6aZ5Yn+BubEpK0fMHRmakzCuKfiMCV7KYv9Edrm2Q
HchiFkgQdpMtkqKzhYrKnVmrxv80y1lHc+fh1nuQ95qr4Rst/DzsUOQhJQpDwWw=
=mXbM
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
