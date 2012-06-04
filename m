From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Mon, 4 Jun 2012 10:51:46 +0100
Message-ID: <20120604095146.GD3943@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9030383666542989021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D9B5103FCF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 11:51:47 +0200 (CEST)
In-Reply-To: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, kernel@pengutronix.de, shawn.guo@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9030383666542989021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 09:42:53AM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Timur Tabi <timur@freescale.com>

Applied, thanks.

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzIUZAAoJEBus8iNuMP3dUo4P/3O719Mrk7wH3W0+EnrmC6JI
KapzDi4KtkdLDhWIipGCwLQAwI3GlHq2hsefFoP/vJy2SPsuuTK/xCy/a9lnWEHS
NmmtdZ/P4SGo8YOf8DGtrpVhUUObOTl5Bd5iOMsb58aUZGfNmYE16RpYPNpYjB1p
l7lth/c8d9y/KDRtkw4rCmcSB3AdW2y6k2HeCCy9SjCLZC43GDJwYDiD/yTm1+5R
r1y/KPLa0Cf1oNvX+ko5eBrAOjyYfiVYireawEowxXzcvUC08IFd46z2WH2idAqz
b+nKm1Ly2EVvuwfUNOxnJ+qTiqREuBQ4W8v9MaCncihgYK7cYHCyJny1zdf3DivN
qzCCgyq3Je+QSE33oEH91/5er1buhpMATm/2OKe7omuHS5YPwgIrBuEirTT2agka
RuZ9sduzOy4TlZN0uWXtPvkscGA+I6H4CR+emng3Gtvg7NCBXjl2S/QY9pkPVeTx
sFtVT32QzjJE3BiqKpfhd9lnH5j8s77NxVlvy1gpLY+xvmp68qtuJs+wtxY4xup3
U4eFqdaOfZdkBgPMINg+ypYJWULjQuoSaPuRlvOJS3YiRi3GMfFAfQCytuBQjynU
nkFxhv3uBZqOUbF9Sx3+jhkpnuJ7/0EIyEV3fmDyoQnuXIYyTH+vtKYX3SEU+83o
XTwB9hNlGSezVgBKNjXI
=xM6/
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

--===============9030383666542989021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9030383666542989021==--
