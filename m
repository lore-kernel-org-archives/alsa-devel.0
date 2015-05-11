From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8903: Fix define for
	WM8903_VMID_RES_250K
Date: Mon, 11 May 2015 09:04:06 +0800
Message-ID: <1431306246.8012.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D66F2604AB
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 03:04:13 +0200 (CEST)
Received: by pacyx8 with SMTP id yx8so96475814pac.1
 for <alsa-devel@alsa-project.org>; Sun, 10 May 2015 18:04:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Vk1JRCBDb250cm9sIDAgQklUWzI6MV0gaXMgVk1JRCBEaXZpZGVyIEVuYWJsZSBhbmQgU2VsZWN0
CgowMCA9IFZNSUQgZGlzYWJsZWQgKGZvciBPRkYgbW9kZSkKMDEgPSAyIHggNTBrzqkgZGl2aWRl
ciAoZm9yIG5vcm1hbCBvcGVyYXRpb24pCjEwID0gMiB4IDI1MGvOqSBkaXZpZGVyIChmb3IgbG93
IHBvd2VyIHN0YW5kYnkpCjExID0gMiB4IDVrzqkgZGl2aWRlciAoZm9yIGZhc3Qgc3RhcnQtdXAp
CgpTbyBXTTg5MDNfVk1JRF9SRVNfMjUwSyBzaG91bGQgYmUgMiA8PCAxLCB3aGljaCBpcyA0LgoK
U2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGluZ2ljcy5jb20+Ci0tLQogc291bmQv
c29jL2NvZGVjcy93bTg5MDMuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvd204OTAzLmgg
Yi9zb3VuZC9zb2MvY29kZWNzL3dtODkwMy5oCmluZGV4IGRiOTQ5MzEuLjBiYjRhNjQgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204OTAzLmgKKysrIGIvc291bmQvc29jL2NvZGVjcy93
bTg5MDMuaApAQCAtMTcyLDcgKzE3Miw3IEBAIGV4dGVybiBpbnQgd204OTAzX21pY19kZXRlY3Qo
c3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjLAogI2RlZmluZSBXTTg5MDNfVk1JRF9CVUZfRU5B
X1dJRFRIICAgICAgICAgICAgICAgICAgICAxICAvKiBWTUlEX0JVRl9FTkEgKi8KIAogI2RlZmlu
ZSBXTTg5MDNfVk1JRF9SRVNfNTBLICAgICAgICAgICAgICAgICAgICAgICAgICAyCi0jZGVmaW5l
IFdNODkwM19WTUlEX1JFU18yNTBLICAgICAgICAgICAgICAgICAgICAgICAgIDMKKyNkZWZpbmUg
V004OTAzX1ZNSURfUkVTXzI1MEsgICAgICAgICAgICAgICAgICAgICAgICAgNAogI2RlZmluZSBX
TTg5MDNfVk1JRF9SRVNfNUsgICAgICAgICAgICAgICAgICAgICAgICAgICA2CiAKIC8qCi0tIAoy
LjEuMAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
