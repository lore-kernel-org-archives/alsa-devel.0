From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] mfd: Immutable branch for ASoC
Date: Thu, 21 Nov 2013 11:41:05 +0000
Message-ID: <20131121114105.GO2674@sirena.org.uk>
References: <1384877043-5640-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1384877043-5640-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131120091636.GA30012@lee--X1>
 <20131120102045.GW2674@sirena.org.uk>
 <20131120104526.GA30524@lee--X1>
 <20131120113400.GY2674@sirena.org.uk>
 <20131121090724.GB19368@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8605061505160845832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 76CF4260307
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 12:41:10 +0100 (CET)
In-Reply-To: <20131121090724.GB19368@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============8605061505160845832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmfuW8osuO2pi9jF"
Content-Disposition: inline


--wmfuW8osuO2pi9jF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 09:07:24AM +0000, Lee Jones wrote:

> ----------------------------------------------------------------
> ASoC immutable branch, as requested by Mark Brown.
> ----------------------------------------------------------------
> Charles Keepax (1):
>       ASoC: wm5110: Expose input high pass filter controls

I was expecting patch 1 in the series as well (the DSP stuff won't work
properly without the register map updates to go with it).

--wmfuW8osuO2pi9jF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjfFNAAoJELSic+t+oim9DNkP/2StAuJpqUh0K5t56xqyZzxn
NuFZvXfL3SxFfPgLX4B1Gzhndv+zwRX80qOqA13fB4ba5idxLfzAPGpPNugtsEjJ
SInyY+1lhCmINwxfZTe+NAjQC7Nhw/e65ygr+JagTnWlDvuOxWj2DipjcEN5tq3b
H/j0oFc/NHbcTRea+TpxtdwLGhMzVDALaURwBD5ry24pOiBRGj6P0t/9EuvakVQJ
HlTb2sqCA5VXyZo8E1DLKYiMlWrXF9dVot60oOwToBCGE0tgo/C66HMqlN1oqLNj
Vawza2TrnIgaeSSG94mZpB2UhQ5BkczNZ12p+dippa6cf65JbQHaDrc3dEY1Am7r
hhzd1IugX3i8J+0zDVSQOGDQksiD+2XQPdqZD3vdIw2Z9YZ72qcWOezHF5PMHrtj
BOC32UjRHFSK5/kpoOadqlhjOaa0zplCDHqTKMA+O/i+jnST46Tbs7DzYmuulxJN
mlFIvEgM1qW+EqjEhfdBK/syXjdZEwLtQdh39io8PJyGqR4qLGAceFi83K5vnihd
6D3JBT49oy8kZR1aHOIkTmagW3UM2zD2JZ+0v5qOMIzRsmEuY/r+gEyZRpminf6c
YGZ79OUHjDBdey0KzK0QEDEt1sfeb+udX73o1qGlB6PYHrnBlViUmCaY3mngr1/q
XUPLwtZve3XNf7FcMPvW
=vkOe
-----END PGP SIGNATURE-----

--wmfuW8osuO2pi9jF--

--===============8605061505160845832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8605061505160845832==--
