From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Acer Aspire 7736: headphone jack not working (was:
	ALSA Help?)
Date: Thu, 15 Jul 2010 20:27:10 +0200
Message-ID: <1279218430.3741.31.camel@mattotaupa>
References: <AANLkTikoCl5PBL52HAIdxz50uNmJkL7r44TGiuAKO72j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7398820920634244511=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id C1786103816
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 20:27:16 +0200 (CEST)
Received: from f053040153.adsl.alicedsl.de ([78.53.40.153]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OZT9O-0002Ct-HQ
	for alsa-devel@alsa-project.org; Thu, 15 Jul 2010 18:27:14 +0000
In-Reply-To: <AANLkTikoCl5PBL52HAIdxz50uNmJkL7r44TGiuAKO72j@mail.gmail.com>
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


--===============7398820920634244511==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6zvhqj5sxhHfaAAbxKrS"


--=-6zvhqj5sxhHfaAAbxKrS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Matthew,


Am Montag, den 12.07.2010, 09:22 -0400 schrieb Matthew Hudson:

> I posted similar messages to the alsa-user mail list and to ubuntu forums=
 (
> http://ubuntuforums.org/showthread.php?t=3D1528442 ), but haven't been ab=
le to
> get help. Could any of you help with this?

I do *not* know a lot either. :(

> So, I've got a great Acer Aspire 7736. Seems to have a RealTek ALC888 car=
d &
> Intel HDA.
>=20
> I've upgraded Alsa.
> I've used the Drivers at the RealTek site.
> I've checked alsamixer over and over and over.
>=20
> Yet, currently I cannot get sound through the headphone jack.
>=20
> Originally, I had problems w/ headphone/speakers playing simlutaneously.
> Somewhere in my adventures I fixed that, but then only one app would use
> sound during a login (UGH). So, I kept poking...as all good linux users
> do...now I'm afraid I've totally wonked it.
>=20
> I'll put all pertinent alsa-info up here for anyone who will help!!
>=20
> http://www.alsa-project.org/db/?f=3D58850a92a9ea0edbf28a8d014a875cdbd81b6=
21d
>=20
> I guess I'm bright enough to really mess it up, but dumb enough not to ha=
ve
> a clue how to fix it.
> It has NEVER been able to recognize a headphone plugged in the jack
> automatically. I hope someone knows...

I do not thin the RealTek drivers are recommended. Can you try some Live
CD of some distribution and test different module parameters as
described in [1]?


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA

--=-6zvhqj5sxhHfaAAbxKrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkw/Uv4ACgkQPX1aK2wOHVjOQgCcCS+ZnodbqGb5zhNvOwTTnv9v
qEsAoIJ9kCe6NBe3oLk2/bHDE1mGIB88
=UvA2
-----END PGP SIGNATURE-----

--=-6zvhqj5sxhHfaAAbxKrS--


--===============7398820920634244511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7398820920634244511==--
