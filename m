From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: =?utf-8?q?=5BPATCH=5D_ASoC=3A_omap-mcbsp=3A_Fix_comp?=
	=?utf-8?q?ile_time_warning_about_ambiguous_=E2=80=98else=E2=80=99?=
Date: Mon, 26 Sep 2011 10:56:42 +0300
Message-ID: <1317023802-27948-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id 95CB4244EB
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 09:57:23 +0200 (CEST)
Received: by mail-bw0-f44.google.com with SMTP id q10so6065390bka.31
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 00:57:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyBjb21waWxlIHRpbWUgd2FybmluZzoKb21hcC1tY2JzcC5jOjUx
OTogd2FybmluZzogc3VnZ2VzdCBleHBsaWNpdCBicmFjZXMgdG8gYXZvaWQgYW1iaWd1b3VzIOKA
mGVsc2XigJkKClNpZ25lZC1vZmYtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0
aS5jb20+Ci0tLQogc291bmQvc29jL29tYXAvb21hcC1tY2JzcC5jIHwgICAgMyArKy0KIDEgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9vbWFwL29tYXAtbWNic3AuYyBiL3NvdW5kL3NvYy9vbWFwL29tYXAtbWNic3Au
YwppbmRleCA0NzhkNjA3Li4xMzkxZWEwIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvb21hcC9vbWFw
LW1jYnNwLmMKKysrIGIvc291bmQvc29jL29tYXAvb21hcC1tY2JzcC5jCkBAIC01MTYsMTEgKzUx
NiwxMiBAQCBzdGF0aWMgaW50IG9tYXBfbWNic3BfZGFpX3NldF9kYWlfc3lzY2xrKHN0cnVjdCBz
bmRfc29jX2RhaSAqY3B1X2RhaSwKIAlzdHJ1Y3Qgb21hcF9tY2JzcF9yZWdfY2ZnICpyZWdzID0g
Jm1jYnNwX2RhdGEtPnJlZ3M7CiAJaW50IGVyciA9IDA7CiAKLQlpZiAobWNic3BfZGF0YS0+YWN0
aXZlKQorCWlmIChtY2JzcF9kYXRhLT5hY3RpdmUpIHsKIAkJaWYgKGZyZXEgPT0gbWNic3BfZGF0
YS0+aW5fZnJlcSkKIAkJCXJldHVybiAwOwogCQllbHNlCiAJCQlyZXR1cm4gLUVCVVNZOworCX0K
IAogCS8qIFRoZSBNY0JTUCBzaWduYWwgbXV4aW5nIGZ1bmN0aW9ucyBhcmUgb25seSBhdmFpbGFi
bGUgb24gTWNCU1AxICovCiAJaWYgKGNsa19pZCA9PSBPTUFQX01DQlNQX0NMS1JfU1JDX0NMS1Ig
fHwKLS0gCjEuNy42LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
