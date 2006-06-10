From: Johannes Berg <johannes@sipsolutions.net>
Subject: snd-aoa: oss mixer emulation not working
Date: Sat, 10 Jun 2006 11:41:39 +0200
Message-ID: <1149932499.3864.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1784412551=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1784412551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WQkjSCTJ4dNdxf5D82Rt"


--=-WQkjSCTJ4dNdxf5D82Rt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Investigating a report from a user I notice that with my snd-aoa driver
oss mixer emulation doesn't work, aumix for example just reports=20

aumx: no device found

What do I have to do to make it work? Does it need config files or
something first?

johannes

--=-WQkjSCTJ4dNdxf5D82Rt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIqT0KVg1VMiehFYAQJXZBAApJ+uo95R1Ac8bo4B52TYMPt1+cTxoEwI
Fhxg122iBdCkowcdD1WvWcOeU7jG5WtvwPWP9ujweCvLKbsod458CPJqMwERlL41
LpJhwKuV25kS8neeSvsA/eXPXnWC1ChtlkxC9OTa2FGQ557ql48J8Bt+XKTdWbjH
91XFCarEMTIPbu3h0nUSrZPcCKw0/vr3PV82+7/qIk+vkvsDmEqN22/yfTdBO2v3
nyzC+PNjRIanCB6bUbjxwenv3YgJlyvSrLYft7jA4kbl8GReuRKiSvsKhZj2ZaKS
3syfyYgPkzWvbSXKmY39Wj2BG4vlXpLGGYFORA4Z/HhUbLr6NhQu4pV0O3barLoQ
U0qNqznfJ7NNrjj7mQ+5Ks3MrFQTRXq2heDNdLrNxxNqrJwdKaoQS0IpZeQbYTJK
VBMgxeg7jiOymHtzGjfhmbi9H83cwybeZipwco4o7L64MMh6YkU+PuUzpe2S+yCE
jvUakEHfZX0imh/hOA0wf8NS+DiWIOEriHd2crDeafpEp2zwQG7aUhJJbro0tJ/+
PIhkRO/ICdDkaFetrnAmie6VbQLGeZB3+MKDp9MT/zkfYytKdGr7G2ze+rGz+R3k
+BJcT8t4YyzoF58WUf3SkM1yo0Yyyt1cVm1r1MbV5YFU8BWk1jj8H4zXHdpMoOrU
zfzmgozwqHA=
=KrP9
-----END PGP SIGNATURE-----

--=-WQkjSCTJ4dNdxf5D82Rt--



--===============1784412551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1784412551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1784412551==--
