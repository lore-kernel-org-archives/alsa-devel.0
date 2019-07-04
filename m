From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wcd9335: remove multiple defines.
Date: Thu, 4 Jul 2019 17:39:32 +0100
Message-ID: <20190704163932.GA16332@sirena.org.uk>
References: <20190703123257.27228-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9159541829335569623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88545F800E7
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 18:39:34 +0200 (CEST)
In-Reply-To: <20190703123257.27228-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9159541829335569623==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2019 at 01:32:57PM +0100, Srinivas Kandagatla wrote:
> Found during review that there are multiple defines of same constants.
> This patch removes them!

This doesn't apply against current code, please check and resend.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0eK8MACgkQJNaLcl1U
h9CfVwf/XYySTd1B7uZk1uM6lEcovI+6DiXX6JjOeCWv4gEy3QewgbG4Tr39a5OJ
b7swR0mvF3vq6gNJMuWNdIE2cpZZs4wQSyugLhglSTUWoBd9/COmAWkcqn6FGb6w
Uo2WfgquqrBfVPE4OpZV0XypXJIoAnBXo5HV4M+hMHeyFzIOp2xz46+mQPfBzpXY
Jtg4u1jCoQW4/ZZGPk81S18ykawYsFN7QUuOuvHrUVkvQR2iRaDXG6WtiRNbMe4l
psUlBmLqvyPWku4cEc9Jsw46dbyA5MZo46TyTCm+TKcR2t22h4HsvilQ/AUbeM7O
E1KgeiU22xz9XmPfDhTT897wRAnCdA==
=Xpoj
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

--===============9159541829335569623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9159541829335569623==--
