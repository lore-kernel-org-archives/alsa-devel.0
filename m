From: flameeyes@gmail.com (Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: [PATCH 1/2] Remove definition for surround sound
	devices on ICE1712.
Date: Tue, 20 Jan 2009 13:54:31 +0100
Message-ID: <m2ocy29lyw.fsf@gmail.com>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<1232455075-27712-2-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201339310.8466@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4119132941721843349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B0D2434E
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:53:27 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPG6f-0003g8-OB
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 12:53:25 +0000
Received: from ppp-196-234.21-151.libero.it ([151.21.234.196])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 12:53:25 +0000
Received: from flameeyes by ppp-196-234.21-151.libero.it with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 12:53:25 +0000
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

--===============4119132941721843349==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela <perex@perex.cz> writes:

> ICE1712 has 8 independent outputs, so why surround definitions do not=20
> make sense?

Because ICE1712-based cards have, physically, two RCA and one S/PDIF
jacks for input, and the same amount for output.

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkl1yYwACgkQe2h1+2mHVWPPEACgom3qrO3xEehCSHFh4OQMbaCU
D78AnjMlfpQriYWUAzd23V+5inQU6rl0
=ECj4
-----END PGP SIGNATURE-----
--=-=-=--


--===============4119132941721843349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4119132941721843349==--
