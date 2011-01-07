From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Alsa hda-analyzer and Lenovo G560
Date: Fri, 07 Jan 2011 11:27:47 +0100
Message-ID: <1294396067.3699.11.camel@mattotaupa>
References: <9535194.21856.1294349877701.JavaMail.root@email.acmecargo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5251155341210201748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DBAC24154
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 11:27:50 +0100 (CET)
Received: from f053042130.adsl.alicedsl.de ([78.53.42.130]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Pb9Xx-0004Ry-5o
	for alsa-devel@alsa-project.org; Fri, 07 Jan 2011 10:27:49 +0000
In-Reply-To: <9535194.21856.1294349877701.JavaMail.root@email.acmecargo.com>
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


--===============5251155341210201748==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Qxud755tAHU0VxqGZlC5"


--=-Qxud755tAHU0VxqGZlC5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear WH,


Am Donnerstag, den 06.01.2011, 16:37 -0500 schrieb WH Bouterse:

> A change in run hda-analyze script

do you mean HDA Analyzer [1]?

> today 01/06/11

As far as I can see there was no change [2].

> has rendered internal mic inoperable again for Lenovo G560

What distribution do you use and what changed? Please be more specific.

> It has been necessary to run script upon each reboot to gain use of the i=
nternal mic.

Please post in more detail how the script is run on your system.

> This was the known problem being worked on.

Is it documented somewhere in a bug tracking system? Please post links.

> Once again if I sent this to the wrong place I apologize and please direc=
t me to the right list.

I think it is the correct list. I think your microphone problem should
and can be fixed differently by patching the Linux kernel.


Thanks,

Paul


[1] http://www.alsa-project.org/main/index.php/HDA_Analyzer
[2] http://git.alsa-project.org/?p=3Dalsa.git;a=3Dlog;h=3DHEAD

--=-Qxud755tAHU0VxqGZlC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk0m6qMACgkQPX1aK2wOHVhd3wCeNZKIxFgwKRkPhyD8UtGugqJd
BokAnjoBLfWBSMny22B/3SElilA0pyIu
=txnO
-----END PGP SIGNATURE-----

--=-Qxud755tAHU0VxqGZlC5--


--===============5251155341210201748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5251155341210201748==--
