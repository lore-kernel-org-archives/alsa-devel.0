From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: Make of_device_id array const
Date: Fri, 25 Jul 2014 17:41:17 +0100
Message-ID: <20140725164117.GT17528@sirena.org.uk>
References: <1406203117-2767-1-git-send-email-kiran.padwal21@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4350453033896809755=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50D4126172C
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 18:41:36 +0200 (CEST)
In-Reply-To: <1406203117-2767-1-git-send-email-kiran.padwal21@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kiran Padwal <kiran.padwal21@gmail.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============4350453033896809755==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="02C+GlUcNvfRYA2K"
Content-Disposition: inline


--02C+GlUcNvfRYA2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2014 at 05:28:36PM +0530, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as const

Applied, thanks.

--02C+GlUcNvfRYA2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0oiqAAoJELSic+t+oim999cQAJLCqvyIWbigXLoIRtrxGYoh
GHy1nPjwhJbZm236uRkUWHK2dbnNzFhE33xZ2w9IVW4XNffGLrkyXJr2bd8d0Wyv
7kpYcmVXOUiLAEaO/9BKK5Z6JWRKEDKacz7LtdwXUshaOer3TnoZlW+qIy441dqd
mJts1q+eqCiaJ33KqEMoJnaupKpiLwjT4mx87DSY/5JOIv8/dCQ38UujGU6XH02F
NgC3q4vqiqr3Lc/SiSXtskLRuCydYGkVCH0Kr1Fgy03cE3gySOqFM7lRBmLFwp9K
u52vZFzJp8fa27GWR7g5uiYZvnelIsED69/CleBR5iztTEQVNTX2Tz9v7CJ8i1dv
iwT06ZQ2NduEZG2/rJax7pYjBTG4Q3jtrF4rD3vcqxfZN1+Jv+Eb03cMs7XtqXzx
adNQDNxK+fQp2fgrXUVvBkalKOkTmRyP+uNPuLV5l5xDgAmrDZNqST04SSKNigCq
2J+jJBx+JT999FrEhf2vnZKUo6KdcuYEvSQIB9eXflLgkHpcM6WtYyq0xXClJ02Y
rspt82rwZUpKCWQlgtOCD25r0AfDu1EyS1PxbVQkDt37UxmVVlDBsVFIr+ZNAG5A
e+/dDk4L7M+98DiyqJKeWR9EGl4FmcGUwqJY0wyrFEZEefPU9y/dqEXFmHJiw6gL
Rpl3kFHzNonjKHz1Iv2Z
=fsC4
-----END PGP SIGNATURE-----

--02C+GlUcNvfRYA2K--

--===============4350453033896809755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4350453033896809755==--
