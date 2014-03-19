From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Wed, 19 Mar 2014 16:50:50 +0000
Message-ID: <20140319165050.GR11706@sirena.org.uk>
References: <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
 <20140210152244.19f9d647@skate>
 <alpine.DEB.2.02.1403191030070.14838@heelrod>
 <20140319174602.667f04ba@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8144148455572599928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 908DB26511F
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 17:51:03 +0100 (CET)
In-Reply-To: <20140319174602.667f04ba@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Brian Austin <brian.austin@cirrus.com>, =?iso-8859-1?B?LmNvbT4=?=@alsa-project.org, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_=3Cgregory=2Eclement=40free-electrons?=@alsa-project.org, Gregory@alsa-project.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============8144148455572599928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DMS1jUnP4bTQsFAd"
Content-Disposition: inline


--DMS1jUnP4bTQsFAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 05:46:02PM +0100, Thomas Petazzoni wrote:

> Can you ensure to Cc: stable@ to get the patch included in the
> appropriate previous kernel releases?

I did that already.

--DMS1jUnP4bTQsFAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKcrnAAoJELSic+t+oim9R0UP/ioapp1yV93qYPpM+dyObtcT
+PCuZ1dCdmoIToclbO4vS9mCCdzBazFY4/LWe3NPV5em6aebnSdTFTdN5C9pOu0g
Af7R24O7CfrBw3RkgarFAj6Ap0PpdnU9mKiI2Abf4eeUZvEeC7MIxK2Y/RmlvRxv
LHLAJvmMQUas99EXX0CdC2D93OGeE0U/r+cLQdoFH4XP4Bsw6gLseEvCFuV50rKe
bksbkoN0RSihdqS9EjZQP8sJNZfnMOEGihvT+nzfcteleLUvNohVWF9KNhznJR93
AS4bTu1UOEEUd0DO1PmcBZVpQsOgxW0bzJoK2ja07n2Tn4qvA+PGR9MGp/RhniyI
G5Tto8awOIZlAnBt4c5iC/Uq+AX3MEXRnudS1oglDmTB++anYWomc+KIi5jrjXFO
RkQjPvgk+vyk9a0u+pnxEznEbQDL2iyUZaLfgf/wnCAok+Of0Ni8BdAq3C0u3+Rc
8brPkq0Q0BtphT9H5lrMoPPbcGD1Blrtwo72Lo+5yItJ8EdeKhMtjEhOrQEzCNxd
ZBjGw58BcwmC1GUEH13OrqxjEqce3VAKXuqOCLeEXQKAxU63PCMSwCUkmVZ8yACS
COXIb6pL7+UImoVA0OvB0yiglrE/D50LZ8iPwm+B33M5xqrVkbYCB54cAqgHlQeX
rS6RkFigqBCIiZT8Df8p
=4jqI
-----END PGP SIGNATURE-----

--DMS1jUnP4bTQsFAd--

--===============8144148455572599928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8144148455572599928==--
