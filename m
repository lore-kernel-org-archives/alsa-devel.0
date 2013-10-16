From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: pcm1792a: Include linux/of.h
	header
Date: Wed, 16 Oct 2013 19:01:08 +0100
Message-ID: <20131016180108.GR2443@sirena.org.uk>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
 <1381492441-31195-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2776196680550790485=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 186AA265251
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:01:11 +0200 (CEST)
In-Reply-To: <1381492441-31195-3-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2776196680550790485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g0wx1Af4JGcSqOcb"
Content-Disposition: inline


--g0wx1Af4JGcSqOcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 05:23:58PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Applied, thanks.

--g0wx1Af4JGcSqOcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtRhAAoJELSic+t+oim96VAP/io9efIveX3K5bzEwsHKIugG
PC7X7NL01W8ZKb5wayY5DiIbcZVTEs2yC/UCJWoxXXqr6BTZ5KfYQsLiBGAVTkap
9m8gPB1W8SLuEbhHmJpGKXu60RNN2HA5zYvRKCGfYyRtG9M0wm5UihZyoIrrUE0Y
Z3dX6IK+Vp7FasqXc6t8rZuI8t5wquuxdGD8gs2JMujYPR7Nhe0YsfPqE0guEoFS
kpiYF5FvOiP9bi9LDGKTntqQuaJy8xpLvqev4uBN0Yt5qnFvIKR3lBl1ospzOFGh
fFTSz8f4kXcuFiyYt8obVnlZtdMjpeXr30XjbLFCBd9ANS4gjWHqdxaEx/YWE8oa
mGQsGsTMpT/Gq7U8Q8bjGDqJhXZHVKaNPp7jz7E33mndtC1U50PBfL87kXbf4rkt
1Uu7ADc4HQQGXzsDXFXtUzBTeVUy6QWLrHAXt/bwMmeig6dgpLesq2EWsZT/Jv2H
DX8ByMLIhqiOq2DqwztK4wYIj80AoiX1xKWH7BspLdscDFd9Kw+lb++zr+l7/WRW
IcWVdLldpQeBZd3tfmvr+h1wryy5qW7Km5w9ZJZiuh9O1153uiftrIKAN8LUd+lZ
VCZ+uuT2Mj0q7G6zc7Tjzc2UVnqQxfm3GcB6FJUQJV8A7EcYAvhjdhSzwhn66Krl
DT5RTDx/d4HDq3V4nDOQ
=VhFb
-----END PGP SIGNATURE-----

--g0wx1Af4JGcSqOcb--

--===============2776196680550790485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2776196680550790485==--
