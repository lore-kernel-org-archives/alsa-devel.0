From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SPEAr spdif_{in,
 out}: fix fallout of previous cleanup
Date: Thu, 13 Jun 2013 10:26:06 +0100
Message-ID: <20130613092606.GU1403@sirena.org.uk>
References: <51B898DA.8020301@metafoo.de>
 <1371068281-7974-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9036505864711628005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EFDD3261A3D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 11:26:18 +0200 (CEST)
In-Reply-To: <1371068281-7974-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Vipin Kumar <vipin.kumar@st.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============9036505864711628005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="00zH/wdDQmWzr4bS"
Content-Disposition: inline


--00zH/wdDQmWzr4bS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 10:18:01PM +0200, Uwe Kleine-K=F6nig wrote:
> The patch that resulted in
>=20
> 	bfcc74e (ASoC: SPEAr spdif_{in,out}: use devm for clk and a few
> more cleanups)

Applied, thanks.

--00zH/wdDQmWzr4bS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuZArAAoJELSic+t+oim9XtcP/0jqpr9xLaXcTcbJA4L8iHZ/
UcMV0ZhFzr5Z3RRxw7q8Ga4V8C5TNVrebq9UjtW0jor8zRNXDnYaudYGnH3MGfIY
gNwvE+xKvQvKKe1JYfFbQDbUZbiP/ddwVbIJfI226oDxvzMeAZUkv4r8Sz+fYoo8
dP7ZdEQHzztOHFEMt3zKPUUHoPNA0kiYKz+YI8UXYL+1kM4l/JuHXLpEWZdi7ptB
uRfgBhQ+dQws8pDd8HwKUJbple45IxfoSVL/kp3e7EdOLCUY9jQizNRizc1bPhZe
xp3F6OC9leyP+tgSnSFJgpn4d882iN0RIHfheuRm1n7CXkipPRPcgO4tLmDcbX7S
Hnw2MVr0vUubJ+aoRlt2BR7sG3pCleF72BXqi4H8NixlqMWcwWqHSJ0pyyWkewOT
HEXInjVgUMXtMJuPs3cGqR1wbA4UIlNNCUKEM1owSCWIsqrmizB63agndX/wxe97
tk4Lzs9TLxcFsvVujzSWawUgCsHwbaQCJbgBLgGEGm69sD57/rsGkUNf8dhNU6fx
FqZHohUW5kvHWa7Dw5PgZxehp2HIiIxZjSAE2i2pgGu0Of1DXrncQlY/CCKB/NbG
0x5osA53cP1sBf5+79mgv6aNjw+MiJkBtmCshhBbq/G4pH5FZPSD6EeMJsdfaC2L
dHjM0eULeXrcmBgMXvP9
=YaQK
-----END PGP SIGNATURE-----

--00zH/wdDQmWzr4bS--

--===============9036505864711628005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9036505864711628005==--
