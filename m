From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: Use filter_data rather
 than dma_data for compat requests
Date: Sat, 19 Oct 2013 21:01:15 +0100
Message-ID: <20131019200115.GE2443@sirena.org.uk>
References: <1382189739-22732-1-git-send-email-broonie@kernel.org>
 <5262BFC9.3020405@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6704461689602742976=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BD1BA264EBF
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:01:17 +0200 (CEST)
In-Reply-To: <5262BFC9.3020405@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6704461689602742976==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5YYVglCS/eEjGrzH"
Content-Disposition: inline


--5YYVglCS/eEjGrzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2013 at 07:22:17PM +0200, Lars-Peter Clausen wrote:

> I think this patch also needs to update sound/soc/fsl/imx-pcm-dma.c

Yes, I sent a patch for that I think?  Or did I forget to post it?

--5YYVglCS/eEjGrzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYuUIAAoJELSic+t+oim9dNQP/2NbckL28Jtf3TwVjZ+5H5Lx
4iaCUFMF4gUUFK5kLc2qU/DrthGKX7Y6KvETvtX8OR7bD2HPCTcxZb6QPwx2C+yP
PKuEy6tXR17S8Vo59bhzjkTS5YFLKsP4OtClx6+eB1GLMXQi5UsDrG4VbWKpdS6F
JIFCObedM0+TTPSzOBMDKeKvLHK/asrn91UBhYlesem9Oe7rxgdCx0mcO0wZCv1u
ic6UPW4HO+5zfsmfR9lfZfLwyNmAun11Z90xXCOZ197sVrZi3t1tW1kDp2Mm9BKv
8ouJlDnfASrDNvqaVq5lscleJ3kMlMpdF8340JswawNiWqS4Jjx9z0W6ZKfAU0p/
aMscKtLBzd7FGHSyPTFwuc3ARvXPjf/c6xQrnwoomGd5eRtFLTu1RghAy1UOSaXx
N3XD3QlKeXRubBp78Vpm0pvICd7CS8Vsu6jzMoXXo3tvlp4vt7OuYcUaIEwgpPtg
IpAf30r12GQxyUNdQ1lb4MLsSti554OVrJlX07GAXNav/jTGQNTyO0y8ZqEQjJqy
xEZ+wMsLjQjO4Y0peVzKZ/WbJQedlWkULWy3xRkK827wgCuZkK1haYZsGfgyR2yj
lGoUy1IEEuMzdncVbuvewIYLQSFwOs6wvCdGsMNKZmXWUS16JwTa34834vKH7u8n
o2SEj42DWwkB1nDrcH+N
=jzwZ
-----END PGP SIGNATURE-----

--5YYVglCS/eEjGrzH--

--===============6704461689602742976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6704461689602742976==--
