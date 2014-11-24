From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rockchip: i2s: Fix Kconfig for I2S device driver
Date: Mon, 24 Nov 2014 19:01:28 +0000
Message-ID: <20141124190128.GI7712@sirena.org.uk>
References: <20141121185856.GJ3815@sirena.org.uk>
 <1416599446-32310-1-git-send-email-rupran@einserver.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YszDAcSgCu6rDIlP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416599446-32310-1-git-send-email-rupran@einserver.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Ruprecht <rupran@einserver.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--YszDAcSgCu6rDIlP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2014 at 08:50:46PM +0100, Andreas Ruprecht wrote:
> Currently, CONFIG_SND_SOC_ROCKCHIP_I2S could also be selected
> without having CONFIG_SND_SOC_ROCKCHIP enabled.

Applied, thanks.

--YszDAcSgCu6rDIlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc4CHAAoJECTWi3JdVIfQPgsH/2nfn7uCaKD1s2yDlNg46fYb
U+fcxES2gJITRmXlEXx2Gvl2kem9x6Lrh0H0XNLsSseBnL/3iSEqPQHdzn7gA7W9
uKH2cXyWtP+dzEoSQuRixIcyw79GNW0ZkRuwYZ3mTaoFHxqZHHoAbw9st2JngM0G
+2dLi0TSZCJBhicznnPV6S9vEJIRiZK8Vu9aoFAnR3FxR9vKVwhgU1MPpGUFcGHC
3uf6m26Mre74UPh70gQ1xBbMcHOYt8Un7kNmIq69dnYlw2Oue8Yqee27CBLaDBED
eroSPau7m6p2nnFxF5pdi9MoXR57H9veqtFmSx/2rT1FixvFa4kq2ktmP64b8Jo=
=vInt
-----END PGP SIGNATURE-----

--YszDAcSgCu6rDIlP--
