From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/5] mmp audio support
Date: Wed, 13 Jun 2012 18:31:26 +0100
Message-ID: <20120613173125.GA7804@opensource.wolfsonmicro.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<20120613121743.GN4545@opensource.wolfsonmicro.com>
	<CAMj5BkiOtgc1rPb1usHCahna8V_2PJceh9v9SGBduzChKjqoEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8084551062121286218=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6AF7310451B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 19:31:28 +0200 (CEST)
In-Reply-To: <CAMj5BkiOtgc1rPb1usHCahna8V_2PJceh9v9SGBduzChKjqoEQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============8084551062121286218==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2012 at 10:01:55PM +0800, zhangfei gao wrote:

> Great, thanks Mark.
> By the way, patch 05 "ASoC: add ttc-dkb machine support" also based on
> these patches.
> ttc-dkb (pxa910) and brownstone (pxa688) are sharing mmp-pcm.c and mmp-tdma.c.

That was already applied, just miscounted.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2M5mAAoJEBus8iNuMP3dl64P/iqUzQVG9u64b2aGvOea6J0V
aYRSrtRw/BTks921/muo8QDCbpfpbEO2PzeBEUAxxpnx6QiyK4bAK1uEqYolWYWb
ZXxPuaRV890tdRq1JTUpgND/JZCvCzJoCGQg5m6Y4kn+sSlXDnSTz2HlfFKBOWYC
qsQYpdtl/klJIBXrDJ2U5zSYfPUXafAUsA5QaesO1n79uJLXWs2z23uoDsnJoHTF
DTORmAAcdbWpbFJW97Lkhw1O6fKBjVZb9OyitM2nslh5IQYRSE2yiyCEK5SYn2WE
H8IJTTuXv6CteOOonIoPrpCqTKzzps8qdAz58I8WgsI5l8luvYtvdqq8Sk9HRv1x
BetJXfTWTV6niG1O0E+4WV4qGzHuj3yDlmuDXBAFmoc+msjCK1N6M+21iI2Rw2VL
GyUKx9Mi3mGARLV1u8tyBQE1j70xy8vpD/lDojB4nkYOQlHeEIlBGnxIh06JljXo
nAv439603EY1/pfl3j/iJB4uUEUxOa1eG5E6xGqeP6RHpaAJJnTfsYpdhExaEN3X
6ul4fMn+luflfOCbjbpB/kr36AGt7NXPe/9/KjjRcnwJKt9P03hjAICWB5jhHn9s
Lvkw3H+vfpPwvYlQ6f8sQy8xGqJhWuw4KI96stqjZVt8O0JMT9sBZIrwEsYvIvjH
knPQ7QOwyVLv1zIcEUBz
=H1WY
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============8084551062121286218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8084551062121286218==--
