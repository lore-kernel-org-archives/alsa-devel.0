From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 03/13] mfd: wcd9335: add wcd irq support
Date: Tue, 11 Sep 2018 16:35:35 +0100
Message-ID: <20180911153535.GZ4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 92F322676EB
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 17:35:38 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1479174wmc.5
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 08:35:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180904102500.30318-4-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwNCBTZXAgMjAxOCwgU3Jpbml2YXMgS2FuZGFnYXRsYSB3cm90ZToKCj4gV0NEOTMz
NSBzdXBwb3J0cyB0d28gbGluZXMgb2YgaXJxcyBJTlRSMSBhbmQgSU5UUjIuIE11bHRpcGxlIGlu
dGVycnVwdHMKPiBhcmUgbXV4ZWQgdmlhIHRoZXNlIGxpbmVzLiBJTlRSMSBjb25zaXN0cyBvZiBh
bGwgcG9zc2libGUgaW50ZXJydXB0Cj4gc291cmNlcyBsaWtlOiBFYXIgT0NQLCBIUEggT0NQLCBN
QkhDLCBNQUQsIFZCQVQsIGFuZCBTVkEuIElOVFIyIGlzIGEKPiBzdWJzZXQgb2YgZmlyc3QgaW50
ZXJydXB0IHNvdXJjZXMgbGlrZSBNQUQsIFZCQVQsIGFuZCBTVkEKPiAKPiBTaWduZWQtb2ZmLWJ5
OiBTcmluaXZhcyBLYW5kYWdhdGxhIDxzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmc+Cj4g
UmV2aWV3ZWQtYnk6IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIGRyaXZl
cnMvbWZkL3djZDkzMzUtY29yZS5jICAgICAgICAgIHwgNzggKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKPiAgaW5jbHVkZS9saW51eC9tZmQvd2NkOTMzNS93Y2Q5MzM1LmggfCAzMyArKysr
KysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKQoKRm9yIG15IG93
biByZWZlcmVuY2U6CiAgQWNrZWQtZm9yLU1GRC1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2hu
aWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29D
cwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
