From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: mxs-sgtl5000: Remove unneeded
	'ret' variable
Date: Mon, 6 May 2013 12:43:58 +0100
Message-ID: <20130506114358.GB4945@sirena.org.uk>
References: <1366820595-19762-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773643077617451104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 71308260794
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 13:44:14 +0200 (CEST)
In-Reply-To: <1366820595-19762-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0773643077617451104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kf9dPzkPP9+q7vtQ"
Content-Disposition: inline


--Kf9dPzkPP9+q7vtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 01:23:14PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Variable 'ret' is not needed here, so just remove it.

Applied both, thanks.

--Kf9dPzkPP9+q7vtQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRh5d7AAoJELSic+t+oim9M44QAIlHx6FNP7T54tdZoSNYeZA7
znpUNZB6OdAEs3LLIrPQcGSO1xnX6/YYLMocOIqYKIN6evfiNrXiYh893IDqT+YO
/kKyjATm32jsJpPhwOnfUEn5bO3LQHtRBVNh/Cw6cl/EHCeGeO6QHu5qOP/pK0EQ
L8ZRwDXicOnmwKCvSt0BT9VcqVkzYFDbRqO2VgCg/6m5KbkooI7duJ6SM/DA3Pw3
rhfkyxNRXy3SYWZBYIMJZJqOutpk9Yg6YVfHKY5/vh1GjjjfvJc6ZEm5gJ//vsZI
zVQNRexWDRoidPQbobZ78XZwRorEC7t7u0Da2ECGTU2fMmY7vhQTBLIjry7Edpyx
BIGMGMjhLY1gn2LvyqjtpERX5FI701lQVnGEFmFZ7ZZbq3wc3KgDCbEKhQEd/F80
K2UfKuiS2jDk3nAscx45VDR/YNCD28Eua5Swmr1dLlya45R5uWl8fMnd4xhkvaXo
6FwJ+XLofM7KkdBa6UvIsR+zoBFS/trB+/skO6V6StJB+fayv1o5PGUcVBnPI4/T
5KVwnWXY696UQUmP6uF0mWtK7Dcg7eEEhvqi97mjdAwT75+sOtrTowGX8ctXrOGc
VknJcoB7nxaGSh7cXAxb0rt3QpFePYhoNSqL4dykmLGjBaWQykLPP3zOcUKfxrPU
xwMS4NkuOeFo+5eDW8Mw
=jHJe
-----END PGP SIGNATURE-----

--Kf9dPzkPP9+q7vtQ--

--===============0773643077617451104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0773643077617451104==--
