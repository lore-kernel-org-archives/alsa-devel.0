From: Jan Zuchhold <Jan@zuchhold.com>
Subject: YMFPCI: IEC958 volume does not work anymore
	(2.6.18->2.6.21)
Date: Fri, 20 Jul 2007 09:22:43 +0200
Message-ID: <200707200922.48147.Jan@zuchhold.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4793817315115954307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.dmz.labffm.de (ad96e004c.dsl.de.colt.net [217.110.0.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 818DB24366
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 09:23:23 +0200 (CEST)
Received: from localhost (smtp.dmz.labffm.de [192.168.10.73])
	by smtp.dmz.labffm.de (Postfix) with ESMTP id 12C5A16864
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 09:23:23 +0200 (CEST)
Received: from smtp.dmz.labffm.de ([192.168.10.73])
	by localhost (smtp [192.168.10.73]) (amavisd-new, port 10024)
	with ESMTP id 31116-02 for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 09:23:23 +0200 (CEST)
Received: from echo.ke.zuchhold.de (unknown [192.168.10.34])
	by smtp.dmz.labffm.de (Postfix) with ESMTP id A63D92A29
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 09:23:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============4793817315115954307==
Content-Type: multipart/signed;
  boundary="nextPart1803485.3ocYQtbI4M";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1803485.3ocYQtbI4M
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

i'm using a Hoontech Soundtrack Digital-XG (YMF744) and after i've upgraded=
 to=20
kernel 2.6.21, i can't control the IEC958 volume (using "Wave volume") any=
=20
longer. It seems to be always at maximum volume. The volume control of the=
=20
analog output port works fine.

This is working in 2.6.18, that i've used before. Something must have chang=
ed=20
in between.

Is there anything I can do to help to get this working again?

Thanks alot,
Jan

--nextPart1803485.3ocYQtbI4M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGoGLIQ65WEO0u/U4RAnlSAJ9s8x760vHyYSN9KPfdeAA0IyLWEwCgyFOi
mBdWwLkgxhjc2lc4sxJ8QZg=
=Kt6g
-----END PGP SIGNATURE-----

--nextPart1803485.3ocYQtbI4M--

--===============4793817315115954307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4793817315115954307==--
