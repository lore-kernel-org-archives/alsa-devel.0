From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: Samsung: Fix a trivial typo in
 audss documentation
Date: Thu, 11 Jul 2013 13:59:59 +0100
Message-ID: <20130711125959.GP24508@sirena.org.uk>
References: <1373542328-28428-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7668041578376708401=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C73CC26581A
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 15:00:04 +0200 (CEST)
In-Reply-To: <1373542328-28428-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============7668041578376708401==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HrsILUyxNtiOryfc"
Content-Disposition: inline


--HrsILUyxNtiOryfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 05:02:08PM +0530, Sachin Kamat wrote:
> Fixed a trivial typo.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  .../devicetree/bindings/clock/clk-exynos-audss.txt |    2 +-

This isn't an ASoC patch, it's a patch for the clock subsystem - you
should submit it there.

--HrsILUyxNtiOryfc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3qxGAAoJELSic+t+oim9wmYP/3ljUoOQ5U3mZiYtAPq1MPPJ
o23Ri+031hIZRwvAi6FqRKYKfIQ56ioih80p3cv6FIXGH8cWT8dYgjtf87qextn9
D1jECx1sdaOswbAMGnrymnfoEpflwdbe9volWxF77Ju65UUXH51+GlsnG6/pBnVZ
2W0C/RiOxw2Oc/iZwmHkxkFaEV9iWhy1MCU0jQGva9X5v/hYHyH1zjYiXdn9WQBl
jI7lGdPWC1np+6w6tNVTv6KOfExq4ZPGYBbmdpJvIsahbbup1gu65KDma4oI2DZK
VJaDh62LGUSBEeLzQQiMK8Otx/zVMghsO8//YGRjg6hC0LylGSM8eB2mRCZjc4ib
dN+STGTvKAPdusEAYkBeGP87S9YwrFnl4oy74+NSCezQl8uA3n+bmCchrXayaY5E
moK6H41Q8GRP2/djQPyBFhFJoEKCPcVTicTGxoX+AfEL2YZci2waUr7roiedo6+i
wZYEkgPc6QpDzWzbu+V+6y507KDi/8kGnhcumpNyjsloCdPxbs09sj4RCIUB2eUT
8CmgnRsTvmHk+cv9CE0knZqFs7D4O0TSu2x7cy1QPlMmLy0zd64igbYAJBYF2W1K
etDLh1ps+oiweLYZGFYBXJa1gqKm9dBYgFEAJxWS77V32/x4jk4RBZGhjsNTNc8r
Y1obSxm0Cx4pFPxufo90
=1k4l
-----END PGP SIGNATURE-----

--HrsILUyxNtiOryfc--

--===============7668041578376708401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7668041578376708401==--
