From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: A debug version of the ALSA lib?
Date: Fri, 02 Sep 2011 12:55:38 +0200
Message-ID: <1314960940.3526.27.camel@mattotaupa>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
	<4E5FB4AF.9620.200B1A2@olivier.myriad-online.com>
	<CACTFLAMSxfZ+NiYS_5e4CtMYDM5PeycLz=YSQu-PCsJbn_eKFA@mail.gmail.com>
	<4E60975C.8764.55CC5B@olivier.myriad-online.com>
	<CACTFLANvcWLEAtPuobu3j+m2608fB5oF7A1sQu8DeXj5u=Zbyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3066967789659918374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id E99C9103813
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 12:55:41 +0200 (CEST)
Received: from f053042120.adsl.alicedsl.de ([78.53.42.120]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QzRPa-0003uy-0h
	for alsa-devel@alsa-project.org; Fri, 02 Sep 2011 10:55:50 +0000
In-Reply-To: <CACTFLANvcWLEAtPuobu3j+m2608fB5oF7A1sQu8DeXj5u=Zbyw@mail.gmail.com>
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


--===============3066967789659918374==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-nZkjN/Kjcl9eL2xdVrF1"


--=-nZkjN/Kjcl9eL2xdVrF1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 02.09.2011, 12:43 +0200 schrieb Daniel Mack:
> On Fri, Sep 2, 2011 at 10:44 AM, Olivier Guillion - Myriad wrote:
> >> Or just use the binary Ubuntu packages and be done.
> >
> > Sorry, but what does it mean?
>=20
> That means that Ubuntu (as many other distros) offers you a
> ready-made, debug symbols enabled version of the library which you can
> just install and use. As you're struggeling with compiling the library
> youself, I'd suggest you go for this solution. In Ubuntu, the package
> you're looking for is called libasound2-dev.

I have not followed the thread, but if you want debugging symbol you
need `libasound2-dbg`. (`aptitude search libasound*`)


Thanks,

Paul

--=-nZkjN/Kjcl9eL2xdVrF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5gtioACgkQPX1aK2wOHVgoqACfWZER5R9+7xILOOytRIfwya2r
jxsAnRTzBzoXUO7hqqj4zkedpq6l2Sfa
=bK3h
-----END PGP SIGNATURE-----

--=-nZkjN/Kjcl9eL2xdVrF1--


--===============3066967789659918374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3066967789659918374==--
