From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: fsl-ssi: Move ac97 specific
 setup to seperate function
Date: Thu, 21 Nov 2013 14:24:01 +0000
Message-ID: <20131121142401.GV2674@sirena.org.uk>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8513227806232390021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CD0260307
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:24:04 +0100 (CET)
In-Reply-To: <1384938262-20554-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8513227806232390021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="71MxWb38FuvvANV0"
Content-Disposition: inline


--71MxWb38FuvvANV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 10:04:15AM +0100, Markus Pargmann wrote:
> This is a pure cleanup patch to increase code readability.

Applied, thanks.

--71MxWb38FuvvANV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjhd+AAoJELSic+t+oim9KQgQAJmSjXy7HisxtLSQNnc5Wz9q
QRF4lR+gSQBztv/DrEOGZJpcRY6XR0+P9dkSm6PfohaiYFV9HSn90CHYfQfJD8fe
HuXrF2yiFtZqa+UNYpurjKRoD5NCeLo60e5v35RRw8wOFZ5nedXF1ReTmggkJPiD
Djc0KMq6OLOGnPhagThXNMfnOxbdbRKFbe4GCr+epw5DPIoWq888E5G3e+uFwvu8
TM+997sy+loUbDuMjVwTiRmdEASAPtOu/bEySuRFsnTy5aPExeu/S6KieB8Gok9g
kpGgaNWgx07Q/+scOeUi4s4Z/0l2Cr04TfpPQ6ptpm1XXmktVDYKrPUrqQj6Keq9
DGeipNdNWQfUKZ87PZlR8awMOvS/nxP/HbwvSSNrWC6dtEgJwIwuzWCLDsewzcds
IkVNCM++YngAiy1C0qAeIDYia/StGGueB5hDnBdFKxCgjWUE7ggb0wAadWPg6emj
h20Okzi7HR8HiRhEG/tXS5j6ohGRZQDYXelr5oWY6Q8zDKLMCrHRCueILZS9Kjne
PwVxIaZqfQlVj7jfi0yCK3HIF+QXAWceCuYbk8FSRDSQgsbA1UgNu3GnxiXmuTsW
pCfRLkEHp9vj49989LbOeDSB68spuLHuKTyEBLCbrKLVw5kmH16XPs75b/vCKV0g
mq9LydWU71mMH4741mnR
=6Fcp
-----END PGP SIGNATURE-----

--71MxWb38FuvvANV0--

--===============8513227806232390021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8513227806232390021==--
