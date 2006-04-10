From: Ashley Clark <aclark@ghoti.org>
Subject: Adds HDA support for Intel D945Pvs board subdevice id 0x0707
Date: Sun, 9 Apr 2006 19:30:58 -0500
Message-ID: <BAD4429F-1A20-46D1-AE55-1525E4D5A30A@ghoti.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-3-965617639; protocol="application/pkcs7-signature"
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


--Apple-Mail-3-965617639
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1-965617483


--Apple-Mail-1-965617483
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=UTF-8;
	delsp=yes;
	format=flowed

Signed-Off-By: Ashley Clark <aclark@ghoti.org>

Summary: Adds HDA support for Intel D945Pvs board with subdevice id =20
0x0707

This patch adds the 5-stack pin-config for the STAC chip on the Intel =20=

D945Pvs board with subdevice id 0x0707.

With this patch against 1.0.11rc4, I'm able to successfully output =20
over the optical port and analog ports.

Ashley Clark
=EF=BF=BC


--Apple-Mail-1-965617483
Content-Type: multipart/mixed;
	boundary=Apple-Mail-2-965617483


--Apple-Mail-2-965617483
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=US-ASCII

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Signed-Off-By: Ashley Clark &lt;<A =
href=3D"mailto:aclark@ghoti.org">aclark@ghoti.org</A>&gt;</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><BR class=3D"khtml-block-placeholder"></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Summary: Adds HDA support for Intel D945Pvs board =
with subdevice id 0x0707</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><BR =
class=3D"khtml-block-placeholder"></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">This patch =
adds the 5-stack pin-config for the STAC chip on the Intel D945Pvs board =
with subdevice id 0x0707.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">With this patch against 1.0.11rc4, I'm able to =
successfully output over the optical port and analog =
ports.</DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><DIV>Ashley =
Clark</DIV><DIV><FONT class=3D"Apple-style-span" color=3D"#0000EE"><SPAN =
class=3D"Apple-style-span" style=3D"text-decoration: underline;; color: =
rgb(0, 0, 238); -khtml-text-decorations-in-effect: underline; =
"></SPAN></FONT></DIV></SPAN></SPAN><SPAN></SPAN></SPAN></DIV></BODY></HTM=
L>=

--Apple-Mail-2-965617483
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-mac-type=42494E41;
	x-unix-mode=0644;
	x-mac-creator=68446D70;
	name="sigmatel.diff"
Content-Disposition: attachment;
	filename=sigmatel.diff

