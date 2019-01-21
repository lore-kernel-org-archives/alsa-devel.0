From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] ASoC: cros_ec_codec: Add codec driver for Cros EC
Date: Mon, 21 Jan 2019 17:54:01 +0000
Message-ID: <20190121175401.GE12679@sirena.org.uk>
References: <20190119113332.249720-1-cychiang@chromium.org>
 <20190119113332.249720-2-cychiang@chromium.org>
 <CAFv8NwKctsH5cKUQxgfQNg3V2Y=-o5LFZC0b+jwLC=_nNumbig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFv8NwKctsH5cKUQxgfQNg3V2Y=-o5LFZC0b+jwLC=_nNumbig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 19, 2019 at 07:39:19PM +0800, Cheng-yi Chiang wrote:
> Hi Mark,
>=20
> Sorry, I forgot to mention that the patch for EC command definition
> has been already merged in upstream, but not in Mark's for-next tree
> yet.
>=20
> c1f3375be60c mfd: cros_ec: Add commands to control codec
>=20
> This is needed.

Right, I can't really apply these without that in my tree.  Lee did say
he might send a signed tag for it but I don't think he did that yet.  :(

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGBzkACgkQJNaLcl1U
h9BkBQf8CJRuj7HS3nyjj55S+Kz9PWSkYvzubXXVTxF0oWuL1mqOR08qLOjFnfYz
A0SltdTdhiQqhR1UJ/1K3ToRkUn6brv2mPVpR57tibkzuj6D4x84AxUMb5CnDt8E
j7la7Xir1epVNF+gh5OVMJJAeBUsnDgiyewmUUWYQBxiQbsHxVr5fn8dX8M0uzP8
nvXiGwaIUn/bOVwDJ0tp2iGZzOVHRbi2Z9eOsUDpnqrCJsdOOOWaTQOnCWTt3XJM
1yQp56Z2pPnn3vSpWPDjGLT7RKFBxEm9YnHUyiDZihGrUhRx1QKFVwmcunuNXBjD
KntIAJgPDDirprGX2YVvYdCkj1Hu/Q==
=aWoR
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
