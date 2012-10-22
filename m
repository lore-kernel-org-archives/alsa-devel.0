From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH repost] ASoC: fsl/pcm030 add unique
	dai_link names
Date: Mon, 22 Oct 2012 16:18:14 +0100
Message-ID: <20121022151814.GN4477@opensource.wolfsonmicro.com>
References: <1349878208-93797-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1538936447606727223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89125265229
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 17:27:03 +0200 (CEST)
In-Reply-To: <1349878208-93797-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1538936447606727223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Content-Disposition: inline


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2012 at 10:10:08AM -0400, Eric Millbrandt wrote:
> Assign each dai_link a unique name to avoid this run-time error.

Applied, thanks.  Though can't we think of more descriptive names?

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhWOEAAoJELSic+t+oim9WK0P/jZBP4dBXw5MEEYVDvyRW5W2
bMKUXpmF2Q0ZrxttYGO9R3Pdph7dUnAScTX/4kREji+DfkdexHn4PDNWH+1wrltQ
NabnX5hMkHN5oFGXo7gRv2P5NYJ+myNKXz4JsPXs4K+td4qUXiJoyPYmPkeLGLg0
p3sBRgdPUTUn1JSXapVnJbs019n+vOWAu96Oxvc0rEmbs2JE0hOVKKAXvNGobA69
9NbYDKV7MD8q9y04clniLVvpTTI5tsy/d1JJyHK9ByHNJs0hQMOaVN9qRD75nFRd
HaeAL3LRJg76RMRZPQmiGlDCcKZjfg88q7r0IiTMnKDw3pm2tl2pLRNFlAvjRJVl
rcHRZF/FCyluqH/H9BIFgoRFaGzdZx1PIyk1cuo9JhlNbYTWGkgDor+gfM/QEcEo
h7m2vjXzr1eTwGlf/qVu5onPKWdx5YKQzpFUJRnFEYUeRr6a0Rdx5cwWp+N+VAas
u6iXsoc2jkHrB3+uPWwlK/X1x1xOZnXa3j6NeC1sl5GMF5CntTLbyz3XuR1si6F6
NqgMIXsHWr7Cq3yKvU96GeQFngF9vOwF+vNGLZ55okRcE2wjR9P4M3nEd7ilFPYF
2Wvlixe7EeOdhALUlAx+RIPBvbIJBkjn8x7UnMu9eYgjsSok+lAiLYD7Ju3C1bjP
omsac9VQ25lJ+K1qohgK
=yizS
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--

--===============1538936447606727223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1538936447606727223==--
