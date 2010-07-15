From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 20:38:41 -0500
Message-ID: <1279157921.2668.1.camel@localhost.localdomain>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3154434475226043982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 7F39C1038C5
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 03:38:44 +0200 (CEST)
In-Reply-To: <AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
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


--===============3154434475226043982==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-aMF0RIvwi09qD8xS74XO"


--=-aMF0RIvwi09qD8xS74XO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:

> > I posted both of those bug reports. Honestly, I just want it to work
> > without all the error output to syslog and thrashing of my HD for
> > minutes at a time. As I said, I've got the output of pulseaudio -vvvvv
> > if anyone would like to look at it and tell me what I need to do to fix
> > the problem.
> >
> > Chris
> >
> >
> >
> Just upload your current pulseaudio.log and output of alsa-info.sh to
> mandriva 's bugzilla
>=20
> Cannot obtain any conclusion based on the log which you have posted last
> year ( xmms)
>=20
> as Jaroslav Kysela said , need the real system time between I/O operation=
s
> and you'll see if it's issue in the ALSA driver or a task scheduling
> problem.

Here is the bug report with the outputs uploaded.

https://qa.mandriva.com/show_bug.cgi?id=3D60169
--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-aMF0RIvwi09qD8xS74XO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw+ZpgACgkQ43Kn2pjmcFze/gCeN4fHFiDR3AZ17DaGnZJW08fx
gcEAoIGw5g5bAlBkYVq+XCG2hyKT2AqM
=7Edm
-----END PGP SIGNATURE-----

--=-aMF0RIvwi09qD8xS74XO--


--===============3154434475226043982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3154434475226043982==--
