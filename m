From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - cleanup platform debugfs on
	probe failure.
Date: Fri, 2 Mar 2012 16:20:46 +0000
Message-ID: <20120302162045.GB6056@opensource.wolfsonmicro.com>
References: <1330704824-29931-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2853706666840961077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87A622454E
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 17:20:47 +0100 (CET)
In-Reply-To: <1330704824-29931-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2853706666840961077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02, 2012 at 04:13:44PM +0000, Liam Girdwood wrote:
> Make sure we cleanup the platform debugfs when probe fails.

Applied, thanks.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUPNUAAoJEBus8iNuMP3dWxQP/iGwwrKlj2nqnQLyoQEOShJt
pJZ4kETV4/yJdGrsCWZvnBAi8DKmoLfKrUBCVBYUODP/WOovZhokJ0LIMMwRnwmb
wx7rh6Tqwb6++kAss+vYKCWStrJoxhqhPmsCeuzmK2zYo3EhPLaKpLBZnl/9sy1u
7fu+TD01dgc7/tYTdc38WLbvEq+XBh8PJ1tWG/L/IxnPZQQ745ADIhC44LB6bjqC
zrnijFttoF1lx6MUr7srhQdyt92x3FeUdPnRn0S3FlNvstrwzlNOAv9h47yilRS0
vnJZO3do/AdsFPXZqVXnWp4neRTqFv6seMoRJjlYd6CYoZ2xiKtqix9GcIiux9m8
B8mfIKgpzgz201wSM1qnRg75f9vRDdLmMxO9wlamYwXmquKWuSXtxrNSdE7vVigy
q3KZO92N329970uW+u3IClZHVdrYxdov48DjgBjEic+cMjb7g5iSoMaD5nyPhWoc
QiTrccqg5FvAptdLNVdDtbrYTnmBB0dWuDP+nv5wWXxCaFAvGrcvTbX4YefaDklm
hOj70qv1DVy0tNFgxte7g+S4AVei2GMM8Q4yPd8Oy3nZhbb4iCXO2nHtONci4Nuk
aYbqW3WqO0upCUm1LKYuKJM5TSGAwpOYLtO4xqrQ0hP4nUXfDJX2hplSoNwQhXf3
Otr5NJz2OUQrWXUwAT1s
=8ahO
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

--===============2853706666840961077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2853706666840961077==--
