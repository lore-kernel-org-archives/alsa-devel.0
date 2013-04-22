From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC: mxs: Use generic dmaengine PCM
Date: Mon, 22 Apr 2013 11:29:09 +0100
Message-ID: <20130422102909.GG30351@opensource.wolfsonmicro.com>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8788512988288595824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24D2026160C
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 12:29:11 +0200 (CEST)
In-Reply-To: <1366478947-9377-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8788512988288595824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:03PM +0200, Lars-Peter Clausen wrote:
> Use the generic dmaengine PCM driver instead of a custom implementation.

Applied, thanks.

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdRDtAAoJELSic+t+oim9oPAP/A3mKu7w7Y9eq2I68Eu4loFt
ZTp74aKOfMn+LerhcqiuqF6ONLAN83QCErROgNEQ0uHrMuvZwA7F5pCV+YXFu9F4
PR9mOAevg/yucb+S2tGdHOlGs694wIg/ERGdyv1FGTOuVWaI4g14ZmSmbrldl1Xp
W506ROewjUnALy/Mo7qoIk8A0wvWgarE/PT87y2D1TN6V6hewvTO44/PLC96fmbt
434q8azYmCo9LftDPElOLiqzXqBn3gg+wd6WIeFhybDpAE/EpVmtXUSff7p5leGM
M+uMyQyY9J1sywFf6bF8UKruT8/LhweTmRvNoC7pR4EoKTMQzlKtnq/VvQPEwFb+
DpiBj2WtwwJFBKSeb5thNhf9W0xbWVZ6xwWXK7YR+2UpLUexupi9pk9XZdTQzNLT
vCEDPRjc8h04hGB9TJDL8js2XDOwy++avfKF7/F1SVdA0W+0vDZ4kY1rbDYbSbQ8
CMx7c/+jYpYIIuMfMwea1yEFzr0lR8I4OE5N1CHd+pL6pJvCFo4EJtJkn83zeC68
RqQw322/FeDd7lSPVaTfCNL/ndRr66DrWFxQ5S7t7ThzDBrkyb2ueaqi7dNms7Lr
YwSTEhfB7eZExACUeHXKQbgtyGOop/GSwW6rLYTQmiJvsJlWpOWHjj+/oL5qwPLs
kzkpamwoPVL82I8mzUUX
=GjZi
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--

--===============8788512988288595824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8788512988288595824==--
