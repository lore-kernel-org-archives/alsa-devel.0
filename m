From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 078/102] ASoC: lm49453: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:05:46 +0900
Message-ID: <20140223030546.GS25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-51-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1580680898506068077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E74FC261606
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:06:06 +0100 (CET)
In-Reply-To: <1392723517-12772-51-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1580680898506068077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GS2n3+Rmx1iZ6rsA"
Content-Disposition: inline


--GS2n3+Rmx1iZ6rsA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:34PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--GS2n3+Rmx1iZ6rsA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWWGAAoJELSic+t+oim9XE0P/irubTee4LrCSFSZJPhxDOm+
KwZgb6gf8Xvu3v0qye2IBZJHEOGXKBAUzu8MlI0OTFNGQgkO3ZoKqbk/voFupIJZ
awEXb5oUf8DhBxjgNvxV0/vhlPqDSO+NWEyqGWDiHrc/o/FK+oJwIKv/2KLhoHPi
F6Bnkniq8/+MQXeCIk8ifo0snW1dMhEEcUhnp8x1btwcMatmUN8mZUj63Cps1Yi2
TYVc6GSRYKDxOJYIwBY3eiHXFKqmI4V1fTcpjv9gjAJ1jD5amKhvFfSPy/DxsByj
Cd8GjBXiQ6yjMJfhz95g9KqGteJCBPBLOWG+7ud+zuMvvUNBNPJrKA0CFVN4zwyP
pZd8zWJ5Oy7IOEjVDGimNtncUrw1Y1EeRrbOLbaIuJNicjLZWSk54zEGAIE0qDlH
mWdV8iliIDU26xsKQKkq3uALr6xmj8Vcg8OVFYA9MSEU6OH7mk7rWqzO/Sd3e1CA
fE1fPTGfed/DWlkOYaL8WlI1yR2PF8Tz8HA+pVDTahc8w1+ybRTDBUGi88zrb0yl
mSXhUOCqbVr31vYnOMuv8lzDTfH74EfyIfGTcvuQ9Z1PBnVUD+0h70hS5LBRjEGh
ec2Hxh0Af/0kmK2tjqtdIqnnWHmMF7qiI50CRY0YrbkSMS8LHjVfSef3YADKF4Wb
aOcOIcEv6UbUWSDTBLLe
=ygG6
-----END PGP SIGNATURE-----

--GS2n3+Rmx1iZ6rsA--

--===============1580680898506068077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1580680898506068077==--
