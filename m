From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: bcm2835-i2s: Use
 devm_snd_dmaengine_pcm_register()
Date: Mon, 2 Dec 2013 11:47:48 +0000
Message-ID: <20131202114748.GQ27568@sirena.org.uk>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
 <1385625037-24973-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7323579650597375953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 750072615EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:48:09 +0100 (CET)
In-Reply-To: <1385625037-24973-2-git-send-email-lars@metafoo.de>
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


--===============7323579650597375953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofoyOKZR33MYzbeX"
Content-Disposition: inline


--ofoyOKZR33MYzbeX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:50:33AM +0100, Lars-Peter Clausen wrote:
> Makes the code slightly shorter.

Applied, thanks.

--ofoyOKZR33MYzbeX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHNhAAoJELSic+t+oim9uRAP/32NvPoiGsv5s8P51ar9V9M9
mqZ7YW03nB4+y7awMNnMghYuyHj9GcbGlZnUZC8wnRFqcrDgL0DencUTlb8bVRLf
8XZTQio4Uzeu6C4/yHPUzsgLBCrhijo60Uebu3BDiAYZr8NMEnNFLzCwS7yppR6f
tT5/e9VY63mCJvlKtMCDKozKG2aaa40k/UYWdzNHNIDlvergmtpvPcUHCq5Oh7Yg
CqoxageMnS/heQBHeBjipgECCTp2Qyq72FSRtsS7HZK9n/n8WLiFv8x0IsCJMSuZ
o3zM9uJH7Zo4cLlzrqkHFdoJ2p9EbWZ8KMd71uvGhgOe8Z3GGNAkCUyP7MqVFzAo
SAABXXxirMeHJixkZP2eB4pZwxdLp5a91z+r/GgspmOGXMfvD0iLwY4H6mmVdYe3
vm9zWMeIFBPdkET7sdpRqPZuYDl2YW2AR2pdflRHbLQtQuzNMBCaawvrrRl8XK22
CiFONSJwRaGCyQRhwh9PQHQ/WY/Dc78lD0ZmZSPUhzPGGXMoQEhNn9Gbcxpe7S8M
B/ytbyIL+GG4TM/PUUyp4uR21MoFKkqmAId1QNQqOcgpnfVzUlAqiRp1QofY/g/W
Ki7A6jexwCHGRwO+KANZbLsGiFugK/Otx5Zz6nSpYMlng3H8lGlY24cWxUFFYh11
ELRLDV3uRcE7qUTorlXk
=kfp3
-----END PGP SIGNATURE-----

--ofoyOKZR33MYzbeX--

--===============7323579650597375953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7323579650597375953==--
