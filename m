From: flameeyes@gmail.com (Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: More constants for alsa-lib
Date: Fri, 21 Nov 2008 22:55:49 +0100
Message-ID: <m2y6zcn3q2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389949076495158256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B4511037F6
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 22:56:02 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L3dyp-0001tj-CV
	for alsa-devel@alsa-project.org; Fri, 21 Nov 2008 21:55:59 +0000
Received: from ppp-13-236.21-151.libero.it ([151.21.236.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 21:55:59 +0000
Received: from flameeyes by ppp-13-236.21-151.libero.it with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 21:55:59 +0000
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

--===============0389949076495158256==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


git://git.flameeyes.eu/others/alsa/alsa-lib.git flameeyes

Diego E. 'Flameeyes' Petten=C3=B2 (6):
      Make seq, rawmidi and control operation structures static const.
      Make snd_pcm_hw_params_names static to pcm_params.c .
      Make all the PCM plugins ops structure constant.
      Make all the remaining ops structure constants.
      Make string arrays as constant as possible.
      Mark static tables as constant when possible.

(This time, signed off right away ;))

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkknLmUACgkQe2h1+2mHVWMG2ACfcbRcImh4NwirnI0K821aNWOD
8oYAoLRKHP6l19cs6JD3zLZxDFIF1V26
=Ae6R
-----END PGP SIGNATURE-----
--=-=-=--


--===============0389949076495158256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0389949076495158256==--
