From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: No jack sense Acer Aspire 7736ZG laptop
Date: Tue, 07 Sep 2010 14:15:54 +0200
Message-ID: <1283861754.3951.40.camel@mattotaupa>
References: <4C827206.9080300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340718851932283264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8698F243CF
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 14:15:57 +0200 (CEST)
Received: from f053042255.adsl.alicedsl.de ([78.53.42.255]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Osx5f-0007WK-Ug
	for alsa-devel@alsa-project.org; Tue, 07 Sep 2010 12:15:56 +0000
In-Reply-To: <4C827206.9080300@gmail.com>
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


--===============1340718851932283264==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-yvtxLDjtUIMoY9F5iH/5"


--=-yvtxLDjtUIMoY9F5iH/5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Hans,


Am Samstag, den 04.09.2010, 18:21 +0200 schrieb Hans L=C3=B6vhaga:

> Headphones doesn't cut front speakers.
>=20
> Have tried adding this line to alsa-base.conf
> options snd-hda-intel model=3D? enable=3D1 index=3D0
> (alsa-info script ran with above line commented out)
>=20
> Havent tried all available models for ALC888 but 3stack-dig and acer=20
> didn't change anything. acer-aspire gave no sound at all.
>=20
> Ubuntu 10.04
> Acer Aspire 7736ZG
>=20
> New install, problem was there from first boot.

you could open a report at Launchpad (and report back the number). I
have seen some patches sent to the list from the Ubuntu guys. Maybe you
will get their attention this way. Everyone is always quite busy.


Thanks,

Paul

--=-yvtxLDjtUIMoY9F5iH/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkyGLPoACgkQPX1aK2wOHViN9gCeI7v5XQLBUampgTX6T0F6TqzM
9tUAniIgiDGTPdJioNj4b1RsO+dGLxWh
=53Ed
-----END PGP SIGNATURE-----

--=-yvtxLDjtUIMoY9F5iH/5--


--===============1340718851932283264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1340718851932283264==--
