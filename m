From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] fix softfloat handling
Date: Mon, 16 Nov 2009 11:39:59 +0100
Message-ID: <4B012BFF.7090000@pengutronix.de>
References: <1258366495-10815-1-git-send-email-mkl@pengutronix.de>
	<alpine.LNX.2.00.0911161132150.4806@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0415159423657335336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 84DD910388B
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:40:32 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.0911161132150.4806@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0415159423657335336==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig53A1039852E20A0654FE4D98"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53A1039852E20A0654FE4D98
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela wrote:
> On Mon, 16 Nov 2009, Marc Kleine-Budde wrote:
>=20
>> Hello,
>>
>> this series of two patches fixes the softfloat handling within the als=
a-lib.
>> Please review and consider to apply.
>=20
> Both patches are applied to alsa-lib git repo now. I changed slightly o=
nly=20
> first patch (removed tab/space combining). Thanks.

wow, that was fast, tnx
Marc
--=20
Pengutronix e.K.                         | Marc Kleine-Budde           |
Linux Solutions for Science and Industry | Phone: +49-231-2826-924     |
Vertretung West/Dortmund                 | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686         | http://www.pengutronix.de   |


--------------enig53A1039852E20A0654FE4D98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAksBLAMACgkQjTAFq1RaXHPkJACdFmCHvpg70GyoOO808Lt/9ZPr
jywAnRP6oUGyT1xLr/Ugj6bGuHSgmMem
=B6Pk
-----END PGP SIGNATURE-----

--------------enig53A1039852E20A0654FE4D98--

--===============0415159423657335336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0415159423657335336==--
