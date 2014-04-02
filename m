From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 00/11] Remove set_cache_io entirely from
	ASoC probe
Date: Wed, 2 Apr 2014 20:23:49 +0100
Message-ID: <20140402192349.GE14763@sirena.org.uk>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1005334989540769536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C41D26550F
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 21:24:32 +0200 (CEST)
In-Reply-To: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shc_work@mail.ru, tiwai@suse.de, viresh.kumar@linaro.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, andrew.smirnov@gmail.com, akpm@linux-foundation.org, s.trumtrar@pengutronix.de, rf@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1005334989540769536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2014 at 01:40:22PM +0800, Xiubo Li wrote:
> Change in v2:
> - Add .get_regmap() support for struct snd_soc_codec_driver.

Applied all, thanks.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPGPCAAoJELSic+t+oim9YoEP/jMtAGxji1IoTAgU9XX1h36X
8OWbcA75qd7mq99yhVZsfnV3jZUNfDjo/IymInxv1z7dCwC7Wb1rwZiqSG3yRKYU
4Tm53+WBqxeNdpcRack8f77fxospQl24bQm4bWLM9z+eJjEKdQxkrJGKkRXq8yJ1
zA/34LYUymqk+ZTnEeT7XY7NWg7vwG3w/gEvJcN7FCRBZcFKGQfcJxc2Gs52TXNn
k9i6O4HdmK7wMYtAJobFlsntWyEOlRDr9XpUnRcKsCkkEeKZ42i+wfNotrQlPINz
4w5eJXaMI3q3W08BearE63madM/NYAUupmDr6rknb1Plyizb+n20pvRMrO2+z0L4
0HTqmd+oQYvdxxyDWN/ZmcT43aBgp6HXiUzDorkBkzRI9H/jX6Mf+3Zrz5UzQaSc
0tev+obrhNuSZk7e67ku/cSQ533YUoHPlsF+HuDKjfS9Ff3/3byvyL13X6tCuZHW
Ika26itoflsP+61DWaH0mH/ykTL2Kvj9+7llp//fqsybXIux5c3Sy2hBQww6i9pN
OCKjPgTK9tMpuUfgMbL6kL+k91u4+LUx8Nue7ursXd2+alGM1thpjWepivul8o1i
QGMOfPfCHW/4FWGsgdgsWFoZZc2Hp3IyZf5GbTfOKHheiSlXQypHTz+VLVh0HQq9
VGpEFt+TZ8iIQ6gH9Cgs
=NNud
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

--===============1005334989540769536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1005334989540769536==--
