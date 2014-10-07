From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5677: Include gpio driver header
Date: Tue, 7 Oct 2014 20:36:56 +0100
Message-ID: <20141007193656.GH4609@sirena.org.uk>
References: <1412372246-10489-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="213B/23bCmw+8GSd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412372246-10489-1-git-send-email-benzh@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--213B/23bCmw+8GSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 02:37:24PM -0700, Ben Zhang wrote:
> The header file is needed because struct gpio_chip is
> placed in struct rt5677_priv.

Applied, thanks.

--213B/23bCmw+8GSd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNEDXAAoJECTWi3JdVIfQ6dYH/jXvxYPxAx6ZVQIA9aR5/g/Y
A8LuwelO9gzn74pTii6eFMZ81SgsWe+GPtma5LWXzHEBCpOd4JGZWTqTG4RdPjyf
SdGEdioS20MqMKGLdSZ+/UMVOGt95KpoxkxaBK8vwrQWk/Veyc1aGKzG+adWbf4V
VHC6o8EY0AnI+/bqtx++VVZnvtV+9QPWSZf7DjuW/D0ji6N/llY5qbnFm3AUsAcB
DZIElp0VZ39hn6+0ALhqTPJDJkxExN1m328Lw/eZRYWrEKAWYSh3inwKg4pnNZqw
c372yG4mxky2r1o3Z1TjMzNlCNpya+FK8vETtbtIIuQUBieY8Jta4DIadmfrsOw=
=uuD2
-----END PGP SIGNATURE-----

--213B/23bCmw+8GSd--
