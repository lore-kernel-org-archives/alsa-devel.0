From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/7] sound: ASoC: add ASoC board driver
 for Armada 370 DB
Date: Fri, 14 Feb 2014 20:36:58 +0000
Message-ID: <20140214203657.GP4451@sirena.org.uk>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392225662-20431-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3300967690707691522=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5461A2618F2
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 11:08:25 +0100 (CET)
In-Reply-To: <1392225662-20431-2-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3300967690707691522==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e2bLSPRkEYxxSNev"
Content-Disposition: inline


--e2bLSPRkEYxxSNev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 06:20:56PM +0100, Thomas Petazzoni wrote:
> This commit adds a simple ASoC board driver fo the Armada 370
> Development Board, which connects the audio unit of the Armada 370 SoC
> to the I2C-based CS42L51.

Applied, thanks.

--e2bLSPRkEYxxSNev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/n5mAAoJELSic+t+oim9JL0P/2PTTf/6kb5S6FrqX6p3auyp
ZoJh89SFYBJUXPRZiFKdn+uFpOQLa2WgUOaAipruAfSqNkZMTMttcInZA8C2t+dA
428qUoMlXytB2WLhzr5rUHWMWYQ1KH73WItNa6r1rm/pk/zhIPIZ76gk+/PLU0wv
0C7owJLRtTkMi8ZnMFLJWl3Jv1IiY3+qvibx7nSQcadv0Zwh6pwfi8GVj9INuwmZ
KydyA66+nSNrGLryg3+W7C+184fSCuNcnvLOLe3AJ2MSho5IuH0BO2d7IxwLk2P+
d6Xf5MB5d2xPd+z9nswQ+1bIryyXCaepUZxISSSEoWaftb71zLwOaYEERbmHH38l
pDFwpOlPPY39ceSwsS72K5mcIOnCHhipyheORgtIEULYizuuCq8a8PrpDUBV8Auw
l5qkUfy3C9CmTkKMtfccs1BnVbHrRDjDR5TSZnkcABdCyzDR1RPaW3avPYC41xGh
naMG/shtZqQ02yaJoKTB0oi8luaMYoyNcb5lA5BFRE2oqVWrE/6qacPgOgTKtO3o
P1AQsadHJ9A+3kqxnMWfyrV7G2fiJI/Nq5k6c6wGon4t5iz9vjm8uz/h+lt25cIu
2h2cxAcSeuGvUPwRkw0KN1JoBNe377DnlHs5poRo1in7BVuknXlTr03U7dQJ0hCv
FEGGKnios3bBpe56cGwZ
=/nBB
-----END PGP SIGNATURE-----

--e2bLSPRkEYxxSNev--

--===============3300967690707691522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3300967690707691522==--
