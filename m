From: Vinod Koul <vinod.koul@intel.com>
Subject: =?utf-8?q?=5BPATCH_14/14=5D_ASoC=3A_zx296702-i2s=3A_?=
	=?utf-8?b?cmVtb3ZlIHVudXNlZCDigJhmb3JtYXTigJk=?=
Date: Thu,  8 Dec 2016 23:01:37 +0530
Message-ID: <1481218297-17568-15-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id A287A2674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:48 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Jun Nie <jun.nie@linaro.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SW4genhfaTJzX2h3X3BhcmFtcygpLCAnZm9ybWF0JyBpcyBpbml0aWFsaXplZCBhbmQgYXNzaWdu
ZWQgYml0cyBiYXNlZCBvbgpwYXJhbXNfZm9ybWF0LCBidXQgbmV2ZXIgdXNlZC4gU28gcmVtb3Zl
IGl0LgoKc291bmQvc29jL3p0ZS96eDI5NjcwMi1pMnMuYzogSW4gZnVuY3Rpb24g4oCYenhfaTJz
X2h3X3BhcmFtc+KAmToKc291bmQvc29jL3p0ZS96eDI5NjcwMi1pMnMuYzoyMjg6MjE6IHdhcm5p
bmc6IHZhcmlhYmxlIOKAmGZvcm1hdOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQt
c2V0LXZhcmlhYmxlXQogIHVuc2lnbmVkIGxvbmcgdmFsLCBmb3JtYXQ7CgpDYzogSnVuIE5pZSA8
anVuLm5pZUBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5rb3Vs
QGludGVsLmNvbT4KLS0tCiBzb3VuZC9zb2MvenRlL3p4Mjk2NzAyLWkycy5jIHwgNSArLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy96dGUvengyOTY3MDItaTJzLmMgYi9zb3VuZC9zb2MvenRlL3p4Mjk2NzAy
LWkycy5jCmluZGV4IDFjYWQ5M2RjMWZjZi4uZWQ3YTU2ZDFlZjU0IDEwMDY0NAotLS0gYS9zb3Vu
ZC9zb2MvenRlL3p4Mjk2NzAyLWkycy5jCisrKyBiL3NvdW5kL3NvYy96dGUvengyOTY3MDItaTJz
LmMKQEAgLTIyNSw3ICsyMjUsNyBAQCBzdGF0aWMgaW50IHp4X2kyc19od19wYXJhbXMoc3RydWN0
IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJc3RydWN0IHp4X2kyc19pbmZvICppMnMg
PSBzbmRfc29jX2RhaV9nZXRfZHJ2ZGF0YShzb2NkYWkpOwogCXN0cnVjdCBzbmRfZG1hZW5naW5l
X2RhaV9kbWFfZGF0YSAqZG1hX2RhdGE7CiAJdW5zaWduZWQgaW50IGxhbmUsIGNoX251bSwgbGVu
LCByZXQgPSAwOwotCXVuc2lnbmVkIGxvbmcgdmFsLCBmb3JtYXQ7CisJdW5zaWduZWQgbG9uZyB2
YWw7CiAJdW5zaWduZWQgbG9uZyBjaG5fY2ZnOwogCiAJZG1hX2RhdGEgPSBzbmRfc29jX2RhaV9n
ZXRfZG1hX2RhdGEoc29jZGFpLCBzdWJzdHJlYW0pOwpAQCAtMjM4LDE1ICsyMzgsMTIgQEAgc3Rh
dGljIGludCB6eF9pMnNfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtLAogCiAJc3dpdGNoIChwYXJhbXNfZm9ybWF0KHBhcmFtcykpIHsKIAljYXNlIFNORFJWX1BD
TV9GT1JNQVRfUzE2X0xFOgotCQlmb3JtYXQgPSAwOwogCQlsZW4gPSAxNjsKIAkJYnJlYWs7CiAJ
Y2FzZSBTTkRSVl9QQ01fRk9STUFUX1MyNF9MRToKLQkJZm9ybWF0ID0gMTsKIAkJbGVuID0gMjQ7
CiAJCWJyZWFrOwogCWNhc2UgU05EUlZfUENNX0ZPUk1BVF9TMzJfTEU6Ci0JCWZvcm1hdCA9IDI7
CiAJCWxlbiA9IDMyOwogCQlicmVhazsKIAlkZWZhdWx0OgotLSAKMS45LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
