From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: blackfin: Remove unused
 bf5xx-{i2s, tdm, ac97}-pcm.h
Date: Thu, 30 May 2013 11:47:03 +0100
Message-ID: <20130530104703.GE5180@sirena.org.uk>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
 <20130529192726.GA5180@sirena.org.uk> <51A70402.2070901@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1674160126511448907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 17F5F265127
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 12:47:18 +0200 (CEST)
In-Reply-To: <51A70402.2070901@metafoo.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Steven Miao <realmz6@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1674160126511448907==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2013 at 09:47:14AM +0200, Lars-Peter Clausen wrote:

> Hm, where exactly are you getting conflicts? If I download the patches as
> they are in the ml-archive and run git am on them on top of topic/blackfin
> everything applies cleanly.

Patch 3 IIRC.

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpy4kAAoJELSic+t+oim96gUQAJAcqO/XNfCLuVCd3sVTf0yy
tgNsb+kOi3R7MuiS/Kc8I+c5/kJxXTGTwBMQXdW+weG5jpty8Sjvb9puH5/+jSF6
jmOyze77IJm75zode0daTH9pVefHY1IV6JJWD2sKf4bv6wzc1kO2M5Qilt48ylhP
BlwX4FgR1V5VFNI+R620JXbrDwX2/+M6u7v8A/jYgqjmDjU4A4OTjiGwYpQ069FL
JMPcXzTuHfwFTVY6xo+zg5N48MdFGh1dodJ4DDquZ/29goT9ufd11f3WFbx7+Plf
+tN5e2dT21LDmLq7Jhh7LTpqDg96iBX/H1sUbtt0+svlrfnNqDz1+nE+b9XeElz9
eFrSNUEAGQObIm5i+7LjQHlTzk5xSKG+GoK0SrN5qFxbg+pb8gSX5eBLSn1WHBSu
lVkPehnWLDhauEXbm+ByjoMGVMp6Ob0mWWTbqoCzELQegMEA0H7N7+8RZNXZUZtK
+hjJ0n35c6+HHr/H4DldBLcw2LDhk0aaJhaXZRqZNuX7u60OB+HxOMLGWODjsq6T
Ip9IqFuACss9mf7jgoB8cg9ieu9GqtnLYR78C35YXFkiOXXSpXcKc6yTvpk0R+rs
4KOMqs6syExIq2EQdLTcUWh4GCU2V7/U7IVrEWJr7xfMyEoFaRPi3oMKFQ2/0pCh
XX0BLXGMjo6V6IpUpXvD
=5nVQ
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

--===============1674160126511448907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1674160126511448907==--
