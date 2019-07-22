From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt1308: Convert headers to SPDX
Date: Mon, 22 Jul 2019 12:50:45 +0100
Message-ID: <20190722115045.GB4756@sirena.org.uk>
References: <20190719063302.18858-1-shumingf@realtek.com>
 <20190719164623.GA14800@sirena.org.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BBE03D@RTITMBSVM07.realtek.com.tw>
 <20190722105821.GA4756@sirena.org.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BBEA77@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6523262534413179409=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09206F8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 13:50:47 +0200 (CEST)
In-Reply-To: <10317AB43303BA4884D7AF9C2EBCFF4002BBEA77@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6523262534413179409==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 11:48:52AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:


> May I confirm what your point?
> I convert the entire comment block to a C++ one like below.
> // SPDX-License-Identifier: GPL-2.0
> -/*
> - * rt1308.c  --  RT1308 ALSA SoC amplifier component driver
> - *
> - * Copyright 2019 Realtek Semiconductor Corp.
> - * Author: Derek Fang <derek.fang@realtek.com>
> - *
> - */
> +//
> +// rt1308.c  --  RT1308 ALSA SoC amplifier component driver
> +//
> +// Copyright 2019 Realtek Semiconductor Corp.
> +// Author: Derek Fang <derek.fang@realtek.com>
> +//

Yes.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl01oxQACgkQJNaLcl1U
h9A51Qf/fCYAmZXAiZVve59JlERuzempdzlMSIUzje2qcdBxBN9MuGl5uxOe0V8q
YzERB05P1uJP8WDr3VF8NF4rJpUGEPcsqYP0hAxvd+ma0dnN9DwmAEAGecW+QQ8f
qIJU68aJF3b1yBHaM7o3tRaLI5vRKvidiRMFfSrAUN+MjK+U6lMSqRx98+uMvUu6
Ym+fzLtT92z8lmHvQVr+Toj7IVJr8r/JSlBEnpEQv6Y5iHwPICRL54CWNC1NEbxI
qQYi0G/Vi6ySHzhteUnd7WMeuIuGmbRRzv2tKZG+hvqFGg8iAnmbSToJIshMCuny
Z0mxdx8O9peQnNMFP+I1LSGGqY05Kg==
=V2Xx
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

--===============6523262534413179409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6523262534413179409==--