--- patch_sigmatel.c.aclark     2006-04-09 14:49:38.000000000 -0500
+++ patch_sigmatel.c    2006-04-09 15:38:35.000000000 -0500
@@ -310,6 +310,9 @@
          .pci_subdevice = 0x0b0b,
          .config = STAC_D945GTP3 },    /* Intel D945PSN - 3 Stack, 9221 A1 */
        { .pci_subvendor = PCI_VENDOR_ID_INTEL,
+         .pci_subdevice = 0x0707,
+         .config = STAC_D945GTP5 },    /* Intel D945PSV - 5 Stack */
+       { .pci_subvendor = PCI_VENDOR_ID_INTEL,
          .pci_subdevice = 0x0404,
          .config = STAC_D945GTP5 },    /* Intel D945GTP - 5 Stack */
        { .pci_subvendor = PCI_VENDOR_ID_INTEL,

--Apple-Mail-2-965617483
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=US-ASCII

<HTML><BODY style="word-wrap: break-word; -khtml-nbsp-mode: space; -khtml-line-break: after-white-space; "><DIV><SPAN class="Apple-style-span" style="border-collapse: separate; border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: auto; -khtml-text-decorations-in-effect: none; text-indent: 0px; -apple-text-size-adjust: auto; text-transform: none; orphans: 2; white-space: normal; widows: 2; word-spacing: 0px; "><SPAN></SPAN><BR class="Apple-interchange-newline"></SPAN> </DIV><BR></BODY></HTML>
--Apple-Mail-2-965617483--

--Apple-Mail-1-965617483--

--Apple-Mail-3-965617639
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFOzCCBTcw
ggMfoAMCAQICAwFbDDANBgkqhkiG9w0BAQQFADB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQL
ExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3Jp
dHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNTA4MDYwNzUzMzhaFw0w
NjA4MDYwNzUzMzhaMGgxGDAWBgNVBAMTD0NBY2VydCBXb1QgVXNlcjEfMB0GCSqGSIb3DQEJARYQ
YWNsYXJrQGdob3RpLm9yZzErMCkGCSqGSIb3DQEJARYcYWNsYXJrQGNoYXBhcnJhbHBsdW1iaW5n
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ0XQ+CAQcNO0Dz3L7I5u8ZW6bMw
Dz6TV8WCdU+GBu9dOzffvNWLvuLaTNsK9h6TenRIF7kU+P/QGQKB/dffLqKpbeE9URKcx8hg1cEe
6xz5juYWGZt+J06GU/If32dgFq4Tf1ZpAJAjPsOzAVDvXQNG3EaBOu/dHxnGjIhftrXQnl8EdECj
110JhRMun1JCR1wHA8vVYA9vx2Vynbmt5CwYpnBSgJJ2MzRtvAg+GnDDcbT/jmfbYGVp5caw/jDa
VOTbdK+dWggBpxjlv355SWqGzYOhC4+2iB1H2IIWKDgjzy/5CwShAqZHNyk20LZvvXCSNhxp9OX0
qyHrGg/MQycCAwEAAaOB2DCB1TAMBgNVHRMBAf8EAjAAMFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQg
eW91ciBvd24gY2VydGlmaWNhdGUgZm9yIEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0Fj
ZXJ0Lm9yZzAyBggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmNhY2VydC5v
cmcwOQYDVR0RBDIwMIEQYWNsYXJrQGdob3RpLm9yZ4EcYWNsYXJrQGNoYXBhcnJhbHBsdW1iaW5n
LmNvbTANBgkqhkiG9w0BAQQFAAOCAgEAOJF2lAeis06nIO+XpQhwrsEN/A/6o2K9LXEC4BCduXIi
fn1hTJf+AhWugKkN19KHMx1vq9eSgdwg2KJDulBglWtGQTCpRkgSavQ/ltpdMEDuvgrf+WKFcobl
QWa55mBb9mTVPsynt8sfxwNVcLD3v16uZM0xMvZuVj7K/uFbBvoouPAlxg7mIr0Bfyk7p7Iqh+Ba
68o2OjFK9zBu64QH3Uza1eYZUdmMeE/oComHd2PBjJsEJJjDSaTJ/A0nDXZeuX1XchkMDGLmU4uj
lEXuez71Z+fBHmbsbqS7oO3eHNo1lCBwkkp9DodLMgWn1E2xDAediT/0Z1LBmqdEAj8HbBeyYjBK
ncRD8a5Xo9SwBmcw44QM1yI7rO0T/pIj13Gp52kxDT1Z8fByyiF08I0D3kATkNIaWEWkVirv9g98
R8utC9H4ddiEo994LpvLJzbiRPJsEqVhDjUrNNwHHjspBErO4iVX6cjeEi/GFC50k2NeAIafremc
GJ4YRdvSXrprUORdY1frcaq/M0irQ4pFRh7Za385S4nM3f1ikPsRjxLFi5uFH87LijWx+XI2K42o
eAwREsQNuE6sDg1Xqtr6cNmW/qLQMzTsIF2O41l6olWbY3Qxg2j+RzcR7uupNriAZdog5Hhfxhi1
0kpiyeOjAA+BrDmQA1hr4OhbtF5zU9AxggMzMIIDLwIBATCBgDB5MRAwDgYDVQQKEwdSb290IENB
MR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDAVsMMAkGBSsO
AwIaBQCgggGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MDQx
MDAwMzA1OFowIwYJKoZIhvcNAQkEMRYEFK5fdm0eCefJ6VH15lmlUMzWs06xMIGRBgkrBgEEAYI3
EAQxgYMwgYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQu
b3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJz
dXBwb3J0QGNhY2VydC5vcmcCAwFbDDCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMH
Um9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0
IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAwFb
DDANBgkqhkiG9w0BAQEFAASCAQAZXMVOKiLIuxoWNKQNAVphDj5718ucnnbZpRCr6aItDIir9YKU
Hc5tKShNMEikn4QUswTjJU2zAJhMvhm5Gj2aGI6gN9xL5uwMp0KHCcru8HsvpTh5rMC+WfS35z7f
rUUOYAOo5J3ctEuQ1219TRw2jQSdSnMpwj1jG050XBD7sGg1jabEKxyxr0SXqCnsotBnFPYDf7IC
fdWKpkL8vTWKL9zx05SvR08s8iCyn2xkhIi7X7BJ4O3mcid0WrQfWehNN4+GGF1x9zRKbJoic5xj
YFnvQOLUgL99YwtcjRxFI322Es//hMi5k76U3j0WmFeylAAj8W1igoAXibR3EIcCAAAAAAAA

--Apple-Mail-3-965617639--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
