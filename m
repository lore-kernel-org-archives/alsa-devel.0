From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 14:17:14 +0000
Message-ID: <CABS+qY3qyGJU-W6z7gtDV=6bxC+ESN3ELgPf5Gpb5uZJiDL_aw@mail.gmail.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
	<1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
	<20111121133836.GA22906@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id CB9E92437F
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 15:17:15 +0100 (CET)
Received: by mail-gx0-f180.google.com with SMTP id v5so7272045ggn.39
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 06:17:14 -0800 (PST)
In-Reply-To: <20111121133836.GA22906@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gMjEgTm92ZW1iZXIgMjAxMSAxMzozOCwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVuc291cmNl
LndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIE1vbiwgTm92IDIxLCAyMDExIGF0IDAzOjE0
OjA2UE0gKzAyMDAsIFBldGVyIFVqZmFsdXNpIHdyb3RlOgo+Cj4+IC0gwqAgwqAgaWYgKCFtYWNo
aW5lX2lzX29tYXBfNDQzMHNkcCgpKQo+PiArIMKgIMKgIGlmIChtYWNoaW5lX2lzX29tYXBfNDQz
MHNkcCgpKQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIHNuZF9zb2Nfc2RwNDQzMC5uYW1lID0gIk9N
QVA0IFNEUCI7Cj4+ICsgwqAgwqAgZWxzZSBpZiAobWFjaGluZV9pc19vbWFwNF9wYW5kYSgpKQo+
PiArIMKgIMKgIMKgIMKgIMKgIMKgIHNuZF9zb2Nfc2RwNDQzMC5uYW1lID0gIk9NQVA0IFBhbmRh
IjsKPj4gKyDCoCDCoCBlbHNlCj4KPiBJJ20gbm90IHRocmlsbGVkIGJ5IHRoaXMgZ2l2ZW4gdGhh
dCBJJ2QgaW1hZ2luZSB0aGlzJ2xsIGVuZCB1cCBsaWtlCj4gQmVhZ2xlIGFuZCBoYXZlIGxvdHMg
b2YgZGVyaXZhdGl2ZXMuIMKgV2h5IG5vdCBqdXN0IGNoYW5nZSB0aGUgc3RyaW5nIHRvCj4gYmUg
c29tZXRoaW5nIGdlbmVyaWMgYWxvbmcgdGhlIGxpbmVzIG9mICJPTUFQNCBhdWRpbyByZWZlcmVu
Y2UgZGVzaWduIgo+IHJhdGhlciB0aGFuIHRoZSBuYW1lIG9mIGEgcGFydGljdWxhciBib2FyZD8K
PgoKQWxzYS1saWIgYW5kIGFsc28gVUNNIG5lZWQgdGhlIHN0cmluZyBuYW1lIHRvIGxvYWQgdGhl
IGNvcnJlY3QgaW5pdCArCmNvbmZpZ3VyYXRpb24gZmlsZXMuCgpJIGRvbid0IGFudGljaXBhdGUg
aXQgZ3Jvd2luZyB0b28gbXVjaCwgYXMgd2Ugc2hvdWxkIGJlIGFibGUgdG8gcHVsbAp0aGlzIG91
dCBvZiBkZXZpY2UgdHJlZSBzb29uLgoKTGlhbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
