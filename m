From: Sebastian Benoit <benoit-lists@fb12.de>
Subject: Juli@-Card and hanging process snd-ak4114/0
Date: Thu, 10 Mar 2005 18:03:32 +0100
Message-ID: <20050310170354.GH78387@mail.webmonster.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Received: from mail.webmonster.de (datasink.webmonster.de [194.162.162.209])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 7318E1B2
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 18:03:33 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I already reported this in a note to issue 930 of the ALSA bugtracking
system:

I've a Juli@-Soundcard working with the current CVS-driver.

The main problem is, that a process "snd-ak4114/0" is using 60% of my CPU
time. I would like to solve this problem, and have started reading trough
the code. But it seems I need some pointers where to look ;-)

/Benno
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0xD777DBA7 2003-09-10 D02B D0E0 3790 1AA1 DA3A  B508 BF48 87BF D777 D=
BA7

Democratization of the internet must be opposed at all costs. The
infestation ecommerce was bad enough, but to allow regular people to post
their diaries online -- well, that's simply intolerable.

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (FreeBSD)

iD8DBQFCMH36v0iHv9d326cRAmDGAJwLccpRzrqQYfKJbfzjbms0hGFUBwCgqJvn
J3Oc5hk/qAyR9HJzZOnPo+M=
=B3Es
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
