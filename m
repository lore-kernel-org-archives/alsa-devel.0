From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/3] ASoC: simple-amplifer: add
	simple-amplifier compatible
Date: Tue, 26 Jun 2018 14:11:28 +0200
Message-ID: <20180626121128.28564-4-jbrunet@baylibre.com>
References: <20180626121128.28564-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 53A1F2675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 14:11:37 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so1631888wmf.4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 05:11:37 -0700 (PDT)
In-Reply-To: <20180626121128.28564-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

QWRkIHNpbXBsZS1hdWRpby1hbXBsaWZpZXIgdG8gdGhlIGxpc3Qgb2YgYXZhaWxhYmxlIGNvbXBh
dGlibGUKClN1Z2dlc3RlZC1ieTogTmljb2zDsiBWZXJvbmVzZSA8bmljdmVyb25lc2VAZ21haWwu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBKZXJvbWUgQnJ1bmV0IDxqYnJ1bmV0QGJheWxpYnJlLmNvbT4K
LS0tCiBzb3VuZC9zb2MvY29kZWNzL3NpbXBsZS1hbXBsaWZpZXIuYyB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9zaW1w
bGUtYW1wbGlmaWVyLmMgYi9zb3VuZC9zb2MvY29kZWNzL3NpbXBsZS1hbXBsaWZpZXIuYwppbmRl
eCA2YzI3ZDRhZmFmM2EuLjg1NTI0YWNmM2U5YyAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVj
cy9zaW1wbGUtYW1wbGlmaWVyLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9zaW1wbGUtYW1wbGlm
aWVyLmMKQEAgLTEwMSw2ICsxMDEsNyBAQCBzdGF0aWMgaW50IHNpbXBsZV9hbXBfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKICNpZmRlZiBDT05GSUdfT0YKIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNpbXBsZV9hbXBfaWRzW10gPSB7CiAJeyAuY29tcGF0aWJs
ZSA9ICJkaW9vLGRpbzIxMjUiLCB9LAorCXsgLmNvbXBhdGlibGUgPSAic2ltcGxlLWF1ZGlvLWFt
cGxpZmllciIsIH0sCiAJeyB9CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc2ltcGxlX2Ft
cF9pZHMpOwotLSAKMi4xNC40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
