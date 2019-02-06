From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: codecs: jz4740: Use SPDX license
	notifier
Date: Wed, 6 Feb 2019 18:10:54 +0000
Message-ID: <20190206181054.GF17630@sirena.org.uk>
References: <20190205031108.26171-1-paul@crapouillou.net>
 <20190205031108.26171-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5790208995100347258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 698F226792A
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 19:11:03 +0100 (CET)
In-Reply-To: <20190205031108.26171-3-paul@crapouillou.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============5790208995100347258==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2019 at 12:11:05AM -0300, Paul Cercueil wrote:

> +++ b/sound/soc/codecs/jz4740.c
> @@ -1,14 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> - *

Please convert the whole comment to C++ style so it looks more
consistent with the rest of ASoC (and itself).

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbIy0ACgkQJNaLcl1U
h9C9ygf+JHkT2svpsqkGAQ0zFVpciiYkmRlqFlvGQOo0Uyb57bINoJCazjYc4WLv
xoTLbn56dDNWyi8Sn0N69v5qTiAlE9lCHAi/OrkcCQBncggpXiYAdVxWYn/AYBU4
UmK7Vb6RdEiwD140Q51SX2fh7DVVo/YSRPEgCB4QLPRfZiGKkzscIqsmxV/mOqio
pNtIY5XReEQ1nBmFk0Kyf14C/q7nK89SYzhu+Frdruy7GnJ4gB3PooUWLUvmEEzh
S3zGvLqEDynPaIyCjKOCS9QegWOz1TPOPDQSYVjjMpBgB4liera/dU+ehaC17TDW
sgysn4Y6m1a9F5ffhyx3Tt5JFNvsyg==
=/XhK
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--

--===============5790208995100347258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5790208995100347258==--
