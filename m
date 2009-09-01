From: Jure Koren <jure@hehe.si>
Subject: ALC262 models
Date: Tue, 1 Sep 2009 14:59:13 +0200
Message-ID: <200909011459.14156.jure@hehe.si>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8381173128373075630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vimes.neko.si (vimes.neko.si [213.161.22.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4550A244DD
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 14:59:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by vimes.neko.si (Postfix) with ESMTP id 44642BBB3A
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 14:59:19 +0200 (CEST)
Received: from vimes.neko.si ([127.0.0.1])
	by localhost (vimes.neko.si [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 10776-09 for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 14:59:15 +0200 (CEST)
Received: from inna.localnet (89-212-110-65.static.t-2.net [89.212.110.65])
	by vimes.neko.si (Postfix) with ESMTP id A37C1BBB1E
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 14:59:14 +0200 (CEST)
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

--===============8381173128373075630==
Content-Type: multipart/signed;
  boundary="nextPart1581498.ky4MQjhm3N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1581498.ky4MQjhm3N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

I've received a Vaio P netbook recently, which contains an ALC262 of an=20
unknown model. Playback generally works out of the box, but I haven't yet=20
managed to raise the capture level for the internal microphone (though it's=
=20
easy to rev up the passthrough channel which makes a nice white noise witho=
ut=20
any feedback).

What I'd like to know is how difficult would it be for me to actually get t=
est=20
out more channels than are available with any particular model=3D parameter=
=20
setting. Some other chipsets include model=3Dtest or model=3Ddebug, but not=
 this=20
one. Also, is there a tool that could help me probe around the chipset to=20
properly identify available mixer channels?

If poking the code is the only way, that's ok, but I guess it'll have to wa=
it=20
until I have some time available.

Thanks for any pointers in advance.

Best regards,

=2D-=20
Jure Koren, unix developer


--nextPart1581498.ky4MQjhm3N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqdGqIACgkQ9iFCvmuhrCLsJwCfZstPlBexPYnbitRR8eP1F2sX
SooAn2/wwPhbEezjjee+tBDeTksLTI0K
=hs7H
-----END PGP SIGNATURE-----

--nextPart1581498.ky4MQjhm3N--

--===============8381173128373075630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8381173128373075630==--
