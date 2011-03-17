From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Asus E35M1-M Pro and Realtek AL887-VD - no love
 from ALSA for Sourround
Date: Thu, 17 Mar 2011 22:55:04 +0100
Message-ID: <1300398904.17833.10.camel@mattotaupa>
References: <4D7FB076.30300@codeaurora.org>
	<20110316103814.GA8369@sirena.org.uk>
	<1300273162.9428.10.camel@vkoul-udesk3>
	<20110316115627.GC14125@opensource.wolfsonmicro.com>
	<AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
	<20110316175357.GB15605@opensource.wolfsonmicro.com>
	<4D819CF2.3040306@tlen.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1080143576457945051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id A4701103999
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 22:55:07 +0100 (CET)
Received: from f053044253.adsl.alicedsl.de ([78.53.44.253]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q0L9u-0006qD-4A
	for alsa-devel@alsa-project.org; Thu, 17 Mar 2011 21:55:06 +0000
In-Reply-To: <4D819CF2.3040306@tlen.pl>
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


--===============1080143576457945051==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NV/9e7+iRVmAjJx8dLWb"


--=-NV/9e7+iRVmAjJx8dLWb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Wojciech,


please do not hijack threads [1]. Using Mozilla Thunderbird you can
easily compose a new message to a certain addressee by clicking on the
address <alsa-devel@alsa-project.org> in any of the messages.


Am Donnerstag, den 17.03.2011, 06:32 +0100 schrieb Wojciech Myrda:

> I recently purchased Asus e35M1-M Pro

OT: How do you like it? Any reviews you found useful on the WWW?

> and I would like to get souround sound going from my 5.1 system. I
> have it connected accordingly to the manual (line in - rear speakers,
> line out - front speaker, mic in - bass/center) but anywy I try that
> is using guides like http://www.gentoo-wiki.info/HOWTO_Surround_Sound
> I am not able to get sound from any other speaker then front left and
> right one. Alsamixer does not show any devices as shared to be
> available to switch to the output from input
>=20
> speaker-test plays every file in the left and right front speaker at the
> same time
>=20
> Here is my system information using  2.6.38-rc8-git3
> http://www.alsa-project.org/db/?f=3D0dd55b4640a8afff1552c4d0be0105e416ad1=
cf3
> and 2.6.38-rc8-next-20110314
> http://www.alsa-project.org/db/?f=3Da8733bf0083929540948f51b5f33d9c8a62d9=
994

Please additionally attach those files next time, since the developers
(I think at least Takashi) prefer it.

> My question is what should I try next?

If I understood it correctly it does not work yet [2]. If this explains
the issue for you please update [3] and you could also submit a report
to the Gentoo bug tracking system (BTS). Maybe some developer will
implement this. You could also figure out if there exists a ticket in
the Kernel BTS and submit a feature request or, if it already exists,
follow up there.


Thanks and good luck,

Paul


[1] http://en.opensuse.org/openSUSE:Mailing_list_netiquette
[2] http://sourceforge.net/mailarchive/forum.php?thread_name=3D4D3F1702.109=
0309%40gmail.com&forum_name=3Dalsa-user
[3] http://www.gentoo-wiki.info/HOWTO_Surround_Sound

--=-NV/9e7+iRVmAjJx8dLWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2CgzgACgkQPX1aK2wOHVj4TACfdNDwsK486ALvxQUxhdg/Zys+
U6IAni/r4z4F08w05AYIZ4LSZ/qkHuT/
=E1ZS
-----END PGP SIGNATURE-----

--=-NV/9e7+iRVmAjJx8dLWb--


--===============1080143576457945051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1080143576457945051==--
