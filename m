From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ab8500: Explicitly set I/O up
Date: Wed, 25 Sep 2013 10:58:09 +0100
Message-ID: <20130925095809.GK3226@sirena.org.uk>
References: <1380020163-20496-1-git-send-email-broonie@kernel.org>
 <20130924120115.GK2185@lee--X1>
 <20130924141910.GC3226@sirena.org.uk>
 <20130925090325.GB5132@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4572812930873262593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 907782625C2
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 11:58:14 +0200 (CEST)
In-Reply-To: <20130925090325.GB5132@lee--X1>
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
Cc: Olof Johansson <olof@lixom.net>, linus.walleij@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4572812930873262593==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2013 at 10:03:25AM +0100, Lee Jones wrote:

> > It's in -next so should be caught by the build tomorrow if you don't
> > mind waiting.

> I'm in no rush. OOI, did the build pick up the first issue reported by Olof?

Olof found this by doing boot tests on -next.

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQrOuAAoJELSic+t+oim9MuUQAIhjNcpjjvR9GXhCLI2jDys0
B5Pfnu6eqcZKlUwV2vhAnUCJi5ZbVSWS1CmAyhlWBdbqMKS4WGeTnY+Qtt1KhQw/
TGPePeuQNmP23C+tbLtrrPGxHaqz9/GfPxF5ZZpM1TaCqWO7FA23QlrFXp43ZgrP
HGGBb6R5KG5e5YuGtu2pMYSTkrFsUeW4+bQnodO5s8LOqJrsF2LR/IvyiLaxffgS
a6C+nOzUGBRCH6FoZd/vcNaKI79uck1I/21pYo5zvjSuTb1bBJFsLlbFP2akmvL1
UWwumPD17DAUG6s/rEuMSJW9JLh0YWOm3xKDEgnXjigVQb7gCX//NZSOQ1+V+FyE
13JUAMrSmgUgcNJ5oO0cXN+6NR3lTm1jteLRtKeyF7yoRp9afV2oJ6G7kxWtTmhV
er5aryT3O/LqcNQQoSXiRcH4BWqQ+VkfbIq76hNZ48x4zp2olcBJPhn0Qys+EsPH
wglofZAkCfZveX8+ybk5zPhGSRpq2Aj+yuTV40PRQ0d2bdb+oYDTsT8P6nmDs3z3
/GWoBTiExlX2ku4TP/n52EpO0DGt02fQ49xf1X+Dybd3wY6GLoraiZnF6PMjMA42
pePC8cgIeTNdUvg9nXqtGlfQufKiZ8BOcgJG28hUqwS0TnXin2wC4RiwQvjHKWmN
PsKr15Taf9cn/+C1xSLI
=QmkN
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--

--===============4572812930873262593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4572812930873262593==--
