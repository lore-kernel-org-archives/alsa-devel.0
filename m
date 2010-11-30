From: =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
Subject: [PATCH 3/3] s6105-ipcam: fix compilation
Date: Tue, 30 Nov 2010 01:00:18 +0100
Message-ID: <1291075218-7849-3-git-send-email-daniel-gl@gmx.net>
References: <20101129104228.GM30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id F38EA1038DA
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 01:01:37 +0100 (CET)
In-Reply-To: <20101129104228.GM30360@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

V2hlbiB0aGUgczYxMDUtaXBjYW0gQVNvQyBkcml2ZXIgaGFkIGJlZW4gY29udmVydGVkIHRvIHRo
ZQptdWx0aS1jb21wb25lbnQgQVBJLCBhIHNpbmdsZSByZWZlcmVuY2UgdG8gYSBmb3JtZXIgc3Ry
dWN0dXJlCmVsZW1lbnQgcmVtYWluZWQsIGJsb2NraW5nIHN1Y2Nlc3NmdWwgY29tcGlsYXRpb24u
CgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR2zDtmNrbmVyIDxkYW5pZWwtZ2xAZ214Lm5ldD4KLS0t
CiBzb3VuZC9zb2MvczYwMDAvczYxMDUtaXBjYW0uYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9zNjAwMC9zNjEwNS1pcGNhbS5jIGIvc291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKaW5k
ZXggOTZjMDVlMS4uYzEyNDRjNSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3M2MDAwL3M2MTA1LWlw
Y2FtLmMKKysrIGIvc291bmQvc29jL3M2MDAwL3M2MTA1LWlwY2FtLmMKQEAgLTE2Nyw3ICsxNjcs
NyBAQCBzdGF0aWMgaW50IHM2MTA1X2FpYzN4X2luaXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRp
bWUgKnJ0ZCkKIAogCXNuZF9zb2NfZGFwbV9zeW5jKGNvZGVjKTsKIAotCXNuZF9jdGxfYWRkKGNv
ZGVjLT5zbmRfY2FyZCwgc25kX2N0bF9uZXcxKCZhdWRpb19vdXRfbXV4LCBjb2RlYykpOworCXNu
ZF9jdGxfYWRkKGNvZGVjLT5jYXJkLT5zbmRfY2FyZCwgc25kX2N0bF9uZXcxKCZhdWRpb19vdXRf
bXV4LCBjb2RlYykpOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoxLjcuMC41CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
