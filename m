From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
	Interface driver.
Date: Tue, 11 Dec 2018 01:08:55 +0000
Message-ID: <20181211010855.GF3004@sirena.org.uk>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0292848368163291906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D79A26770D
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:08:56 +0100 (CET)
In-Reply-To: <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0292848368163291906==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 09:21:15AM +0000, Cosmin Samoila wrote:
> Add Digital Audio Interface driver that convers PDM bitstream to PCM
> format.

I'm missing patch 1/2 here - what's going on with dependencies?

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPDiYACgkQJNaLcl1U
h9Bs7gf/UU8JbgSuLvWPFOxZnCqiRw5Sw1GPXJb7V4d3sVKXbJTendN615yEPKkm
RiAXF1M3j709zvVHALZ6fN9RU5Mc55t3uzDzzOwCwLuX15olRsa1/zRDiyZJkzND
gdFMulEOQmLqLNLRfOvtRPsmjMdf52yHeyczkz1A8yR6NT160Ey1fqEWNKfkvjN+
Eqb0mOkyMk+5vwct6rJB+3KHFCiPILETFhDmPTeM9afQWrk1MBLD9Htrsnh1PKnj
BKJiAg00cVJprcOGDNCmBSUppu74VYOXN6/mXsQbNnWVROqTYloR9PqXb/oNQbj/
jRUoeTJk7tdh8kEgGwZjU5eipWDXqg==
=lXVQ
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--

--===============0292848368163291906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0292848368163291906==--
