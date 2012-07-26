From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Crash when probing imx_mc13783
Date: Thu, 26 Jul 2012 17:15:52 +0100
Message-ID: <50116D38.6050001@linaro.org>
References: <CAOMZO5B4Z4jACQFt5gy2o3VLqGrQg+bXcN12ChysrQphYNxQBA@mail.gmail.com>
 <3192997.N5KLupAYnr@laptop>
 <CAOMZO5BsOV3X09DKc-uexe9mqhYhkbmKZg2vh_h2-hBB=X1A7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB54265F02
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 18:15:51 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so172936eaa.38
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 09:15:54 -0700 (PDT)
In-Reply-To: <CAOMZO5BsOV3X09DKc-uexe9mqhYhkbmKZg2vh_h2-hBB=X1A7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

T24gMjYvMDcvMTIgMTY6NDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6Cj4gUGhpbGlwcGUsCj4KPiBP
biBUaHUsIEp1bCAyNiwgMjAxMiBhdCA0OjI5IEFNLCBQaGlsaXBwZSBSw6l0b3JuYXoKPiA8cGhp
bGlwcGUucmV0b3JuYXpAZXBmbC5jaD4gd3JvdGU6Cj4KPj4gV2VsbCwgSSdtIGFibGUgdG8gYm9v
dCAzLjUgb24gbXkgYm9hcmQgKGlteDMxIGJhc2VkKSwgc28gaXQgbXVzdCBiZSBhIHBhdGNoCj4+
IGJldHdlZW4gMy41IGFuZCAzLjUtbmV4dC4gSXQgc2hvdWxkIGJlIHF1aXRlIHF1aWNrbHkgYmlz
ZWN0YWJsZS4KPgo+IEl0IHR1cm5zIG91dCBJIGFtIGhhdmluZyB0aGUgc2FtZSBpc3N1ZSBhcyB0
aGUgb25lIGRlc2NyaWJlZCBhdDoKPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxMi83LzI2LzEy
OAo+Cj4gSSBhcHBsaWVkIExlZSdzIHBhdGNoIGFuZCBhdWRpbyBjYW4gYmUgcHJvYmVkIGFnYWlu
LiBJIGFtIG5vdCBzdXJlIGhvdwo+IHdvdWxkIGJlIHRoZSByaWdodCBmaXggaW4gb3VyIGNhc2Ug
dGhvdWdoLgoKVGhlIHBhdGNoIGlzIGFwcGFyZW50bHkgbm90IGNvcnJlY3QgKGFsdGhvdWdoLCBJ
IGRvIHNlZSBhIHBsYWNlIGZvciBpdCkuIApUaGUgcHJvYmxlbSBpcyB0aGF0IHVubGVzcyB5b3Vy
IGNvZGUgcG9wdWxhdGVzIGNvZGVjLT5jb250cm9sX2RhdGEsIFNvQyAKQ29yZSB3aWxsIGFzc3Vt
ZSB5b3UgaGF2ZW4ndCBzZXQtdXAgYW55IEkvTyBmb3IgeW91cnNlbGYsIGV2ZW4gaWYgeW91IApo
YXZlLiBJJ20ganVzdCBjaGF0dGluZyB3aXRoIE1hcmsgbm93IHRvIHRyeSB0byBnZXQgdG8gdGhl
IGJvdHRvbSBvZiAKd2hhdCBJIG5lZWQgdG8gcHV0IGluIHRoZXJlIGZvciBteSB1c2UtY2FzZS4g
SSdtIGFzc3VtaW5nIHlvdXJzIHdpbGwgYmUgCmRpZmZlcmVudCBhZ2Fpbi4KCktpbmQgcmVnYXJk
cywKTGVlCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVh
ZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93
IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
