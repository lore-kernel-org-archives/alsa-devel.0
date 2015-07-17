From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rockchip: Add machine driver for rt5645/rt5650
 codec
Date: Fri, 17 Jul 2015 19:11:22 +0100
Message-ID: <20150717181122.GT11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-3-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2l28wc1uYKejhFF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436930143-31361-3-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--s2l28wc1uYKejhFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2015 at 11:15:43AM +0800, Xing Zheng wrote:
> From: zhengxing <zhengxing@rock-chips.com>
>=20
> The driver is used for rockchip board using a rt5645/rt5650.

Same comments here, mostly good but some minor issues.  The other thing
with both of these is that you need to have a binding document for them.

--s2l28wc1uYKejhFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqUVJAAoJECTWi3JdVIfQmToH/R5aRbWmamydxxUNcX3uSyFK
HHtkh+slbdVAA3dbMEFzHyxa4yoc2GcRpqQPgUyGWJZG3eFvb79czvcCoDd2zZdc
oKi0pxmXu8l+mEVXLR5alACcKPP5cck2Lmf3zQHQ99QGQl5n5d+0UQlJQRI1SBmX
Uyqj4y4uQnC/feGx61z5dLDdARsG/vva3m/EhMY5Oqk0iksLxISfkXRkh5JYMpvd
7RuYimg5uGpPj/oR99o3YueJXtJb4HhflaZoel5U7rXw00xiowW089Pk/zYYew+8
FCGAjEknqnx5pfKwDUxo5FJL4ZJwTGsdT477yZb7iSS8w+h0iEBAPOBvjXGWaVE=
=NuOw
-----END PGP SIGNATURE-----

--s2l28wc1uYKejhFF--
