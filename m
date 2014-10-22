From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: two trivial fixes
Date: Wed, 22 Oct 2014 11:42:10 +0100
Message-ID: <20141022104210.GN2344@sirena.org.uk>
References: <1413702456-8624-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8526819960722180146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CC5E265041
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 12:42:22 +0200 (CEST)
In-Reply-To: <1413702456-8624-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8526819960722180146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Content-Disposition: inline


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 19, 2014 at 09:07:34AM +0200, Daniel Mack wrote:
> Just two random fixes spotted by Coverity.

Applied both.  I'd been holding off on these waiting for the developers
of the relevant code to review but I now notice that you didn't CC them
which is probably why they didn't respond!

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR4oBAAoJECTWi3JdVIfQAxAH/3f2palbQSkMrxrAxi0eDO89
GkfCwyV5KOxB1cBgRSjswzWg7g74NlLMlXl2JdhXs3XgNILWS8Spb9wcwgCKBJXV
jugOOeJv/t2Wpz5AskjOwGD42DryzWhqUkSAi9dwj4mDnvn2YT67NrJI6LXFD/cH
7zUlZcPCbdTdgtR9NOQTgj0N5FasHUiDHT97aXjOEDBK1u6Ks4UgKmZ6WUkhsuZC
qnI6aMWqQ2SbFl/9rZy78kJCZ+CXFGLrEz8pCkwoS/YwGkncboCW2DqtyGuvXN8x
nJxa/S3CREM0AHdAkCoW9BMvuCIo3NNi5rCkzKsVXor6n0Zea8BHhAkXCKcl17g=
=I+uG
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--

--===============8526819960722180146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8526819960722180146==--
