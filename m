From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/17] ASoc: bcm2835-i2s: Switch to SPDX
	identifier
Date: Tue, 13 Nov 2018 10:03:18 -0800
Message-ID: <20181113180318.GE2089@sirena.org.uk>
References: <1541869351-8499-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1638634337799890167=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E93226751A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:03:27 +0100 (CET)
In-Reply-To: <1541869351-8499-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, Florian Kauer <florian.kauer@koalo.de>
List-Id: alsa-devel@alsa-project.org


--===============1638634337799890167==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 10, 2018 at 06:02:31PM +0100, Stefan Wahren wrote:

> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ALSA SoC I2S Audio Layer for Broadcom BCM2835 SoC
>   *

Please convert the entire comment to a C++ one so this looks more
intentional.

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrEeUACgkQJNaLcl1U
h9ACjwf/WDuKVcSi2mNxYSryYZ+0wU8RdjLV5swZM/PlA+7dQ/ufaaH47xCTVMXE
6+j36aLoXcJT+Z78C7CQjn6RNm1+T7I+k71Jqnu4C8eWHvxPs2TTBE4+8uVUpDGb
JSBGC1r0UblndJYL2r0/ksZOHraoy96XvDCeoefOFstw2m2YizFvrEJNut3zEv2u
7CdABvi/sSMtRj3lPfAkcxh2ZDfp97WwDicZsulrEWNfkZXnhUs/GSnVdJCK5OWX
t8KQUjNRZHEYJS+zptUjIr64krJXnvI4/BavI0PtHMC/LfUO39FkWWJ9NGdwoXH0
HTttU8MclkINtXsaNXnKA+01392+ag==
=lQyP
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--

--===============1638634337799890167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1638634337799890167==--
