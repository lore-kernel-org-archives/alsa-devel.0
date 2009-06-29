From: Nicolas George <nicolas.george@normalesup.org>
Subject: Bug #4560: USB webcam Philips SPC 530NC micro not
	working
Date: Mon, 29 Jun 2009 12:35:42 +0200
Message-ID: <20090629103542.GA19029@phare.normalesup.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7368939368001932284=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nef2.ens.fr (nef2.ens.fr [129.199.96.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 99C44103812
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 12:35:44 +0200 (CEST)
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
	by nef2.ens.fr (8.13.6/1.01.28121999) with ESMTP id n5TAZgnw057480
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 12:35:42 +0200 (CEST)
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


--===============7368939368001932284==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

Some time ago, I submitted a bug about the integrated micro of the USB
webcam Philips SPC 530NC:

record: pcm_read:1617: read error: Input/output error

This is bug #4560:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4560

I would really appreciate if someone familiar with the USB audio system
could give it some attention.

It is probably very similar to bug #3927. Raymond seems to have been able to
help somewhat, but the command that is said to work for the reporter does
not work for me.

Regards,

--=20
  Nicolas George

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpImP4ACgkQsGPZlzblTJPATQCgrbf+c+jFD5nAOA0ZMPIoi9jg
r+IAn2VF5xJxxZ/VV4kg+QIfLPA6bgmP
=F2f3
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--===============7368939368001932284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7368939368001932284==--
