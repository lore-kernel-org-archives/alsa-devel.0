From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: wm8985: add support for WM8758
Date: Tue, 24 May 2016 16:54:09 +0100
Message-ID: <20160524155409.GL8206@sirena.org.uk>
References: <1464075532-12495-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8088044184850295352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D88DE265185
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 17:54:17 +0200 (CEST)
In-Reply-To: <1464075532-12495-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8088044184850295352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QmoJrblcRudFCJH"
Content-Disposition: inline


--+QmoJrblcRudFCJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2016 at 09:38:52AM +0200, Petr Kulhavy wrote:
> The WM8758 chip is almost identical to WM8985 with the difference that it
> doesn't feature the AUX input. This patch adds the WM8758 support into the
> WM8985 driver.

This doesn't apply against current code, please check and resend.

--+QmoJrblcRudFCJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRHkOAAoJECTWi3JdVIfQGiwH/2QAU+R0a4a4BQy7yMRxxXCh
gsgr007cmGtzxAsvN4iLcv7LVoiPB3erkTY9jCd1o572+HYq1NGHRHzF7elHIABq
LWJ/ByJnIUuGvxiYe1WYSkxou6svtxavOlIrZwjG1dt0WahskqVNP/212qHAfvhS
cYdZH/45OJcQxda1ALUs5PCxZdC6Ye4sP6wGiyg0ztYHegBt4UpATW5l5IqlMLmT
nxvjHrVXZMdNbcu3QBTyrU/C1+w3zrvHLhSMIi3Vz0b+WY9up/KNfPGUougmpXmy
f/Xz2gD9G41LaGDcbG14fT0xfxce+k4qyS0tl+VC6bVMh0ItyTDYNqWMihKACcQ=
=b8l6
-----END PGP SIGNATURE-----

--+QmoJrblcRudFCJH--

--===============8088044184850295352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8088044184850295352==--
