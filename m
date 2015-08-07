From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: Add imx6ul platform
 support
Date: Fri, 7 Aug 2015 14:18:31 +0100
Message-ID: <20150807131831.GD10301@sirena.org.uk>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
 <065a754c8d3eae30ef492bd81fcfdc96df5475b8.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6179802006335482791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F7CD260418
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:18:47 +0200 (CEST)
In-Reply-To: <065a754c8d3eae30ef492bd81fcfdc96df5475b8.1438928571.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6179802006335482791==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 02:23:53PM +0800, Zidan Wang wrote:
> i.MX6ul SoC contains SAI module, so add imx6ul platform support.

This needs a binding document update too.

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxLAnAAoJECTWi3JdVIfQ1OcH/j8mBJmTB3t3J0m4xUJPhQuF
emao4NWswQXK7vEMCqY1rVOZpgffZCh+m3Xu52z4QvtmpFzB//pe+0f34sKTsd1z
Zbh78ASqDZe9DEG4Y1Qm6y0A9OZMTh8pxqAwmcOXjLXKXo8OvwtZq3DCWMaEzGc5
QBm8Nkiy19GomoLXZLcdObjThIA2BjLCwHeIKFCE2FThLqg35H1npe/Mx05+wZVE
fPwmFJZ5fYgf1OOFH5JXepmptrASKHkaBFeIoRTJBLwCYys3wttQxVloJvMOyE9Z
VZph4WJ/veHz0g6vE5xh35nVgvsGUXKvuExusHE089EWc5bCl47Jh91a2SzucbA=
=fm7z
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--

--===============6179802006335482791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179802006335482791==--
