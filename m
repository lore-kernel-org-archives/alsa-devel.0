From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/18] ARM: ux500: Add all encompassing
 Sound node to DB8500 Device Tree
Date: Mon, 30 Jul 2012 08:35:18 +0100
Message-ID: <50163936.1050901@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
 <20120729205227.GL4384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 355AB26526D
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 09:35:18 +0200 (CEST)
Received: by eeke50 with SMTP id e50so923510eek.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 00:35:20 -0700 (PDT)
In-Reply-To: <20120729205227.GL4384@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjkvMDcvMTIgMjE6NTIsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMjcsIDIw
MTIgYXQgMDE6NDY6MDFQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+Cj4+ICAgYXJjaC9hcm0v
Ym9vdC9kdHMvZGI4NTAwLmR0c2kgfCAgICA4ICsrKysrKysrCj4KPiBUaGlzIGlzIGEgZ2VuZXJp
YyBEVCBpbmNsdWRlIGZpbGUgYnV0Li4uCj4KPj4gKwkJc291bmQgewo+PiArCQkJY29tcGF0aWJs
ZSA9ICJzdGVyaWNzc29uLHNuZC1zb2MtbW9wNTAwIjsKPj4gKwo+PiArCQkJc3Rlcmljc3Nvbixw
bGF0Zm9ybS1wY20tZG1hID0gPCZwY20+Owo+PiArCQkJc3Rlcmljc3NvbixjcHUtZGFpID0gPCZt
c3AxICZtc3AzPjsKPj4gKwkJCXN0ZXJpY3Nzb24sYXVkaW8tY29kZWMgPSA8JmNvZGVjPjsKPj4g
KwkJfTsKPgo+IC4uLnRoaXMgaXMgY2xlYXJseSB0aGUgYm9hcmQtc3BlY2lmaWMgc2V0dXAgZm9y
IHRoZSBzeXN0ZW0sIHNob3dpbmcgaG93Cj4gdGhlIENQVSBhbmQgQ09ERUMgYXJlIGhvb2tlZCB1
cC4gIFRoaXMgc2hvdWxkIHRoZXJlZm9yZSBiZSBpbiB0aGUgRFQgZm9yCj4gd2hhdGV2ZXIgYm9h
cmQgdGhpcyBpcyB5b3UncmUgd29ya2luZyBvbi4KCkkgZG9uJ3QgdGhpbmsgaXQncyBib2FyZCBz
cGVjaWZpYy4gSSBiZWxpZXZlIHRoaXMgaXMgdGhlIHNldHVwIG9uIGFsbCAKZGI4NTAwIHBsYXRm
b3Jtcy4gSSdtIGhhcHB5IHRvIGJlIHRvbGQgSSdtIHdyb25nIGhlcmUsIGluIHdoaWNoIGNhc2Ug
SSAKY2FuIG1vdmUgaXQgdG8gdGhlIGJvYXJkIHNwZWNpZmljIGZpbGVzLgoKLS0gCkxlZSBKb25l
cwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
