From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-caiaq: initialize card
	pointer
Date: Wed, 27 Jun 2012 09:57:18 +0200
Message-ID: <4FEABCDE.2080905@gmail.com>
References: <1340046991-23552-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2BF7224158
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 09:57:22 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so593734bkc.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2012 00:57:21 -0700 (PDT)
In-Reply-To: <1340046991-23552-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

cGluZwoKT24gMTguMDYuMjAxMiAyMToxNiwgRGFuaWVsIE1hY2sgd3JvdGU6Cj4gRml4ZXMgdGhl
IGZvbGxvd2luZyB3YXJuaW5nOgo+IAo+ICAgQ0MgW01dICBzb3VuZC91c2IvY2FpYXEvZGV2aWNl
Lm8KPiBzb3VuZC91c2IvY2FpYXEvZGV2aWNlLmM6IEluIGZ1bmN0aW9uIOKAmHNuZF9wcm9iZeKA
mToKPiBzb3VuZC91c2IvY2FpYXEvZGV2aWNlLmM6NTAwOjE2OiB3YXJuaW5nOiDigJhjYXJk4oCZ
IG1heSBiZSB1c2VkCj4gdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVu
aW5pdGlhbGl6ZWRdCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIE1hY2sgPHpvbnF1ZUBnbWFp
bC5jb20+Cj4gLS0tCj4gIHNvdW5kL3VzYi9jYWlhcS9kZXZpY2UuYyB8ICAgIDIgKy0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL3NvdW5kL3VzYi9jYWlhcS9kZXZpY2UuYyBiL3NvdW5kL3VzYi9jYWlhcS9kZXZpY2UuYwo+
IGluZGV4IDY0YWVkNDMuLjdkYTBkMGEgMTAwNjQ0Cj4gLS0tIGEvc291bmQvdXNiL2NhaWFxL2Rl
dmljZS5jCj4gKysrIGIvc291bmQvdXNiL2NhaWFxL2RldmljZS5jCj4gQEAgLTQ4NSw3ICs0ODUs
NyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzbmRfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2Ug
KmludGYsCj4gIAkJICAgICBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCAqaWQpCj4gIHsKPiAg
CWludCByZXQ7Cj4gLQlzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQ7Cj4gKwlzdHJ1Y3Qgc25kX2NhcmQg
KmNhcmQgPSBOVUxMOwo+ICAJc3RydWN0IHVzYl9kZXZpY2UgKmRldmljZSA9IGludGVyZmFjZV90
b191c2JkZXYoaW50Zik7Cj4gIAo+ICAJcmV0ID0gY3JlYXRlX2NhcmQoZGV2aWNlLCBpbnRmLCAm
Y2FyZCk7Cj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
