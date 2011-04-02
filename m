From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] hdspmixer: fix drawing problems with black
 background
Date: Sat, 02 Apr 2011 14:59:05 +0200
Message-ID: <1301749145.3996.35.camel@mattotaupa>
References: <1301653709.3951.52.camel@mattotaupa>
	<b3f40168e52421fa2468654f41f6269d7a03d62d.1301748214.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7721634423183697948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id BB1FF103839
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 14:59:08 +0200 (CEST)
Received: from f053042248.adsl.alicedsl.de ([78.53.42.248]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q60Py-0002or-Or
	for alsa-devel@alsa-project.org; Sat, 02 Apr 2011 12:59:06 +0000
In-Reply-To: <b3f40168e52421fa2468654f41f6269d7a03d62d.1301748214.git.tim@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7721634423183697948==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1RHDE/jVOjJj2/XB2aoq"


--=-1RHDE/jVOjJj2/XB2aoq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Samstag, den 02.04.2011, 14:44 +0200 schrieb Tim Blechmann:
> - use foreground color instead of black
> - HDSPMixerSelector: set colors before setting labels
>=20
> Signed-off-by: Tim Blechmann <tim@klingt.org>

[=E2=80=A6]

Reviewed-by: Paul Menzel <paulepanter@users.sourceforge.net>

--=-1RHDE/jVOjJj2/XB2aoq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2XHZkACgkQPX1aK2wOHVh43wCdH1HFiTWXL5UR9GaY/X++PLkX
w9MAoIfPihqv4/O9Dui1GhuxgRtvS2y7
=yItD
-----END PGP SIGNATURE-----

--=-1RHDE/jVOjJj2/XB2aoq--


--===============7721634423183697948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7721634423183697948==--
