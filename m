From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: davinci-evm: Do not include edma
	headers
Date: Mon, 2 Feb 2015 18:26:26 +0000
Message-ID: <20150202182625.GT21293@sirena.org.uk>
References: <1422881382-26405-1-git-send-email-peter.ujfalusi@ti.com>
 <1422881382-26405-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2654884136576939569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA0F126057F
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 19:30:47 +0100 (CET)
In-Reply-To: <1422881382-26405-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: olof@lixom.net, alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--===============2654884136576939569==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rZy99w3HPQ33rC5w"
Content-Disposition: inline


--rZy99w3HPQ33rC5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 02:49:41PM +0200, Peter Ujfalusi wrote:
> The machine driver has no business with the underlying dma.

Applied, thanks.

--rZy99w3HPQ33rC5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz8FRAAoJECTWi3JdVIfQ7SEH/RA1VcsfJGBNGA6nHdOPyNqG
oTqUHsrfbImZMdhfy9CciUBH3ocBSyKnF0M0ekbUwuvLNfC0W0Sce2iy2OwoX+yn
JNflhnAfd79JKQLd2nBtVdYM40ynyF7eFsakvS0HBSil69Lp4nzI3GZD4/jGgjVq
VLw8DouKAuAw9ylnmBAMU9Gp+RwY2S10f35tV3rcUb7nRcFRyX4Wo003vYtPzt11
cEUaIQmR/I5DQfQ8Xz7M8NB/HMyQBAmj/eIeONcCwzDzmsWp8EgEbNDf+ZOiaagk
nxRX2oeMIe1iEJNvrkW4V0LzoEc3/xPRZ/NyR3v82sFY8cQaJocUaItgBkQoGd4=
=OU2t
-----END PGP SIGNATURE-----

--rZy99w3HPQ33rC5w--

--===============2654884136576939569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2654884136576939569==--
