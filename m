From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing
 license information
Date: Fri, 8 Feb 2019 11:53:41 +0000
Message-ID: <20190208115341.GB6695@sirena.org.uk>
References: <20190207165755.1548-1-johan@kernel.org>
 <20190207165755.1548-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8627580662443696500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13FC9267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 12:53:42 +0100 (CET)
In-Reply-To: <20190207165755.1548-2-johan@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8627580662443696500==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 05:57:53PM +0100, Johan Hovold wrote:

> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -1,3 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + */

Please use a C++ comment for the whole thing so it looks more consistent
with the rest of ASoC (and a bit neater in general).

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdbcQACgkQJNaLcl1U
h9Be0gf/QKPELmLG6FLa7UU3wNmtZtk2U+HBGyrAbim9AINmmojTCIvjVnwng7w5
8CVUVLC3gWlQ7U1OR3E9nvhrl9Ximk1rqsWFLwI754LJgmkTLjrh925lFf4LVd+q
PpAjJP/IN5YQa5ZX5A3XcNcsvwJI6ASCE8I0WBS6g/OHQ/3IKrpH7ghaiTgD4kiB
JqiOVTrGHDJWl1VneZRHTT35Bgwnods9tyUUQewKnL9bm/F0zXNZFNK+cA7AyZNi
k/Ldkd98RjS2aottEQoxBSwO02f8GT83zWmH3XKZcQ/4pBYYF7JLjHjed/QDxFFh
hTJQ3nHmR5IUtANcGssJtVpmn/JZXg==
=4nTm
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--===============8627580662443696500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8627580662443696500==--
