From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] pcxhr: fix trivial typo
Date: Sat, 31 Jan 2009 11:53:21 +0100
Message-ID: <49842DA1.1080500@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3964391790511565111=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DAFB24430
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 11:53:30 +0100 (CET)
Received: from [10.9.3.234] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-5) with ESMTP id n0VArT00018043
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 11:53:29 +0100
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3964391790511565111==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5192925D6480F2F4F4EFF200"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5192925D6480F2F4F4EFF200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/pcxhr/pcxhr_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr_core.h b/sound/pci/pcxhr/pcxhr_core.h
index bbbd66d..be01737 100644
--- a/sound/pci/pcxhr/pcxhr_core.h
+++ b/sound/pci/pcxhr/pcxhr_core.h
@@ -1,7 +1,7 @@
 /*
  * Driver for Digigram pcxhr compatible soundcards
  *
- * low level interface with interrupt ans message handling
+ * low level interface with interrupt and message handling
  *
  * Copyright (c) 2004 by Digigram <alsa@digigram.com>
  *
--=20
1.5.6.3



--------------enig5192925D6480F2F4F4EFF200
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmELaoACgkQdL+4qsZfVsvaCwCfRmjpEI3kkRL34iqt9ZKK6Bys
fZoAn0NfSzYbDxsytlOjyaWYet+SqS6V
=Fafp
-----END PGP SIGNATURE-----

--------------enig5192925D6480F2F4F4EFF200--

--===============3964391790511565111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3964391790511565111==--
