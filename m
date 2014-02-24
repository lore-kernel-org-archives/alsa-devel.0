From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add data field into snd_soc_jack_gpio
Date: Mon, 24 Feb 2014 10:28:40 +0900
Message-ID: <20140224012840.GP25940@sirena.org.uk>
References: <1393137644-20955-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6683306924849172192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CDCA26527F
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 06:34:39 +0100 (CET)
In-Reply-To: <1393137644-20955-1-git-send-email-xiaoxiang@xiaomi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiangxiao <xiaoxiang@xiaomi.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6683306924849172192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VXyBLKGsDMQc4YGk"
Content-Disposition: inline


--VXyBLKGsDMQc4YGk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2014 at 02:40:44PM +0800, xiangxiao wrote:
> so callback could get the context data as needed

> Change-Id: I5542613ccf9881deb672e71d0f0c4f603ad761fd

Applied, thanks, but as I said for your previous version of this
upstream submissions shouldn't have Change-Id, that is to do with your
internal review system.

--VXyBLKGsDMQc4YGk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCqBFAAoJELSic+t+oim9qPIP/RJ75j7ukT6OQCFGaNUY9vJ+
zrR/DWkEyDqDnclGMB+KgV/wk6/hHwlNSsTynOmAvmgueYHOc9bDXxdmttM5k2+0
u7bccpwBQSfAHw8CtVK/Rlkc9z6si9sWZEITQmQP0TsQTeWa3Uy4n0Zv5YYNTAH6
/nyVdO0G5T10+nehZLQ7qJiUjEwSUtRz5VKGWh7g9UtU1BpJgxhTnfrhpjM6YVyP
zlF8CuUP8/jK0EbvwoNni5RB99W3ccEQxIzk+AdG2g1vl+UmkJ6gHbtauc+mDfyc
0l0XJ5vslwbCT5ErKlUICxoNHNE4yUo7Pjq09ve+SpceFYH91ug0LUYVW13K0QDZ
182ehFGQGk6IFtRTrbK0sgZItGzvRkcyk+gHfQgiUVzFXeTSz51aH2ZI2m7RnEfU
3+umGyVc3eK5YK9PldAW1+u8LoLD3wmHUme9uZH/gtW+247Uc0qtPat1Va6iWr6y
ZyEjXDAGv4YII62tjmA2pjJlwaBWKRQ0A6DK5veusrPn9HGFDyXrwupa4f6GFOAn
XhkD8Ntbvhbaf6AJemhik6TCT4xxvhFtLXovC9ALXW2EGMYXjsjHaWxGrLPpcXfm
PmR9Z3HlqEaDTdFdMfW+SRwXc1Y8hm3BD+kIBciB2CWesQyEQEb9fDPv27//xNMZ
tDBX+xJO6jhU36QffmQZ
=3br7
-----END PGP SIGNATURE-----

--VXyBLKGsDMQc4YGk--

--===============6683306924849172192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6683306924849172192==--
