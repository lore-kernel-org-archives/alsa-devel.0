From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: snd_hda_intel: wrong mixer controls
Date: Sun, 12 Jun 2011 13:07:33 +0200
Message-ID: <1307876853.10989.7.camel@mattotaupa>
References: <4DF4200B.90608@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8509851138636176187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FE12243A4
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jun 2011 13:07:36 +0200 (CEST)
Received: from f053045003.adsl.alicedsl.de ([78.53.45.3] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QViWw-000880-TB
	for alsa-devel@alsa-project.org; Sun, 12 Jun 2011 11:08:35 +0000
In-Reply-To: <4DF4200B.90608@comcast.net>
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


--===============8509851138636176187==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-U5JxqqKCzHPijdOEAMAD"


--=-U5JxqqKCzHPijdOEAMAD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Donn,


Am Samstag, den 11.06.2011, 21:10 -0500 schrieb Donn Washburn:

> This MB is a ASUS M4A87TD and a VIA VT1818 High Definition Audio 8=20
> channel CODEC which supports192Khz and 24bit BD Lossless Sound
>=20
> I have a problem with a new motherboard and openSuSE's 11.4 version of=
=20
> alsa (alsa-1.0.24.1-3.1.x86_64).  The sound is very good however, all of=
=20
> the mixers may be the problem.  The problem is that the pots of a mixer=
=20
> are all coming up incorrect.  Like the Line In is showing up as Mic 1=20
> and Master does work at all.

does *not*?

> I am including the output of hwinfo --sound to show modules are mount

[=E2=80=A6]

> Sorry about the length of this sound file
> I do hope this may offer an idea.  Is there a better module to try.
> Or is this all a KDE Kmix (one pot only) or gmixer (about 5 pots) problem=
.

please attach *and* upload the output of `alsa-info.sh` [1].

Furthermore you should submit a bug report to the Novell bugs database
[2][3].


Thanks,

Paul


[1] http://www.alsa-project.org/main/index.php/Help_To_Debug
[2] http://en.opensuse.org/Bugs
[3] https://bugzilla.novell.com/index.cgi

--=-U5JxqqKCzHPijdOEAMAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk30ne8ACgkQPX1aK2wOHVhUnQCcDqgcHMBOB3Wk+lcRnmUqviW/
zzYAnjm/97T3FLCDhmgifQpbUYSMGdY1
=2AVa
-----END PGP SIGNATURE-----

--=-U5JxqqKCzHPijdOEAMAD--


--===============8509851138636176187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8509851138636176187==--
