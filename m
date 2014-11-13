From: Kip Warner <kip@thevertigo.com>
Subject: DTS-HD over HDMI
Date: Thu, 13 Nov 2014 11:51:18 -0800
Message-ID: <1415908278.3076.63.camel@kip-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3321487183162060483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a59.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 73DEB2660D1
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 20:51:21 +0100 (CET)
Received: from homiemail-a59.g.dreamhost.com (localhost [127.0.0.1])
 by homiemail-a59.g.dreamhost.com (Postfix) with ESMTP id E15C256405C
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 11:51:19 -0800 (PST)
Received: from [192.168.1.146] (unknown [69.172.169.61])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: kip@thevertigo.com)
 by homiemail-a59.g.dreamhost.com (Postfix) with ESMTPSA id B7BE4564057
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 11:51:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3321487183162060483==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-o+Qtoq5quY0zHnZI/uwg"


--=-o+Qtoq5quY0zHnZI/uwg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey list,

I apologize if this ought to have gone to alsa-user. I wasn't sure as a
developer using API, but not developing ALSA itself, if it have been
better there than here.

I'd like to be able to stream DTS-HD Master Audio bits out the HDMI port
in their compressed form, and not decompressed as LPCM. From what I can
gather, this may be possible with the ALSA API, provided the HDMI port
is >=3D 1.3 and the audio card supports high bit-rate (HBR).

Is my thinking correct?

--=20
Kip Warner -- Senior Software Engineer
OpenPGP encrypted/signed mail preferred
http://www.thevertigo.com

--=-o+Qtoq5quY0zHnZI/uwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlRlC7YACgkQLXnfK7bii21D9QCfRdLiez0AXiVpFKxZ4+MPzkhm
QbUAn1Ym69AvDFB15LWuPNWHGBl8NVFq
=Mh7X
-----END PGP SIGNATURE-----

--=-o+Qtoq5quY0zHnZI/uwg--


--===============3321487183162060483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3321487183162060483==--
