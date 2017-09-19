From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] ASoC: rockchip: Init dapm routes
 dynamically
Date: Tue, 19 Sep 2017 13:28:03 +0100
Message-ID: <20170919122803.kybaln43yho3deih@sirena.co.uk>
References: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
 <20170918111801.12881-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6j2a6xw74ahxd2du"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170918111801.12881-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--6j2a6xw74ahxd2du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 07:18:01PM +0800, Jeffy Chen wrote:
> Currently we are using a fixed list of dapm routes.
>=20
> Init dapm routes dynamically when parsing dailinks, since we are
> supporting optional codecs.

This doesn't apply against current code, please check and resend.

--6j2a6xw74ahxd2du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnBDVIACgkQJNaLcl1U
h9DMHwf/eGQIUDxDdNDi58Ae9/sfoe6JUjlK4SHSTA1OjtHpXJrwko80fjkwCLDl
WG9IcXYpEAtxNn9cyGmshk+nUZuB7hATeAt0UbjSP+bWtTeOQ0pYJkthpsPuhiuG
Rh1/M/wgvxTvqZcpz7Ys8xy0DCmoBIp573aD8U488PSZ9x/8MZUZKnL+XmuQss4m
kwsmhYkDSVAWkuE2JHRnYRWkAEOrmi1euPeEiJN99MhhciiitQYy92FvxKIqtItP
UR76o2Whaia8zhv2cQBfWcxXBTrj03PGVxfr9bsntPXp+s0sHz91ub5uJ3qKDO6N
SPRyxyxHoVMKt3wVgHNh3VQ8vGnOug==
=A8FV
-----END PGP SIGNATURE-----

--6j2a6xw74ahxd2du--
