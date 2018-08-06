From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch
	fall-through
Date: Mon, 6 Aug 2018 12:52:56 +0100
Message-ID: <20180806115256.GC17525@sirena.org.uk>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
 <20180806113426.GA17525@sirena.org.uk>
 <e839abf4-cf54-fe2e-7eb8-57b12106b586@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1366592929824906061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B81D3267820
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:52:58 +0200 (CEST)
In-Reply-To: <e839abf4-cf54-fe2e-7eb8-57b12106b586@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, valdis.kletnieks@vt.edu, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1366592929824906061==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 06:48:13AM -0500, Gustavo A. R. Silva wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> OK. I'll send a patch for this. But I wonder what's the best approach in this case,
> so the fix can also be applied to stable.

Just send a patch, a fixup can be done when the backport fails.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltoNpgACgkQJNaLcl1U
h9Da6gf/dukgSwGIXxOxmgpBKOx6lqhNe2fZpx7a+q15BfKjqHYs6BQAN2HgVFxH
rpqZAEaBqAbwzWl19VCVR6mOg1837QyZuLtydHnQRtiJXl+vvDUCvhu8a/ARWINu
FBYCwHqKKWb8YMsYvzCq5HNYu5v4dIzTeqrTBXrz0XPvJ5Us/r2big1mQXy1jhLl
FqA9wUOtXX/ItN2I5zOkseOlwiMW68fgLkEK3FqnaWWlTEuCpvEE0TA5P8ubFiK5
3y+Em38HkQpeKa9P2MBU2iWldO8wxc02/v5F3zCqDAiUQdNVPC3ahHR8BkQ8Y4Kl
T8pJfB6IFydPp/rAmQBcGML+DegYhQ==
=v3dR
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

--===============1366592929824906061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1366592929824906061==--
