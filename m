From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm1792a: Fix max_register
	setting
Date: Mon, 14 Oct 2013 15:08:44 +0100
Message-ID: <20131014140844.GZ2443@sirena.org.uk>
References: <1381569865.3884.1.camel@phoenix> <1381570009.3884.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6553440746327380684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A8832610B9
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 16:09:09 +0200 (CEST)
In-Reply-To: <1381570009.3884.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Michael Trimarchi <michael@amarulasolutions.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6553440746327380684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8BV0TfTmv8nl9Pc"
Content-Disposition: inline


--n8BV0TfTmv8nl9Pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 12, 2013 at 05:26:49PM +0800, Axel Lin wrote:
> According to the datasheet, the max_register is register 23.

Applied, thanks.

--n8BV0TfTmv8nl9Pc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSW/rpAAoJELSic+t+oim9jrQP/inL6TLOlxJhdJ7J0hb4mJzS
paMdFFWZqglIEzebhXLLx6PTAy64cks10idyb2v/dN6L8oIYiJxpjX7luCDklwTH
DGbCpHC+abLhjmRMey74c8JtRubSN8/aagT0TBbHboQlfbzGqzeuTAZOXWUYZHM6
b7e3EiVWEybF5UCxeN+fYCJPh0jfY5bPBtVAQc8bk5NdX+pWkOri6K/XgtVkcJzB
wT9fEu/Et5pfy8Qk2uxB3Dc8SXqWDu6j34O7HowkNpaMUqzw0XLHCTOIJwS2aZxL
+YNLTVqcaG2SWkr0tSWPXmiYFGruO1TALRA+jOrE1wv+/LVnJj4t0Z0JqPEEbp+o
HEZZD5KeZ8SP0lTAGPEAzoSRp2H6CsmLdXjauQH4hZEsb/24EQNdT9JM3R8E3cx/
3pgd9gACQ7ePvhvqTZOxpWIACfuJ2wCrL2L51ULQ8O+yQRL/f1olhO6i2uNvEPIW
bChJnFNAK28EQLBTSmC1u4aorMIa9I434B8WHegarTrCJTmQRHlbdBqZY5xBZRw4
e2CvRvd4vQxkB+IUpCw8WoVm96nXgULWG4lQWIkO0Xo2wpZgihCurqSjQs9IUceu
ukqqVdLs8RiSQ5iaEN1Wy8LD8Bx2sNNM1kc5+U86tx+C5y0qHDK9hGfgAKeo6nLV
6eg00fQbI91TbRuYJfFz
=+YUj
-----END PGP SIGNATURE-----

--n8BV0TfTmv8nl9Pc--

--===============6553440746327380684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6553440746327380684==--
