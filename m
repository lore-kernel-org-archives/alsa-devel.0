From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: M-audio Fast Track Pro
Date: Tue, 26 Apr 2011 10:29:01 +0200
Message-ID: <1303806541.4073.22.camel@mattotaupa>
References: <BANLkTikV1twGp1rxKcubWVD6_8yxJBfYtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8003410593284645369=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CF0610385A
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 10:29:04 +0200 (CEST)
Received: from f053033081.adsl.alicedsl.de ([78.53.33.81]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QEdeV-0003dU-Nz
	for alsa-devel@alsa-project.org; Tue, 26 Apr 2011 08:29:47 +0000
In-Reply-To: <BANLkTikV1twGp1rxKcubWVD6_8yxJBfYtQ@mail.gmail.com>
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


--===============8003410593284645369==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9aOlJwN6XoFm7XVOxjeq"


--=-9aOlJwN6XoFm7XVOxjeq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Andreas,


Am Dienstag, den 26.04.2011, 09:58 +0200 schrieb Andreas Brudin:

> I was wondering how one would go about trying to get 24-bit support
> for the M-audio Fast Track Pro merged into the kernel? A (by now
> rather old) patch exists to enable 24-bit support, and Joe Giampaoli
> has written an excellent howto at
> http://www.joegiampaoli.com/blog/?p=3D462 but it is still hard for many
> users to build a custom kernel.
>=20
> It is a nice low-to-mid-range audio interface for hobby musicians, and
> it is still available in the stores, and I guess it is quite common
> out there, so it would be great if it became supported out of the box.

I do not know what the current state is since I thought there were lots
of patches send to the list regarding support. If the patch is still
needed, please send it to this mailing list formatted using `git
format-patch` and with a proper commit message and Signed-off-by lines.
The procedure is documented in [1][2].


Thanks,

Paul


[1] http://www.kernel.org/doc/Documentation/SubmittingPatches
[2] http://en.opensuse.org/openSUSE:Kernel_git

--=-9aOlJwN6XoFm7XVOxjeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk22gk0ACgkQPX1aK2wOHVgQVQCfRqMS53COJl8AvgSVxXJ7wNv4
ES8AnjdsGFF50TpRA82v0thzFq7WVCqe
=PXhg
-----END PGP SIGNATURE-----

--=-9aOlJwN6XoFm7XVOxjeq--


--===============8003410593284645369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8003410593284645369==--
