From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: 1.0.14rc1 pre-packages
Date: Sat, 09 Dec 2006 10:11:47 +0100
Message-ID: <1165655507.28908.1.camel@osmosis>
References: <Pine.LNX.4.61.0612071613570.13335@tm8103.perex-int.cz>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1093587235=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from csmtp1.b-one.net (csmtp.b-one.net [195.47.247.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6322E2D0
	for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2006 10:11:50 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0612071613570.13335@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1093587235==
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/x-pkcs7-signature";
	boundary="=-aLp6sHeAkSawwWSK/222"


--=-aLp6sHeAkSawwWSK/222
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Compilation and driver loading fine here.

Andrea

On Thu, 2006-12-07 at 16:20 +0100, Jaroslav Kysela wrote:
> Hi all,
>=20
> 	I am going to release 1.0.14rc1 . The "testing" packages are=20
> already prepared (see bellow for URL). I would like to ask volunteers to=20
> test compilation (only basic compilation and driver loading) of these=20
> packages to fix obvious packaging bugs (I'll do my testing tomorrow).=20
> Please, send me problems with these packages directly.
> 	The 1.0.14rc1 release will be available in few days, if no major=20
> compilation problems occur.
> 	This is first "wide public" pre-package testing. If everything=20
> goes well, I'll continue with this scheme for next package releases.
>=20
> 					Thanks,
> 						Jaroslav
>=20
> URL: ftp://ftp.alsa-project.org/pub/testing

--=-aLp6sHeAkSawwWSK/222
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MTIwOTA5MTE0MFowIwYJKoZI
hvcNAQkEMRYEFA13sIdRn+p8S1Hy90+87+Euk+NTMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQGMSap3HmuV95WU0Z5RVbGzCBhwYL
KoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQGMSap3HmuV95WU0Z5RVbGzANBgkqhkiG9w0BAQEFAASCAQAkyUDirZ86+bcbWeyZHscSqpZy
2rkryS1E8NDpQM7W0pjgxcn36ZVXbhWcBrXjS+As5ifgVQWookF0lrjA/a2GtRpUFdiq+l26O9EN
fXtNBN4l//YP2Wbi7x4YUWY+X05nHhlmfluRmlOlJivgK1dsIYD/35slBoO+7qdLW/J5tK20lMJH
SgCyAAHhfDedR5kZqDW3nO59whd+5mY2aWv9ShpGusQwVneNpJP7T6TL16tP/ltLbFrUTbsh+RpL
eN+Knd/KqryVwT6JEaiPweYLijJJn4ooDJyFGU1HzJHE/kfnszzsKYSI15AQo1+lg03a29J1aSFG
3iSDBsX0IlWTAAAAAAAA


--=-aLp6sHeAkSawwWSK/222--



--===============1093587235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1093587235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1093587235==--
