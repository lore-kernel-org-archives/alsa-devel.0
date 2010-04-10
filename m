From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: wrong decibel data?
Date: Sat, 10 Apr 2010 08:59:06 +0200
Message-ID: <4BC021BA.2060405@yellowcouch.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>	<r2u4f3252891004090649p3f327273x3af60905a06045fe@mail.gmail.com>	<4BBF5F81.1010205@yellowcouch.org>
	<w2z4f3252891004092125m64119a5dp7b6fba6da65d3bc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4174127646231559271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C6E410381B
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 08:59:56 +0200 (CEST)
In-Reply-To: <w2z4f3252891004092125m64119a5dp7b6fba6da65d3bc7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4174127646231559271==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9B10B32ED462B50991172975"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B10B32ED462B50991172975
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Raymond Yau wrote:
> Floating point numbers provide a way to trade off signal-to-noise ratio=
 for
> an increase in dynamic range. For n bit floating-point numbers, with n-=
m
> bits in the mantissa and m bits in the exponent
>  =20
That is an excellent point !
It is however not how data is stored on CD's, nor sent to many
soundcards :-(

Werner,-

--=20
http://werner.yellowcouch.org/



--------------enig9B10B32ED462B50991172975
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvAIbsACgkQ2TDF0fTmy3XaGQCdEXKaJu4wQjnkxmW4VkzZ6VPE
6VcAmwYF05JXts4cHhXvJV1Tdb5su/+V
=IAGo
-----END PGP SIGNATURE-----

--------------enig9B10B32ED462B50991172975--

--===============4174127646231559271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4174127646231559271==--
