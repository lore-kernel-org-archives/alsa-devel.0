From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: fsl: Use
	devm_snd_dmaengine_pcm_register()
Date: Mon, 2 Dec 2013 11:49:10 +0000
Message-ID: <20131202114910.GS27568@sirena.org.uk>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
 <1385625037-24973-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3764577545595539798=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A58C2261A10
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:49:35 +0100 (CET)
In-Reply-To: <1385625037-24973-4-git-send-email-lars@metafoo.de>
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


--===============3764577545595539798==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NSZC26AJDpFITwK"
Content-Disposition: inline


--2NSZC26AJDpFITwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:50:35AM +0100, Lars-Peter Clausen wrote:
> Makes the code shorter.

Applied, thanks.

--2NSZC26AJDpFITwK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHOzAAoJELSic+t+oim9IjgP/3v0ZjjFQauaI38lRcpXZ5mg
2lE/MEomZPRyiOKkh8FjQstniP4O/9vB2UNImJj4xSvQU8i8h3ZHXg1INH/bsO6F
JEZsC+NNIBMpSJIne3GItcIA6x1dpLBncLYE2K9mF8PFLoIxbz0fmMUg0RuM2kbK
+rMj4TYzDdQWGvknJjA7qLp7tBFbABmwArC8sMxC/GoVN8FQDSn6fv3oVeAKbqSE
lBeZ/oM4HMxdAnygTSUe67g90VBacBdthbXWuviKY4g9x5qXiT4az6lOfZO3qFeX
qjdJWrfAXEQKRff6wWDWleL3M3fb98/Jzj9jSRbgz3ihDKKiZLpYm/Qw34EImthg
P41oqsaj390fKyhezXiYehbp8MZA7xmAkp/0ZXCCiOb1+3OcxWABHI9E0WoBW0wd
GkosmTe1L2ZfmogMFjeIylAcSfMfdXgwrRScQdtyA6cW8vL4InGwcaXnHGgh9BHt
BdMRq1nBvP2i+22pnsh82iUzFYVSqbi7LtoTJMjx9H7ExoNfaiBU+WIgiBOc8aWM
0wofHHjHd1wF55ZILyJ9JBCtNGPX49Vik7e3/XDhJ2eyaHPffxGyamEqkQiUjbbi
FDMEn5EukNyFA0uS94TRaVjZlKwT1+CgnR5lUJEqCdVQbusoJhiQ4lt0BmB8LWmY
cWRIo4BA5lMqijh4Q8YQ
=hUbu
-----END PGP SIGNATURE-----

--2NSZC26AJDpFITwK--

--===============3764577545595539798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3764577545595539798==--
