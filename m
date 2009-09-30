From: Laurent =?iso-8859-1?q?L=E9onard?= <laurent@open-minds.org>
Subject: Some bugs with Auzentech Prelude
Date: Wed, 30 Sep 2009 15:46:24 +0200
Message-ID: <200909301546.28038.laurent@open-minds.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0409846788938133541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns351959.ovh.net (ns351959.ovh.net [91.121.78.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 24CD01037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 15:46:28 +0200 (CEST)
Received: from [192.168.1.10] (213.219.135.79.adsl.dyn.edpnet.net
	[213.219.135.79])
	by ns351959.ovh.net (Postfix) with ESMTPSA id D16A97B5EA
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 15:46:29 +0200 (CEST)
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

--===============0409846788938133541==
Content-Type: multipart/signed;
  boundary="nextPart1865041.sVRV4VCEPh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1865041.sVRV4VCEPh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I just bought an Auzentech Prelude and compiled a 2.6.31.1 kernel to test i=
t.

Analog and digital outputs are working but I experience some problems:
=2D There are some lags when I play long tracks on Amarok.
=2D Sometimes the track suddenly play slower for a time and go back, or not=
, and=20
I have to pause and play to fix it.
=2D Sometimes there is noise (only) for a time when I play a track, then it=
 go=20
back after a while.
=2D I was unable to play an audio file correctly with VLC, the sound is ver=
y=20
saccaded.
=2D No sound at all with Flash and Iceweasel.

Are they known bugs ? Are there plans to fix them ?

Thank you,
=2D-=20
Laurent L=E9onard

--nextPart1865041.sVRV4VCEPh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrDYTAACgkQKEZvGlTCoYUbZgCfeKyHBIO06nxGzT9dVp9bGT8+
rJAAn0qRKiQInwDKRchrWO9znZHlCq+q
=sp8D
-----END PGP SIGNATURE-----

--nextPart1865041.sVRV4VCEPh--

--===============0409846788938133541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0409846788938133541==--
