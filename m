From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adav80x: Convert to direct regmap
 API usage
Date: Sat, 21 Sep 2013 14:16:30 +0100
Message-ID: <20130921131630.GS21013@sirena.org.uk>
References: <1379676580-19008-1-git-send-email-broonie@kernel.org>
 <523C348D.3050502@metafoo.de>
 <20130920163947.GO21013@sirena.org.uk> <523C7CDE.50704@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5510898557095953716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7698C261717
 for <alsa-devel@alsa-project.org>; Sat, 21 Sep 2013 15:16:43 +0200 (CEST)
In-Reply-To: <523C7CDE.50704@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org


--===============5510898557095953716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1lNKaBMh+XZLvvpk"
Content-Disposition: inline


--1lNKaBMh+XZLvvpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2013 at 06:50:38PM +0200, Lars-Peter Clausen wrote:
> On 09/20/2013 06:39 PM, Mark Brown wrote:

> >> I have a, in my opinion, slightly better version of this patch, just hadn't
> >> had the time to test it yet. I also have regmap conversion for the adau1373
> >> driver.

> > OK.  Any ETA for those?

> Next week, maybe.

Great, thanks.

--1lNKaBMh+XZLvvpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPZwiAAoJELSic+t+oim9I9sP/jzEcLrRhjUi3PfEo3hYw4Vb
2JIVGh2RciloZM7qaV/ZRwZ7wx2JU39oKZ1HEkeYALYXo1KIXpLuGuiO5l603+2w
6tDBFWbnEKn6NBMdNLnRSYnX0aeAMagWCEuqdiclPBLhtgy0MJvbcz2vM+N/dP3p
KcS+G8TKQMJ+ZpCp20ZryTCwpR6tFzBMBK+UpZUoKFes5cn6dRcAVh1yTAVbMAMY
ZTDw5HexAtZUN/V+9UwR/ZaUiv+M86gM4k6+b8iHxv2MuMKR150h+Lv1eADnFdWE
3HVQVr3jyqYyG+JDVbWBUD1S01J9VG+wj6WeQWAq7+AJ//UGIb9WHQDHo29k08yp
6Dcfkb6xBADAFvHCu6IOYuSIdO3LjUz0ibIjUADJFUVAgTforqgTur8gGk9fNNXj
hHslexTDce17N+a6WSJA7C81maJo8lwXNTEx0kaIBlF60wDdXIvh6c07u2EYqz/h
1F1vrca/fhi2r/gybYYDuYxm5L5xmBh1ZJKc22v8rcs5hQbWAxLD3ckgb9YTJr0H
FWclZjDjcT1fOBqiYQc7SRL5NH8w8cIPc0L+i4BNp0cuTx4OVdWwymNvryBeTbRf
ykXC8lgLVKNuU5mAcakx/Fps97D6kvLE1OrwE6svgJo0dFGDnQlHaKO+oR3++NAS
XZJt2CGz4sknZ1drms/b
=QufP
-----END PGP SIGNATURE-----

--1lNKaBMh+XZLvvpk--

--===============5510898557095953716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5510898557095953716==--
