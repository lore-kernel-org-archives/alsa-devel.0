From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/6] ASoC: Samsung: h1940_uda1380: Fix build
	warning
Date: Wed, 22 Jan 2014 17:30:41 +0530
Message-ID: <1390392043-24387-5-git-send-email-sachin.kamat@linaro.org>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 52820261A80
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 13:05:25 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id kl14so299500pab.15
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 04:05:24 -0800 (PST)
In-Reply-To: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: patches@linaro.org, sbkim73@samsung.com, lgirdwood@gmail.com, tiwai@suse.de, broonie@kernel.org, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nOgpzb3VuZC9zb2Mvc2Ftc3VuZy9oMTk0MF91ZGEx
MzgwLmM6OTg6NDogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAxIG9mIOKAmGRldl9lcnLigJkg
ZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFtlbmFibGVkIGJ5IGRlZmF1bHRdCgpTaWdu
ZWQtb2ZmLWJ5OiBTYWNoaW4gS2FtYXQgPHNhY2hpbi5rYW1hdEBsaW5hcm8ub3JnPgotLS0KIHNv
dW5kL3NvYy9zYW1zdW5nL2gxOTQwX3VkYTEzODAuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9z
YW1zdW5nL2gxOTQwX3VkYTEzODAuYyBiL3NvdW5kL3NvYy9zYW1zdW5nL2gxOTQwX3VkYTEzODAu
YwppbmRleCAzYjI3Y2Q5NjU3MGIuLjAwMDNiNjYxYWI2MiAxMDA2NDQKLS0tIGEvc291bmQvc29j
L3NhbXN1bmcvaDE5NDBfdWRhMTM4MC5jCisrKyBiL3NvdW5kL3NvYy9zYW1zdW5nL2gxOTQwX3Vk
YTEzODAuYwpAQCAtOTQsNyArOTQsNyBAQCBzdGF0aWMgaW50IGgxOTQwX2h3X3BhcmFtcyhzdHJ1
Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIAkJCWRpdisrOwogCQlicmVhazsKIAlk
ZWZhdWx0OgotCQlkZXZfZXJyKCZydGQtPmRldiwgIiVzOiByYXRlICVkIGlzIG5vdCBzdXBwb3J0
ZWRcbiIsCisJCWRldl9lcnIocnRkLT5kZXYsICIlczogcmF0ZSAlZCBpcyBub3Qgc3VwcG9ydGVk
XG4iLAogCQkJX19mdW5jX18sIHJhdGUpOwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9Ci0tIAoxLjcu
OS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
