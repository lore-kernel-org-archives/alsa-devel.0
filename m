From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: pxa: Remove duplicate inclusion
	of dmaengine.h
Date: Thu, 22 Aug 2013 10:44:08 +0100
Message-ID: <20130822094408.GM26118@sirena.org.uk>
References: <1377158415-469-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2000549497818987221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 510A826538B
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 11:44:11 +0200 (CEST)
In-Reply-To: <1377158415-469-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, leoy@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============2000549497818987221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fpolVoprVozDR81Y"
Content-Disposition: inline


--fpolVoprVozDR81Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2013 at 01:30:15PM +0530, Sachin Kamat wrote:
> dmaengine.h header file was included twice.

Applied, thanks.

--fpolVoprVozDR81Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFd1kAAoJELSic+t+oim9SvcP/1eUr5xmQ5QytRXeg+/C3CYK
qLtzrsszpZAPZ6LSiEi2TffyFjAOja6APfCKcZ133RzJIUhsw+8U5Uno1QmR9jlA
vNr/ecsbP5B7f6IDK2u+4SYoZlSUHlA8Bj7459Y+5t40yzwgDyS7KrmxPSwf5IIk
fHeBI4dY2yD1a6TL3VPPfZlFgOL6+I8tdHuTgHjZpqM8vPnqOnvKurHc9Ne6d9iK
Doi61AqSmky4sYLvhzaaDRBXxg8bhghrE5FAL0lLrg7DLWEVwQWsHGxmWNkTLBwY
jmRsQ2pcE2NcVxxfLGhbfYOGPrFjwNuEyd+omj9v71o8YUHnAMrNOqoWRpynoBhy
jITskBK8OMwrKLbjA4JGEu+Cr4Si7BM+QJDPGoZfDOqlxvBtKSfUGKr45/x/W5n+
5JqPrQr8Yzmts4QTJl1O0b3ODm2cKW6sX9KLUnrSyvEBfIsNbGMhD7ivjxb5miM/
nR4GMacow1E+HNR6xVxinINNrXPq+LLfY06Td/fDMFNDgvipWNO/g1tYUaneGY2V
kJ1p6tUiJr9O05ug/btjJT7oL9I7mfJ5XgWbic9Sxo73Qke6WQuokFR0lBoORInG
3Ctj7WjNMBPfOUGAUtTCtzmkIAxDD8otW8xmUyrHZOLZN+Yf18mZRoA7VDIE1D8z
GttjMjtBXmRwuJ3EmkRX
=EujC
-----END PGP SIGNATURE-----

--fpolVoprVozDR81Y--

--===============2000549497818987221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2000549497818987221==--
