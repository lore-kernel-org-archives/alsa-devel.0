From: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>
Subject: Altec Lansing FX5051 mixer
Date: Mon, 27 Aug 2007 09:23:59 -0600
Message-ID: <20070827152359.GA22496@rifetech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1056953093307205304=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a9.g.dreamhost.com (sd-green-bigip-66.dreamhost.com
	[208.97.132.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 00A87103883
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 17:23:57 +0200 (CEST)
Received: from kedri (d199-126-255-144.abhsia.telus.net [199.126.255.144])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id 3DBC0210AA
	for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2007 08:23:56 -0700 (PDT)
Received: from atrus by kedri with local (Exim 4.67)
	(envelope-from <atrus@rifetech.com>) id 1IPgRb-0005sE-VQ
	for alsa-devel@alsa-project.org; Mon, 27 Aug 2007 09:23:59 -0600
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


--===============1056953093307205304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I recently purchased an Altec Lansing USB Surround speaker set. (It's a set=
 of 5.1 speakers, with a built-in USB sound card). I've got about a week be=
fore the return policy expires and I'd have to return it.

The mixer doesn't work at all w/linux kernel 2.6.22, everything is locked a=
t 100% volume, which is pretty unhelpful, as it's the only way to adjust th=
e volume. (no analog controls).

Also, the digital control panel locks up when the speakers power up, furthe=
r preventing any access to the volume controls.

The device works out-of-the-box without any drivers under XP, so I have to =
so-far assume that alsa's usb-audio is missing something.

Any thoughts as to what could be wrong?

I'm more than happy to prod the device and submit any information I can ext=
ract about it, or even potentially opening the device up for remote access =
if a reputable developer is interested in examining it.

--=20
Jeremy Nickurak -=3D Email/Jabber: atrus@rifetech.com =3D-

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0uyPtjFmtbiy5uYRApuMAJ0cWGqmJ3nk2E2dGX8ATmdhtMhRVACdGhlC
jtYecsP8xosnaGOSld7DWEw=
=2NUZ
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

--===============1056953093307205304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1056953093307205304==--
