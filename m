From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v4 3/3] ASoC: zx-i2s: introduce pclk for
	zx2967 family
Date: Thu, 9 Feb 2017 16:19:08 +0800
Message-ID: <d35fa104-1525-f30d-ddaa-94fc944557a6@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f42.google.com (mail-pg0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 9656C2669C4
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 09:19:16 +0100 (CET)
Received: by mail-pg0-f42.google.com with SMTP id v184so56000787pgv.3
 for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2017 00:19:16 -0800 (PST)
In-Reply-To: <1486609978-18482-3-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, mathieu.poirier@linaro.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjAxN+W5tDAy5pyIMDnml6UgMTE6MTIsIEJhb3lvdSBYaWUgd3JvdGU6Cj4gVGhlIHBjbGsg
aXMgbmVjZXNzYXJ5IGZvciB6eDI5NjcgSTJTIGNvbnRyb2xsZXIuIHRoZSBkcml2ZXIKPiBjdXJy
ZW50bHkgZG9lc24ndCBoYW5kbGUgaXQuIFRoaXMgaXMgc29tZXRoaW5nIHdlIG5lZWQgdG8gZml4
Lgo+Cj4gSW4gdHVybiwgdGhlIGRyaXZlciBzdXBwb3J0cyB6eDI5NjcxOCdzIEkyUyBjb250cm9s
bGVyLgo+Cj4gQnkgdGhlIHdheSwgdGhpcyBwYXRjaCBhbHNvIGNoYW5nZSB0aGUgY2xvY2sgbmFt
ZSBmcm9tIHR4IHRvIHdjbGsKPiB0byBtYWtlIGl0IGNsZWFyLgo+Cj4gU2lnbmVkLW9mZi1ieTog
QmFveW91IFhpZSA8YmFveW91LnhpZUBsaW5hcm8ub3JnPgo+IC0tLQoKUmV2aWV3ZWQtYnk6IEp1
biBOaWUgPGp1bi5uaWVAbGluYXJvLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
