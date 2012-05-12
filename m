From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/3] Add device tree support for mxs
	audio
Date: Sat, 12 May 2012 11:05:25 +0100
Message-ID: <20120512100524.GB1781@opensource.wolfsonmicro.com>
References: <1336746258-23970-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4562744556448834816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E00FC243E5
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 12:05:27 +0200 (CEST)
In-Reply-To: <1336746258-23970-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4562744556448834816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2012 at 10:24:15PM +0800, Shawn Guo wrote:
> Changes since v1:
> * Rebased on sound/for-3.5, and consequently the patch of devm_clk_get
>   is dropped.
> * Fixed the issues caught by Dong (Thanks to Dong).

applied, thanks.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrjXdAAoJEBus8iNuMP3ddgEQAJLia+IVbUH5oFkjt+NSALjX
UVnFXr5SfNsGW/IWEQ43/gnYqZdoj+YKHfW2df+1zJAvDXZqZ00mu9PxxQCCMriR
RxfuWciBmVOMWsrjS0CDl9OXFX5m4KxOBkoBCZ2i7Pzz0/JzQO8Bah+R4zxYui5m
Vjl2EvGPNurI6TIVJaSNaiYVcDfME73l35B8yCqidbzbhVqjfNmz/hIr4sz/AUBr
MJ9U0m1bx9tVXrxWD38HHVV82QPR0XXy3IG0C0PIRlsshDis7qZBSCeJtEUUxA6b
urFy2EQt4gIhlJv0ItPsKQgvJIuIYN+Szx2flJw32mIT2AFCwS+jsP5tFQdhSGmZ
iUmJh4PDUdtajdFHUIrVCR0yBzDOaQlrFsyjcc3F+xOyIRpEjej5fiKGbRhKa+eT
uKLyKG0VlE8GRiQIFgOCLDq0fTylEpYBh6BCcienVanJ0pNisqYK9jaPJbO9gXa4
Y8YS96t9Fe77hwlKkqC4ofu0/RbxesrP1imsM1jjveJ/Mo+mq15EfjDReZs56wAY
KwXn0gJBSMc2lDQ+WHXfMLNpbQACXdm6aofpjpZt9hjz9Zogl7ULo0NWkhtjKb3b
jg87pIctc5ji4kT3YGJqZH5aVLDA/ngQwQUGZILIb13eails+QFzT9RBjlWp/vWq
039Elw/fl1lYa6oN2r44
=88IL
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

--===============4562744556448834816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4562744556448834816==--
