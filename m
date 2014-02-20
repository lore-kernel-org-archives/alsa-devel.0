From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 038/102] ASoC: max98095: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:27:13 +0900
Message-ID: <20140220022713.GQ2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-11-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5780087507441182604=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EF362656E5
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:30:55 +0100 (CET)
In-Reply-To: <1392723517-12772-11-git-send-email-tiwai@suse.de>
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


--===============5780087507441182604==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SeC9ahQqsPwp8xEB"
Content-Disposition: inline


--SeC9ahQqsPwp8xEB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:54PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--SeC9ahQqsPwp8xEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWf+AAoJELSic+t+oim9xhcP/jD/xuaxZhi8XA2L9zyqjNDL
nibJOxjlKvGr8Z3Ucdn9wkwY/jkGpdtLQQvCtXo4Zj3iHbEzcIEvu+kb9FGsKaXU
659CUCj7LHniTgk4xDv4//BphQ4yTduP1M39+YssefdUy3rbuR9c1Wgb/2fUS+As
/eA/609AuHvDhzPH+a/P7+UWNLVVjFzkZolhZC4z7ipsn9s2u2OZ/xj4cF290f0i
XG+bi7l4vi8GUouISX5g1EENWN8AJZ0g73j0km9fJk2U4efq+Xz/8Jqt8FyVLz8k
pSCc2thF0na0vzKCumbfIeNj6D0QEkHTrrgMeGjiyrVwb1miuGsUQh7lSj6GOgNm
0UnxD0SouZQLrMEDpG5irIdgwWAUpLtihxkWRRfx23wfD3btaV3r6qGL+wAlRpSn
yPMg2wzG2Xj5HtCQoeUmRolohZXWZSINOqtDQbEvS5dS269toriO7EvH4+nHUmZ1
fMVEr6LBYnExIsKt6gCgPjkri/171yZ7kE3qvDFoAhMpb2cxG+W5UMsnzWsw6ptN
jPJmkJt1v6Wa+79uTpNHNlKbaBC+fggRP5qtHjlOQsHUJFQLNZefPmai7Cu0GhR9
Fz8iVItquMfdkbLaQhTecpBPaCV2KI4r7k8s3RnPUmbMjp2hqr6EXHp3NUAPy5zi
vL9LtvlYARb+g02MOwF1
=Z9wL
-----END PGP SIGNATURE-----

--SeC9ahQqsPwp8xEB--

--===============5780087507441182604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5780087507441182604==--
