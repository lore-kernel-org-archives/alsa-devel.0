From: flameeyes@gmail.com (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Git branches with Gentoo fixes
Date: Thu, 13 Nov 2008 01:14:51 +0100
Message-ID: <m263ms5vno.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1536058799463782319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id AD7AD24480
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 01:25:04 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L0Q19-0005KX-7F
	for alsa-devel@alsa-project.org; Thu, 13 Nov 2008 00:25:03 +0000
Received: from ppp-13-236.21-151.libero.it ([151.21.236.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 00:25:03 +0000
Received: from flameeyes by ppp-13-236.21-151.libero.it with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 00:25:03 +0000
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

--===============1536058799463782319==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi all,

Since I have just had to fix (again) an --as-needed issues on alsa-tools
on the Gentoo ebuild, I've decided to clone the git repo and see to try
pushing (again, I'm sure I tried before) the Gentoo-specific patches.

You can find two git branches for alsa-tools and alsa-utils at these
addresses:

git://git.flameeyes.eu/others/alsa/alsa-tools.git
git://git.flameeyes.eu/others/alsa/alsa-utils.git

For the patches coming from users, the proper Author setting was done so
that they are reported coming from the correct contributor.

HTH,
=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkbcXsACgkQe2h1+2mHVWOHQwCgnffLxjmSHxKmpCDfwYtgSTAV
DIIAoMuCBeLCi11vxu9EfZffKxM9a0XW
=X2Yg
-----END PGP SIGNATURE-----
--=-=-=--


--===============1536058799463782319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1536058799463782319==--
