From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Fri, 24 Feb 2012 14:02:01 +0000
Message-ID: <20120224140200.GH5450@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0537559209176091978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E9D210428C
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:02:03 +0100 (CET)
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============0537559209176091978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 10:09:35PM +0800, Shawn Guo wrote:
> This is the third series towards reusing fsl_ssi driver on device tree
> based IMX platforms.  It makes a few cleanups on existing PowerPC code
> to ease the later addition of an IMX machine driver that works on
> fsl_ssi.

Please don't post new threads as followups to old threads, it makes
things harder to follow in threaded mail readers.

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR5hNAAoJEBus8iNuMP3dEc8P/RPpZVB+GwWkJT7QPCPhKuvy
xYoTBxlL679J+0ZxUIUf7nTXBAmw4we2LYR2eSh3aM9rtvUYyGLRvwhTR0Vs5XXQ
yDtsuzcLUba4DtXfKoJx/uWPFUQ3IzQHbGBFFb0/09hbr7IlPJiKk5Yv+hAJ95BE
qrju25aIYEte46GRzh5wMDtQ2lSH+VpdYg3cublUsqUEaHjQO/iE/mVyD78A6Phh
m8pdZSBsoX853dfeLqtBkduka8++HihGGUVAKnSGQPlHDP8AWjRTQoDisBO7L7mL
XhkxvtG5TrEsxBq9EFW9FaAgEaRyCaXleAMuxp3ljN/kvKhIEW5xLg2qsNBZHFRm
5hmRoGTXNO4tJ3/S2c0CI0uzjsXcGy12FRB+Xl6hkCFXm+WBcZog38XDTY+90yup
GUFj4SytHX0dk/t1w5GiqWscezJfz2yi17f1EXo2zIPe4nU5goPJcqp+MgLtmpQP
T8mSdskaCGGTM3dugkBW153f1hsx+Xu90dX9VFaBpfkZRNyDjaP1mCajPw9QllDw
3xhe5ngqBFlaLrgt2FuN0rqVap1lfsKJaxI6fQDW0NSOomioS5YJsTIaPdT6jC87
B/ZeSvKV24iMNjq+lHHww4ZxmMGLsTdJr2VbRTeroAzSHBgT/DlG9DqMAj89+eH2
5bH25XLXXZfWYhi53eCu
=eIMq
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--

--===============0537559209176091978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0537559209176091978==--
