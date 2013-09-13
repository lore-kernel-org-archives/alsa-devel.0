From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: trace: Make sure trace header doesnt
 depend on any headers
Date: Fri, 13 Sep 2013 18:27:04 +0100
Message-ID: <20130913172704.GN29403@sirena.org.uk>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379092188-7385-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5479767892797404870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B56D72608EC
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:27:06 +0200 (CEST)
In-Reply-To: <1379092188-7385-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5479767892797404870==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZTJVE4c8IMEntwwM"
Content-Disposition: inline


--ZTJVE4c8IMEntwwM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 06:09:46PM +0100, Liam Girdwood wrote:
> Fix build so that asoc trace event header doesn't depend on other headers.

Applied, thanks.

--ZTJVE4c8IMEntwwM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM0rlAAoJELSic+t+oim9A44P/1Rl1sBzS32/ACnOZY3V7xb0
lHXtQIGw5cSFyP64LRxkEXUnuMy9hejVB4gz1lovvqVbURf3KG8uXf0fPH1UZVL4
eg9hifg2VE7zXFDgzxXOm9WQx/SCTVZ1YmmXaZDH6fpUcItt9Jm/QAibgp2zd+JO
A+JKjHkvhnG2WBSJ004WZIi5+l1k8Z1Sx6sWFzuFD/teRqVwwZRvuGk8HI4nIyCy
Ad4imKja4OI690MRvJ5LFAtKMkfJhWtEbclFl5AxaC1jMVmNwbbOftTe8TJhoN3f
Pcg2JQqjkSzX6GzB4B523RAS4wxLgjXS5fFXY2oiqFMO3KB5+scuwkMr9CVP0ccD
ScJ2GR4BCbacchalltqXm6qVd8Dh5DnrcuDcDDOus6b4MKGaMTqLy41bGscO0k7E
ZpKuKjm/3yAqg9pV47Cxfhyk/QXGXDXj44f/HJsQJrHfuWHABA21cZnIlH5WZBzF
j4x6NIM9zhemZ75owX+XfWae/xqfQGlLjYZ9naJQ4V7BLC32bKl5DwbPo04t/oA1
VEab7URQ4O/DIQ8mThcSFaogPhj/Ws2YS37noEzbFI07qIWQuXtPp1sm2F4nFM/R
Tbvw0TulrJ83zQ/M0qDz4HoWqyO20yAc7As78w7kfyMWjyPASjBYXqXk3MLVTSZw
2n5eabnZGd2Z0x/wZ+SV
=fCZx
-----END PGP SIGNATURE-----

--ZTJVE4c8IMEntwwM--

--===============5479767892797404870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5479767892797404870==--
