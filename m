From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: Prolem with ALC260 soundcard
Date: Wed, 04 Oct 2006 15:32:45 +0200
Message-ID: <1159968765.29739.9.camel@osmosis>
References: <200610041002.k94A2bYt030190@mail04.o2online.de>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1473961027=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200610041002.k94A2bYt030190@mail04.o2online.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lubomir Schmidt <017623780966@o2online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1473961027==
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/x-pkcs7-signature";
	boundary="=-5NkuZ2uP+DJISk7YOSLN"


--=-5NkuZ2uP+DJISk7YOSLN
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FNaxbJ9zyjcX9FSS1dF2"


--=-FNaxbJ9zyjcX9FSS1dF2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

I have experienced the same troubles since I bought my Packard Bell
V7900 laptop.
Not much developement is going for ALC260 and I was able to hear clear
sound from headphones (with "Line-In" plug enabled as output source)
only by setting the option <model=3Dtest> and playing with the switches.

It's quite annoying but they fixed this problem for other realtek
chipsets and I'm confident they will do for this one too.

Andrea


 On Wed, 2006-10-04 at 12:02 +0200, Lubomir Schmidt wrote:
> Hello, i have an acer c204 Notebook with an ALC260 chip inside. Since
>  one month i have sound on it, because of the ALC883 patch for acer
>  notebooks. When i set "options snd-hda-intel model=3Dacer" in the
>  modprobe.conf, then i have sound over my headphones, but no sound is
>  comming out of the speaker. I olso saw, that when i put my headphones
>  inside the mic, then i olso have sound. That sound have not as good
>  quality as that from the headphones jack and its louder. Can someone
>  tell me what i could do to get sound out of my speaker?
>=20
> At the moment i use the 2.6.17 kernel with alsa 1.0.13
>=20
> Thanks
>=20
>=20
>=20
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-FNaxbJ9zyjcX9FSS1dF2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFI7f2oIXRn+fZcV0RAjzqAJ9ef77ctCDu6FC9SoQrRN7xaNDqawCcCE+b
mlFpAnUyjOxcICnsSoPc/AA=3D
=3DrAA6
-----END PGP SIGNATURE-----

--=-FNaxbJ9zyjcX9FSS1dF2--

