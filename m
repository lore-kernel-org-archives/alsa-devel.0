From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsamixer and short slider
Date: Thu, 11 May 2006 17:17:43 +0200
Message-ID: <1147360673.4692.17.camel@johannes>
References: <1147358935.4692.2.camel@johannes>
	 <s5hvesc1u3j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MIuKN9g/wbucv2mPDvzt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvesc1u3j.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-MIuKN9g/wbucv2mPDvzt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-11 at 17:04 +0200, Takashi Iwai wrote:
> At Thu, 11 May 2006 16:48:45 +0200,
> Johannes Berg wrote:
> >=20
> > I have a capture volume slider that goes from 3 to 28, but alsamixer
> > totally buggers up with it and only displays 0,5,8,11 and 14 or
> > something.
> >=20
> > Is this a known bug? What should I do to fix it?
>=20
> alsamixer shows the volume in percent.  Isn't it the case?

Well, it tries to, but like I said, I cannot select anything but 0, 4,
7, 11 and 14, but for a range of 3..28 it should be selecting
approximately every 4 items from 0 to 100.

johannes

--=-MIuKN9g/wbucv2mPDvzt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGNVlaVg1VMiehFYAQL93g/+Nn1rV8+5QGOQQ/ZxmOE8zlcC0MCb2Ga/
D2wDOxmo4gDFboPeBBqEqUvGi7U86TTMbkxoqusI2OFCorEj8m9NgU8Aic6NP5ZD
3LHOhME08IVjkThRflZ6kXiuFq87w1swc6av+l9M7n5JwVqGqVYrFN8LhhvLwyU6
EUwGJu4fXGVEewHbeHeLcozo/s18ONqtJ8OtamkqJFfVHS+grzAFDAYxSdu23Umu
bAltlhmGoN2DCEw4oentimi4+ICay+Fm3Qfgu7MBaa7hBAjhxr8ZQxpDtciOaqva
BcU4TQ3NaoYg0yC0rNcO7Z75Fr8b9lLZPcb5NAQcfAymhhRGCJ2yZ2DJsfhj4V7Y
89ge3C3Apyp1jVQp7V6XpZw2Y5pFFovX9rzuxjQS03/psc/I/loLUV25Bq9iAI1h
NBl1SL5qPDrkyc85Cl/W+t8v68ZF/Z+QLJY+EJwYrnC+4tX5xZ4sSJPQhoK6VssH
1D6WXpP4r0es67Bf6Klsb7jHhSmJ2N/27sWMQ1hXH3fy9gv73U364Qw9Evt2elh5
q6Q+ADhKK1FEcQUVRL08E2bDj6NHkcDssBMBzBefiKMuChJ6JXjRMmhChzvYSd+6
uYssVpKq1ZUO/sBgKHshzNcfGJxW72pCKc74CCiMhaeqOGuU3lXZk+Mk/qGQ3efN
ZX6yWbWZdZ4=
=LfrR
-----END PGP SIGNATURE-----

--=-MIuKN9g/wbucv2mPDvzt--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
