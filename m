From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: mfld: Use
	devm_snd_soc_register_card
Date: Thu, 19 Sep 2013 14:57:56 +0100
Message-ID: <20130919135756.GV21013@sirena.org.uk>
References: <1379391544-6262-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0429243574216690523=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BFF6526545F
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 15:58:05 +0200 (CEST)
In-Reply-To: <1379391544-6262-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0429243574216690523==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CwrkNGGfsJuCXYE3"
Content-Disposition: inline


--CwrkNGGfsJuCXYE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 09:49:04AM +0530, Sachin Kamat wrote:
> devm_snd_soc_register_card makes code simpler.

Applied, thanks.

--CwrkNGGfsJuCXYE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOwLgAAoJELSic+t+oim95cQP/0SBTWFvvBKWTbl5usNTZvMH
JuMLzn9Ez7wdIUSIkPJvQpQKfD8LFlQKRNhV/SuE+wOzUfvdODc8dgWcDQfI0XFA
ihRa3XaFd1lg6BC2lvALZ6eS78Qf4mkQvcpF4wH0lPg9YAzMbeWkvyxAZ9ejFihM
zxWf3ObctWSUPEjrTQzcOnWJSzsq1uroWQ6UYWYxc9qYNI8Pm4DyMoNIn+lJBOF0
A1xOJrwtNeT7wkelwX20XfUwaJzFtsp4Da+ZXuCI76jnF277c6lKTMzT5e3t8OIH
k/o73dg1jUHD8ly0cA6WDEElCcLYJR+P4bLXNeuIB0lOaGaPAcJG6qKds0HTBtHM
hV3NDGmj74OeWe9hRzeZ0Cl6YBkD+6Fr3o/nONo5NxBVvFoILtoJj5+QLwDnqvOX
bIUL9ICx4q3I4jIMEROJFIGKDc3VBhcFTVgf0g41Y9ROgc+luHGM3b92liCymANJ
7XogdbmNLKeSCcCwy85RFzX5Raw8V+XCZDXZ0DWvTmQhzukACnuO6R0GrKXKl3Te
wfPSXOlqTbNAnExwIlKDotbCKVBfMmdAPAR1zZhpnD/2H5l2peujdd+/Y12M0XOR
nPnIVcUPk8uWNE7yXOSq2ts4aeq1Er0iakzRQn2xghlxY7vQEt0MhOOcUqH/QWxg
/CuzkcCvYCwAYnfS7dFN
=gdbA
-----END PGP SIGNATURE-----

--CwrkNGGfsJuCXYE3--

--===============0429243574216690523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0429243574216690523==--
