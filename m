From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/6] ASoC: ux500: Update tx tdm slots
	configuration
Date: Wed, 8 May 2013 12:11:10 +0100
Message-ID: <20130508111110.GD3459@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-5-git-send-email-fabio.baltieri@linaro.org>
 <20130508110149.GF7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 62EDD2652B3
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 13:11:14 +0200 (CEST)
Received: by mail-ea0-f176.google.com with SMTP id h14so836870eak.7
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 04:11:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130508110149.GF7478@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwOCBNYXkgMjAxMywgTWFyayBCcm93biB3cm90ZToKCj4gT24gV2VkLCBNYXkgMDgs
IDIwMTMgYXQgMDk6MTQ6MTlBTSArMDIwMCwgRmFiaW8gQmFsdGllcmkgd3JvdGU6Cj4gPiBVcGRh
dGUgYWI4NTAwLWNvZGVjIGFuZCBtb3A1MDBfYWI4NTAwIHR4IHNsb3QgY29uZmlndXJhdGlvbiB0
byByZWZsZWN0Cj4gPiB0aGUgYWN0dWFsIG9uZSB1c2VkIGJ5IFNURS4gIEFsc28gdXBkYXRlIGEg
d3JvbmcgY29tbWVudCBpbiB0aGUgcHJvY2Vzcy4KPiAKPiBUaGlzIHNlZW1zIHdyb25nLCB0aGUg
aW5kaXZpZHVhbCBjaGlwIGRyaXZlcnMgc2hvdWxkIGp1c3QgYmUgZG9pbmcKPiB3aGF0ZXZlciB0
aGV5J3JlIGJlaW5nIHRvbGQgYnkgdGhlIG1hY2hpbmUgZHJpdmVyLiAgU291bmRzIGxpa2UgdGhl
cmUncwo+IHR3byBmaXhlcyBuZWVkZWQgaGVyZSAtIG9uZSBpcyB0byBjaGFuZ2UgdGhlIFRETSBB
UEkgc28gdGhhdCB0aGUgY2hpcAo+IGRyaXZlcnMgYXJlIGp1c3QgaW1wbGVtZW50aW5nIGNvbmZp
Z3VyYXRpb24gc3VwcGxpZWQgYnkgdGhlIG1hY2hpbmUKPiBkcml2ZXIgYW5kIHRoZSBvdGhlciBp
cyB0byBjaGFuZ2UgdGhlIGNvbmZpZ3VyYXRpb24gYmVpbmcgZG9uZSB0bwo+IHdoYXRldmVyIGlz
IGRlc2lyZWQuCgpEbyB5b3UgbWVhbiB0aGF0IHRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBp
cyBpbmNvcnJlY3QsIG9yIHRoYXQKdGhpcyBwYXRjaCBpcyBkb2luZyB0aGUgd3JvbmcgdGhpbmc/
IEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBhIGJ1Z2ZpeApyYXRoZXIgdGhhbiBhIG9wcG9ydHVuaXR5
IHRvIHJlZmFjdG9yIHRoZSBkcml2ZXIuCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3Nv
biBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBm
b3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
