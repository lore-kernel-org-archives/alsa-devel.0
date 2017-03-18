From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH v3 5/5] ARM: dts: sun8i: Update audio-routing
	with renamed widgets
Date: Sat, 18 Mar 2017 08:55:09 +0100
Message-ID: <20170318075509.3836-6-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 19264266ADA
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 08:55:42 +0100 (CET)
In-Reply-To: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

VGhlIGRpZ2l0YWwgQUlGIGludGVyZmFjZXMgaGFzIGJlZW4gcmVuYW1lZCBpbiB0aGUgc3VuOGkg
YXVkaW8gY29kZWMKZHJpdmVyIHNvIHRoZSBhdWRpby1yb3V0aW5nIGluIHRoZSBkZXZpY2UgdHJl
ZSBtdXN0IGJlIHJlbmFtZWQgdG9vLgoKU2lnbmVkLW9mZi1ieTogTXlsw6huZSBKb3NzZXJhbmQg
PG15bGVuZS5qb3NzZXJhbmRAZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3N1bjhpLWEzMy5kdHNpIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N1bjhp
LWEzMy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3VuOGktYTMzLmR0c2kKaW5kZXggMThjMTc0
ZmVmODRmLi4wNDY3ZmIzNjViZmMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N1bjhp
LWEzMy5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N1bjhpLWEzMy5kdHNpCkBAIC0xMTMs
OCArMTEzLDggQEAKIAkJc2ltcGxlLWF1ZGlvLWNhcmQsbWNsay1mcyA9IDw1MTI+OwogCQlzaW1w
bGUtYXVkaW8tY2FyZCxhdXgtZGV2cyA9IDwmY29kZWNfYW5hbG9nPjsKIAkJc2ltcGxlLWF1ZGlv
LWNhcmQscm91dGluZyA9Ci0JCQkiTGVmdCBEQUMiLCAiRGlnaXRhbCBMZWZ0IERBQyIsCi0JCQki
UmlnaHQgREFDIiwgIkRpZ2l0YWwgUmlnaHQgREFDIjsKKwkJCSJMZWZ0IERBQyIsICJBSUYxIFNs
b3QgMCBMZWZ0IiwKKwkJCSJSaWdodCBEQUMiLCAiQUlGMSBTbG90IDAgUmlnaHQiOwogCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOwogCiAJCXNpbXBsZS1hdWRpby1jYXJkLGNwdSB7Ci0tIAoyLjExLjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