--=-5NkuZ2uP+DJISk7YOSLN
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKHTCCAz8w
ggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0
ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcx
KDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxA
dGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA
xKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7d
yfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/
p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDow
OKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3Js
MAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgw
DQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A
9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYI
Tq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8wggNpMIIC0qADAgECAhAYxJqncea5X3lZ
TRnlFVsbMA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQTAeFw0wNjA5MjgyMjExMzVaFw0wNzA5MjgyMjExMzVaMIGYMR8wHQYDVQQDExZUaGF3
dGUgRnJlZW1haWwgTWVtYmVyMSUwIwYJKoZIhvcNAQkBFhZhbmRyZWFAYW5kcmVhZ296emkuY29t
MS4wLAYJKoZIhvcNAQkBFh9hbmRyZWEuZ296emlAbGludXhyZXZvbHV0aW9uLmV1MR4wHAYJKoZI
hvcNAQkBFg9hZG1pbkBnb296emkuZXUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDA
aKYawDXiSQGsaRR+miJ2ZCGuD9xEzi5ni8V7UYNjCKkV2ajaM62xTHGCAQu1ZueqKxT5hNhULuBo
MKVYi0OuMANCOpKSVMkaPlQ1W029xs/v3xvvRRqE+LmUkLxCSQu5Fibh8wvdLVpjhq5NBPnS6IwD
EIntWWSyGkbK/ThH0aQLx1ZJbJL4WcN63TqiKEGkKJWrcvVz+hLxAUp0jKQ4w/PgEjghlR4XfD4b
ADFk0G18cXQX4VFJAiJZHGUvUEuI6kkUIaE7Ul3ou0+UKhiDYXVJayRn6VV2isOPKwKGZDwL8qyK
LKPa3MaknKAVThe5cdM0D4gQ4zU1ShAQ/LZnAgMBAAGjZTBjMFMGA1UdEQRMMEqBFmFuZHJlYUBh
bmRyZWFnb3p6aS5jb22BH2FuZHJlYS5nb3p6aUBsaW51eHJldm9sdXRpb24uZXWBD2FkbWluQGdv
b3p6aS5ldTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAF9+FXde7eFHnBa9QlLGGDEU
UNYf4hTgAQvWXvXcNLlKiA5mHm4r87dC2J+EiVHOfQRypXCJdwIfbKXrwjFVvKlPeaZpf5tnZ29o
06qPU36AESdaCgPWNnZIBPp6pALA+NGQRVYsEJALQ556ugA9Jp4bxO7NFup15ZqgGiAppoSlMIID
aTCCAtKgAwIBAgIQGMSap3HmuV95WU0Z5RVbGzANBgkqhkiG9w0BAQUFADBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3Rl
IFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDYwOTI4MjIxMTM1WhcNMDcwOTI4MjIx
MTM1WjCBmDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjElMCMGCSqGSIb3DQEJARYW
YW5kcmVhQGFuZHJlYWdvenppLmNvbTEuMCwGCSqGSIb3DQEJARYfYW5kcmVhLmdvenppQGxpbnV4
cmV2b2x1dGlvbi5ldTEeMBwGCSqGSIb3DQEJARYPYWRtaW5AZ29venppLmV1MIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwGimGsA14kkBrGkUfpoidmQhrg/cRM4uZ4vFe1GDYwipFdmo
2jOtsUxxggELtWbnqisU+YTYVC7gaDClWItDrjADQjqSklTJGj5UNVtNvcbP798b70UahPi5lJC8
QkkLuRYm4fML3S1aY4auTQT50uiMAxCJ7VlkshpGyv04R9GkC8dWSWyS+FnDet06oihBpCiVq3L1
c/oS8QFKdIykOMPz4BI4IZUeF3w+GwAxZNBtfHF0F+FRSQIiWRxlL1BLiOpJFCGhO1Jd6LtPlCoY
g2F1SWskZ+lVdorDjysChmQ8C/Ksiiyj2tzGpJygFU4XuXHTNA+IEOM1NUoQEPy2ZwIDAQABo2Uw
YzBTBgNVHREETDBKgRZhbmRyZWFAYW5kcmVhZ296emkuY29tgR9hbmRyZWEuZ296emlAbGludXhy
ZXZvbHV0aW9uLmV1gQ9hZG1pbkBnb296emkuZXUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUF
AAOBgQBffhV3Xu3hR5wWvUJSxhgxFFDWH+IU4AEL1l713DS5SogOZh5uK/O3QtifhIlRzn0EcqVw
iXcCH2yl68IxVbypT3mmaX+bZ2dvaNOqj1N+gBEnWgoD1jZ2SAT6eqQCwPjRkEVWLBCQC0OeeroA
PSaeG8TuzRbqdeWaoBogKaaEpTGCAxAwggMMAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoT
HFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAhAYxJqncea5X3lZTRnlFVsbMAkGBSsOAwIaBQCgggFvMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MTAwNDEzMzIzOFowIwYJKoZI
hvcNAQkEMRYEFMkJl1vyfrhh59MLg/B8S34I7A8lMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQGMSap3HmuV95WU0Z5RVbGzCBhwYL
KoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQGMSap3HmuV95WU0Z5RVbGzANBgkqhkiG9w0BAQEFAASCAQC4yLgOanMBxuyAszIhiK6tmZwv
xDoiSpFCQVXDW7UqRxlLlK/+4IBTlsDIXgFn4vgYPw5lm/i3n64JVm6WZ+s6GXZTqWFDVyu7DUG7
Par6URj/HQ/wiQKWtCfC0gObkmCQ1ibdpisK3qcilsCTy9YG2agB6g14vIjmM5DHgHRbL8mr09rK
f62ZS1EtqeLfHQ3xf5SM0IIollbuV2oYriGmN71msBPwtKmY/XjLca54T5VuGhk4Er9byTQf6jJG
YWyxQGIagVPrO/QrhZeWFHKe6kvA+nHljvrY9ycxxywWMUoJ3L6aOJydtMZtNHanXU2lPBt1d3Ty
iDoZYz+a6RnmAAAAAAAA


--=-5NkuZ2uP+DJISk7YOSLN--



--===============1473961027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1473961027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1473961027==--
