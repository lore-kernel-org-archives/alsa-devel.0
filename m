From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Thu, 9 Feb 2017 16:45:47 +0000
Message-ID: <20170209164547.fgwi6cc4wicag2c2@sirena.org.uk>
References: <1486625411-475-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5184505978156820017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F11FC26680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 17:46:00 +0100 (CET)
In-Reply-To: <1486625411-475-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5184505978156820017==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ktcosclhiovo6lmz"
Content-Disposition: inline


--ktcosclhiovo6lmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2017 at 03:30:11PM +0800, John Hsu wrote:
> Provide the automatic configurable LRC and BCLK divide. The driver
> will make configurations of LRC and BCLK automatically according to
> BCLK and FS information in master mode.

This doesn't apply against current code, please check and resend.

--ktcosclhiovo6lmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlicnLoACgkQJNaLcl1U
h9Bs7gf9FLiK6pj1I/2ZWnxl0sl605RW3rZJNoiwDVxozGqVCXCmLaz2LOaXUkHb
ajQVGuq8X74xUQ8WtY0R3r7U55zXi6e2dpvr5EFzSC8e+Y/exewgXyE0UObpawXr
GjDCA5sPGKO0F7ZFUNzxcF6nmXXs9WE8cLvuMpAzAobQs5BqUMYYQxDa1kWOD8eR
7uVORXufZlW1LBJkLNihvQn77qK0Vqc8FTE59K8MFn5WB/VjmgPYY3SHlFUT49w7
nw515TXDgY1w39n4+4dttylpb7SEaAYIE303E6WAQTL90nC3edyw4CNZ7igxZRrt
JFWgQGlsgyQdM7EANDJ0j/USGcMdqQ==
=dKY7
-----END PGP SIGNATURE-----

--ktcosclhiovo6lmz--

--===============5184505978156820017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5184505978156820017==--
