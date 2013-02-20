From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: max98090: Make struct dev_pm_ops
	const
Date: Wed, 20 Feb 2013 16:58:47 +0000
Message-ID: <20130220165847.GN2726@opensource.wolfsonmicro.com>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
 <1361187134-7525-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7455478248808484805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3542261723
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:58:48 +0100 (CET)
In-Reply-To: <1361187134-7525-3-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============7455478248808484805==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WeDu0lr7bteb/II5"
Content-Disposition: inline


--WeDu0lr7bteb/II5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2013 at 05:02:12PM +0530, Sachin Kamat wrote:
> Silences the following checkpatch warning:
> WARNING: struct dev_pm_ops should normally be const.

Applied, thanks.

--WeDu0lr7bteb/II5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJQDAAAoJELSic+t+oim9LJAP+we0qwJXPZdA+g0LRs94lZY4
VPBas4Lm8gtvYOeHBrxPQ10J0EMhQenrkki5eusjVmsjlfkyEq1J6Yj2HNz9DDqM
BEGHPY2KK3v6Hse8+AjQiCuwl/xwtmJdr1oMJ0+aynRD4NPsscyBf6T9gAaWqVZV
2qxXpJ8nXBbQdocpnIGNQr0rH9CEnyvpNp+H/9J0DQ8c33KYCysZrWZilIthi0/k
gKFQ+9I731TbFEtvxTmPfB8hNrOaYhHGcVYl26N8ScyUEn2m7Z4hJohkI+V3H5Mo
1INlwubcofhDhMjlQa5LIm+am4xOA8Hu5GV53yeqAGk/l005/WKRV1MO3pgNFNIY
/NwL78uGPrf1ZHwt21hn1ZNEiPsowCiQ08zqJR4tF2NEYpJ1dOdJfNWHvblof80n
c7OijLBBlDg01fP4oGQIznCIT+9NVlQlxEku0ZmL9FaN23jiXYp5/T5V+g7v2cfG
4KpeOvHmwmLVKRxZ1tYaBFrveCa2pU03cKH1xyT92gTBAfGHider6uD6Pz/8nANt
K46BCtcrzV6WQHeCKfa4RzVoz6uZ3wjBsltDqdnB/niuLC9gtasueDm+68OYrPjx
C5OKcCF7QxlBtyXMBGPwHb902I7bmS3wcil0FOvP7Ns2x2mVWls7DX4zMqLJG6kY
x5h0qQEAkhQCeVy500fo
=ChM3
-----END PGP SIGNATURE-----

--WeDu0lr7bteb/II5--

--===============7455478248808484805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7455478248808484805==--
