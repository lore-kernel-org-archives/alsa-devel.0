From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] ALSA: HDA: Add Sony VAIO quirk for ALC269
Date: Wed, 25 Aug 2010 10:55:03 +0200
Message-ID: <1282726503.3880.5.camel@mattotaupa>
References: <4C736D35.6000003@canonical.com>
	<1282638540.5459.0.camel@mattotaupa> <4C74D549.4000705@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2661814580617355381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D14B103851
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 10:55:09 +0200 (CEST)
Received: from f053042170.adsl.alicedsl.de ([78.53.42.170]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OoBlD-0002R8-OI
	for alsa-devel@alsa-project.org; Wed, 25 Aug 2010 08:55:08 +0000
In-Reply-To: <4C74D549.4000705@canonical.com>
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


--===============2661814580617355381==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-wNTTMIR4zK+FDZxN9K8z"


--=-wNTTMIR4zK+FDZxN9K8z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 25.08.2010, 10:33 +0200 schrieb David Henningsson:
> 2010-08-24 10:29, Paul Menzel skrev:
> > Am Dienstag, den 24.08.2010, 08:56 +0200 schrieb David Henningsson:
> >> The attached patch enables playback on a Sony VAIO machine.
> >>
> >> References:
> >> http://launchpadlibrarian.net/53762567/Card0.Codecs.codec.0.txt
> >> http://launchpadlibrarian.net/53762571/PciMultimedia.txt
> >> https://bugs.launchpad.net/bugs/618271
> >=20
> > Maybe add these references to the commit message too?
>=20
> Sure. I'll add the buglink only, since that one in turn points to the
> other ones. Does this one look better?

Perfect.

> Learning slowly, aren't I? :-)

I=E2=80=99d hope, I would learn as fast as you to support the project doing
programming. ;-)

Anyway, it was just cosmetic issue.


Thanks,

Paul

--=-wNTTMIR4zK+FDZxN9K8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkx02mcACgkQPX1aK2wOHVj19QCfe8ni5Uwxhhnjnoryd+u54VBF
nYsAnRq+hPvjG8GYF5W278j6WkDIXW7y
=VEBD
-----END PGP SIGNATURE-----

--=-wNTTMIR4zK+FDZxN9K8z--


--===============2661814580617355381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2661814580617355381==--
