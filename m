From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: [PATCH] 0.9.7b doesn't compile with SMP kernels
Date: Mon, 13 Oct 2003 07:19:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0310130717080.22491@dot.kde.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-813539189-1066022357=:22491"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-813539189-1066022357=:22491
Content-Type: TEXT/PLAIN; charset=US-ASCII

SSIA - patch attached.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-813539189-1066022357=:22491
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-driver-0.9.7b-smp.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0310130719170.22491@dot.kde.org>
Content-Description: SMP patch
Content-Disposition: attachment; filename="alsa-driver-0.9.7b-smp.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS43Yi9wY2kvYXU4OHgwL2F1ODh4MF9jb3Jl
LmMuYXJrCTIwMDMtMTAtMTMgMDc6MzE6MDcuMDAwMDAwMDAwICswMjAwDQor
KysgYWxzYS1kcml2ZXItMC45LjdiL3BjaS9hdTg4eDAvYXU4OHgwX2NvcmUu
YwkyMDAzLTEwLTEzIDA3OjMxOjI1LjAwMDAwMDAwMCArMDIwMA0KQEAgLTE3
NzcsNyArMTc3Nyw3IEBADQogCWlmICgobnJfY2ggPT0gMykgfHwgKChkaXIg
PT0gU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKSYmKG5yX2NoID4gMikpKQ0K
IAkJcmV0dXJuIC1FQlVTWTsNCiAJDQotCXNwaW5fbG9jayh2b3J0ZXgtPmxv
Y2spOw0KKwlzcGluX2xvY2soJnZvcnRleC0+bG9jayk7DQogCWlmIChkbWEg
Pj0gMCkgew0KICAgIAkJZW4gPSAwOw0KIAkJdm9ydGV4X2FkYl9jaGVja2lu
b3V0KHZvcnRleCwgdm9ydGV4LT5kbWFfYWRiW2RtYV0ucmVzb3VyY2VzLCBl
biwgVk9SVEVYX1JFU09VUkNFX0RNQSk7DQpAQCAtMTg4NCw3ICsxODg0LDcg
QEANCiAJCX0NCiAJfQ0KIAl2b3J0ZXgtPmRtYV9hZGJbZG1hXS5ucl9jaCA9
IG5yX2NoOw0KLQlzcGluX3VubG9jayh2b3J0ZXgtPmxvY2spOw0KKwlzcGlu
X3VubG9jaygmdm9ydGV4LT5sb2NrKTsNCiAJDQogI2lmIDANCiAJLyogQUM5
NyBDb2RlYyBjaGFubmVsIHNldHVwLiBGSVhNRTogdGhpcyBoYXMgbm8gZWZm
ZWN0ICEhICovDQo=

--658386544-813539189-1066022357=:22491--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
