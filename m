From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] ASoC: build fix for snd_soc_info_bool_ext
Date: Sat, 10 May 2008 14:07:39 +0200
Message-ID: <1210421259.3876.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 26CA0243C2
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 14:07:44 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1201407fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 10 May 2008 05:07:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

77u/SSBzdXNwZWN0IHRoYXQg77u/c25kX2N0bF9ib29sZWFuX21vbm8gc2hvdWxkIGhhdmUgYmVl
bgpzbmRfY3RsX2Jvb2xlYW5fbW9ub19pbmZvIGluc3RlYWQuIFRoaXMgZml4ZXMgdGhlIGJ1aWxk
IGZvciBtYWdpY2lhbi4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHAgWmFiZWwgPHBoaWxpcHAuemFi
ZWxAZ21haWwuY29tPgoKLS0tCiBpbmNsdWRlL3NvdW5kL3NvYy5oIHwgICAgMiArLQogMSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zb3VuZC9zb2MuaCBiL2luY2x1ZGUvc291bmQvc29jLmgKaW5kZXggZTZlYTZmNy4u
ZDNjOGMwMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zb3VuZC9zb2MuaAorKysgYi9pbmNsdWRlL3Nv
dW5kL3NvYy5oCkBAIC0yMzgsNyArMjM4LDcgQEAgaW50IHNuZF9zb2NfaW5mb192b2xzdyhzdHJ1
Y3Qgc25kX2tjb250cm9sICprY29udHJvbCwKIAlzdHJ1Y3Qgc25kX2N0bF9lbGVtX2luZm8gKnVp
bmZvKTsKIGludCBzbmRfc29jX2luZm9fdm9sc3dfZXh0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtj
b250cm9sLAogCXN0cnVjdCBzbmRfY3RsX2VsZW1faW5mbyAqdWluZm8pOwotI2RlZmluZSBzbmRf
c29jX2luZm9fYm9vbF9leHQJCXNuZF9jdGxfYm9vbGVhbl9tb25vCisjZGVmaW5lIHNuZF9zb2Nf
aW5mb19ib29sX2V4dAkJc25kX2N0bF9ib29sZWFuX21vbm9faW5mbwogaW50IHNuZF9zb2NfZ2V0
X3ZvbHN3KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAogCXN0cnVjdCBzbmRfY3RsX2Vs
ZW1fdmFsdWUgKnVjb250cm9sKTsKIGludCBzbmRfc29jX3B1dF92b2xzdyhzdHJ1Y3Qgc25kX2tj
b250cm9sICprY29udHJvbCwKLS0gCjEuNS41LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
