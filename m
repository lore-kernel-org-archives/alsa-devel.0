From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: SAMSUNG: Fix initial return value
Date: Fri, 3 Dec 2010 18:45:33 +0900
Message-ID: <AANLkTimaQ2+9FLEJ15XC6JuizVgLq44s2NOQiFW28yur@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9E22E243D3
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 10:45:34 +0100 (CET)
Received: by bwz8 with SMTP id 8so8430262bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 01:45:34 -0800 (PST)
In-Reply-To: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBEZWMgMywgMjAxMCBhdCA2OjI3IFBNLCBTZXVuZ3doYW4gWW91biA8c3cueW91bkBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4gVGhpcyBwYXRjaCBmaXhlZCBpbnRpYWwgcmV0dXJuIHZhbHVl
IHRvIGJlIGEgJzAnIGFzIGFzdWNjZXNzIG9uCj4gc2V0X2F1ZGlvX2Nsb2NrX2hlaXJhY2h5KCku
IFRoaXMgYXZvaWRzIHVuaW50ZW5kZWQgZXJyb3Igb24gaW5pdGlhbGl6ZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFNldW5nd2hhbiBZb3VuIDxzdy55b3VuQHNhbXN1bmcuY29tPgo+IC0tLQo+IMKgc291
bmQvc29jL3MzYzI0eHgvc21ka19zcGRpZi5jIHwgwqAgwqAyICstCj4gwqAxIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvczNjMjR4eC9zbWRrX3NwZGlmLmMgYi9zb3VuZC9zb2MvczNjMjR4eC9zbWRrX3NwZGlm
LmMKPiBpbmRleCBjOGJkOTA0Li5jYjY1OGQxIDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9zM2My
NHh4L3NtZGtfc3BkaWYuYwo+ICsrKyBiL3NvdW5kL3NvYy9zM2MyNHh4L3NtZGtfc3BkaWYuYwo+
IEBAIC0yOCw3ICsyOCw3IEBACj4gwqBzdGF0aWMgaW50IHNldF9hdWRpb19jbG9ja19oZWlyYWNo
eShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+IMKgewo+IMKgIMKgIMKgIMKgc3RydWN0
IGNsayAqZm91dF9lcGxsLCAqbW91dF9lcGxsLCAqc2Nsa19hdWRpbzAsICpzY2xrX3NwZGlmOwo+
IC0gwqAgwqAgwqAgaW50IHJldDsKPiArIMKgIMKgIMKgIGludCByZXQgPSAwOwo+Cj4gwqAgwqAg
wqAgwqBmb3V0X2VwbGwgPSBjbGtfZ2V0KE5VTEwsICJmb3V0X2VwbGwiKTsKPiDCoCDCoCDCoCDC
oGlmIChJU19FUlIoZm91dF9lcGxsKSkgewoKQWNrZWQtYnk6IEphc3NpIEJyYXIgPGphc3NpLmJy
YXJAc2Ftc3VuZy5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
