From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: mxs: Use
	devm_snd_dmaengine_pcm_register()
Date: Mon, 2 Dec 2013 11:49:49 +0000
Message-ID: <20131202114949.GT27568@sirena.org.uk>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
 <1385625037-24973-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3952155481705763422=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A9C92615EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:50:00 +0100 (CET)
In-Reply-To: <1385625037-24973-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Florian Meier <florian.meier@koalo.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3952155481705763422==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/j2O6PQ6715aG3up"
Content-Disposition: inline


--/j2O6PQ6715aG3up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:50:37AM +0100, Lars-Peter Clausen wrote:
> Makes the code shorter.

Applied, thanks.

--/j2O6PQ6715aG3up
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHPaAAoJELSic+t+oim9cQcP/RzX8WcV5LrO4S+CcVJtwL3L
7SYQF4t5wQjUDadhCT1GKgFaXEIY0MTV0iAaf/SLjdm3rhfHRzYXR78SrzaFAFCA
SvCrh0c1fgseWlHmIHFvCs4bTp9im0V9iFnNI2m8pSU5j5HK8VGpyKDMsSraHJMI
GIYSm3dHuYtTJdDcvf2dX+T3D5WgpeJkZ01A+OlbJASGU/XtD4ahjQe4R/jwzfQ2
hGrykLnsmwqBJU0WchJfCcIr6eUtkmSeAE2fr9qPrbwdIZiW6T+d/jpa+uus3oA9
oLalevCsR/bL/BbnZg90YCIP6B6rMNd3CkTYNh2QbEkbsZf8jMK2rEl8Fd8SnW7K
APO/b/THA34o9b3HlN1vzPYrWxKbCqUmSmuCX1zoNlPsm++UCr1p9tYg+2jDhPZY
80oA6FFwtcMGDE+SQmLy/vvmcbHa1B1lY7rptpdUqX3WnqHCm3K9pN937C6npyP6
yehRluqxaI/dg2hLJx93gausZwpfA63MpCaxtBRVI0l39Ir5iBZFexVXjBJwkgM2
C0hJUk1SSXIauxF+2ih3OhxAnCzs8PR7WlLgs3W1WoHurHSP7ctnfVZrPdaC5xPu
U+Vem8HaxX1JRWKcLuVF+uqG3xHqwphArzFFjRUS/Mz9p7zvUR5BJM2/ErIxzO1C
0AjSGqtWuBV0acnFvivl
=bRES
-----END PGP SIGNATURE-----

--/j2O6PQ6715aG3up--

--===============3952155481705763422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3952155481705763422==--
