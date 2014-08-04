From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: fsl_asrc: Fix two dereferenced
 variable before check
Date: Mon, 4 Aug 2014 15:48:57 +0100
Message-ID: <20140804144857.GS30458@sirena.org.uk>
References: <cover.1407125653.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1239208845144038483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD22B26084B
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 16:50:29 +0200 (CEST)
In-Reply-To: <cover.1407125653.git.nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============1239208845144038483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cLlE6j+44ygFdGhU"
Content-Disposition: inline


--cLlE6j+44ygFdGhU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 12:19:47PM +0800, Nicolin Chen wrote:
> These two patches fixes two warning of dereferenced variable reported by
> Dan Carpenter <dan.carpenter@oracle.com>

Applied both, thanks.

--cLlE6j+44ygFdGhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT351WAAoJELSic+t+oim9NToQAJUF1XjbsAlLJBtudz22BZB4
pT0zwdKzezTIWkiCRqJA6WLcI2uotofSUEOyj+Oyp1/DfcS1/1GPPGKRV5g/sZn8
lKJAQhD7K+dJXqVgYcjz42DhTGZq55Drva9T+tA6aP4745GYsYqOWnTDZONNBB3d
rbIPUgXCiL47Kwnn/dHSQLsFEzwUdiQc2cOBzBlykim5k1eQWefhZp8Kw85wN+ea
cNg3T8eWNP/FFbVxF7l/des/7KY6y3QAm5wRNFPDSOOhcoN87OhYmmeZpoDl7WqO
Kc1pxGjKY8EOMd6nZSC3uID5vqQwuBRHWU42I0VAHO7/HLAJSGPYIzOBTsYDUNnB
vD0z0HnWa7kWnuqVi7pAc0y9v37Am/xSZn8L3L9Fga3SQxPvxMtxDxZNP2uqJFEY
9pqLigIw/aXSFm6fjVK98ZJgbMNU8+sFjhtKfjdU5UXZQ8cNaHT9GlJwlrroXmPF
ruyI0WDklicdatlInhbs3WjyiHCWX+Awr0ZDmeRVd9cEzhY22SEDIqd0HZK/gu6+
g1th0bZrPjSMb7Eofdl4gOoeyEhv3HQH9Dtwd6VxnySaTj4YzFYldtHELiyNQFpH
PIwcAp2eyOAdVWTARiH6jUXO5M9sLuo12YmMenuByvq7QrbRyEzgvSpkjULI/X1H
p5iIxT6ioswgvNtQnXuM
=22xm
-----END PGP SIGNATURE-----

--cLlE6j+44ygFdGhU--

--===============1239208845144038483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1239208845144038483==--
