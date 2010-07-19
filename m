From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: snd-hda-intel acl269 toshiba r700 speakers work,
 headphones do not
Date: Mon, 19 Jul 2010 10:17:36 +0200
Message-ID: <1279527456.3803.1.camel@mattotaupa>
References: <4C41F914.5040508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2536823511244106102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id D62492436C
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 10:17:41 +0200 (CEST)
Received: from f053034205.adsl.alicedsl.de ([78.53.34.205]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OalXg-0004m2-4n
	for alsa-devel@alsa-project.org; Mon, 19 Jul 2010 08:17:40 +0000
In-Reply-To: <4C41F914.5040508@gmail.com>
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


--===============2536823511244106102==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fIl+m+v6PRJwSune/em/"


--=-fIl+m+v6PRJwSune/em/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Thomas,


Am Samstag, den 17.07.2010, 11:40 -0700 schrieb Thomas Hoffmann:

> Sound works from the built in laptop speakers. When headphones are=20
> plugged in, the speakers properly mute, but there is no sound coming=20
> from the headphones. I've tried some of the options to the=20
> alsa-base.conf file to no avail; generally they made it so sound came=20
> out of the speakers always, even when headphones were plugged in.
>=20
> I previously sent an e-mail to this list server:
>      https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D5064
> where they suggested I e-mail you. My system info is available from
>     =20
> http://www.alsa-project.org/db/?f=3Df9aaf6e43b669cf2c4b2215781a414b12843e=
2a3

did you already try different values for the `model` parameter [1]?


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA

--=-fIl+m+v6PRJwSune/em/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxEChoACgkQPX1aK2wOHVizMACfVzKDj9zR92asFW668m8hFiAb
VesAn0qyGqLukSXpvvNAb0LjD6l0c4B0
=HG1k
-----END PGP SIGNATURE-----

--=-fIl+m+v6PRJwSune/em/--


--===============2536823511244106102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2536823511244106102==--
