From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: 2.6.19-rc1: hda_intel: azx_get_response timeout,
	switching to polling mode...
Date: Thu, 5 Oct 2006 10:05:50 +0200
Message-ID: <200610051005.50798.prakash@punnoor.de>
References: <200610050954.57677.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808882429=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5554F17B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 10:05:58 +0200 (MEST)
In-Reply-To: <200610050954.57677.prakash@punnoor.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org, Linux List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============1808882429==
Content-Type: multipart/signed; boundary="nextPart19335360.7vDRZ2smgD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart19335360.7vDRZ2smgD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 05 Oktober 2006 09:54 schrieb Prakash Punnoor:
> Hi,
>
> I didn't get above message with 2.6.18. Usign irqpoll above message doesn=
't
> appear, but I think neither it optimal.

On another boot I get:

Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22=20
13:55:50 2006 UTC).
ALSA device list:
  No soundcards found.

Perhaps because of pci multithreaded init? But the soundcard works normally.

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart19335360.7vDRZ2smgD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJLzexU2n/+9+t5gRAodbAJ43c+P3zkDN7p4QACL7JnDifJ5WkQCgv1SN
tKt2oV6St3qGTesCgJMIpco=
=fZg8
-----END PGP SIGNATURE-----

--nextPart19335360.7vDRZ2smgD--


--===============1808882429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1808882429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1808882429==--
