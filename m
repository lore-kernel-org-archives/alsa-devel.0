From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] ASoC: zx: Add ZTE zx296702 I2S DAI
	driver
Date: Wed, 3 Jun 2015 17:02:18 +0100
Message-ID: <20150603160218.GO14071@sirena.org.uk>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-6-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3339227126540946281=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59739265AED
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 18:02:28 +0200 (CEST)
In-Reply-To: <1432906281-27698-6-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3339227126540946281==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P7peSLPSdcfcL2or"
Content-Disposition: inline


--P7peSLPSdcfcL2or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 09:31:20PM +0800, Jun Nie wrote:
> Add ZTE zx296702 I2S interface DAI driver

This looks good but the Kconfig and Makefile changes depend on the
previous patch.

--P7peSLPSdcfcL2or
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbyUKAAoJECTWi3JdVIfQISEH/jiS5wQsFQGMSgdvbbra5hhj
09nJ2nbX8aORym0EIjDtT4nIW7S3WE17OEFv/OZrpe2hxi4oAedqT8iD+j+5nF7Y
pPTZ1XMnHnr6ZK/PBC1srXbAzjdr+koIhkF468b/O5rbp1iZCfs6cHBjMBinDeGh
r1+arGAD3RSBWzt9B5BOOj7U3uxsmyH2zK4No5+Rpmp9s7gsNeDsjgPPWuLHDi4l
bTcRU6wXF6P99pETzTZQ4pmZsLlmwMuyZaUgpNFUIm7zom3y37mkuk0I2Xq3iGxA
1v1yp3a6znkev1ESByTPJldiXuHhG13jPj0sfnAE/zqQz3DkK/cpGw62EIg+Uqw=
=wmqK
-----END PGP SIGNATURE-----

--P7peSLPSdcfcL2or--

--===============3339227126540946281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3339227126540946281==--
