From: Johannes Berg <johannes@sipsolutions.net>
Subject: alsamixer foo
Date: Fri, 05 May 2006 11:51:55 +0200
Message-ID: <1146822715.1137.59.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h3aPQz/rHYks83H8UOIb"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-h3aPQz/rHYks83H8UOIb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Can anyone explain why, if I make an ENUMERATED mixer element and name
it 'Capture Source', it shows up under the Capture category in
alsamixer, but as two buttons of which one is only selectable? And then,
when I name it 'Input Source', it shows up as a single item where I can
select the right source, but it shows up under 'Playback'?

What's the correct naming for this thing? I've seen drivers use "Input
Source" and "Capture Source" too...

johannes

--=-h3aPQz/rHYks83H8UOIb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFsgOaVg1VMiehFYAQIqoRAAq+D3VFwEuUTFb6pKUzBM4OZ/iHF8bVix
ghUtZc//h5yZzqUbqskBgpDXcz2EWGJNd+PdKZtpvFWac7O4XPgprEa+xrRuhQZN
jVb9FjXeS3+fdOuKQvhVg1MD+AFNarFm1ZMa+3xOcH5kHaKckJ1wJjmVd666i+Qh
AUQhKa9LdOQSetwi9Zs7CTAW8p2WEUsInsVHo/PS/MtAa4wHe1fXvnrcbVUZlvUr
AErInwJD0gX1IiOfp36zyM9qpPRn+h43rYqC+xFKMJ21DbA2Y6d6bd3/ZrZdBh/H
nXlpjJFCmm870NT7AEFzunPYQP77m/Rw0IY3QqasNmrpCycu5pcbSwq2N7kNd5yZ
vudMqKIEupRU9xbe/s9czvE+etmDeFIiVGwOZc2hiyLCWuh90HGdZHoEIxnXhRkO
f+XkcM8kAW1dTgFQVMe/TrvqwMhX00iKJL8O7PzDEWSwj7v5KyIfZI4CYKmRR+lo
g2OVOSyU+zzhjn9X/2s4u2Jke5noPhYDHiNR63ttQTExIqJsQr93CngkEGHWwsRg
qyWt4f7sG1NEqTXeQ+ABnHspRPQEgUL4iIv/THFptlH8UEb0dyEa6NeiLY1TRHf6
ZV57D8y8flCXgk47iEEUpgLgRUvy77f9IPN6QWzeN4SMWlXiDJvlXv7BKgjN43Or
0Kzc4DgVmXc=
=+LpZ
-----END PGP SIGNATURE-----

--=-h3aPQz/rHYks83H8UOIb--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
