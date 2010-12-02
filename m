From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Does anyone really have success experience with
 SPI codecs with new name-based SOC API?
Date: Thu, 2 Dec 2010 16:12:12 -0200
Message-ID: <AANLkTimPf9MUOtcVs7Yuf6MAftj6LErGXiLCCs6Q5DAp@mail.gmail.com>
References: <1290079866.1496.55.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D498103ACD
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 19:12:13 +0100 (CET)
Received: by wwi18 with SMTP id 18so2637723wwi.2
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 10:12:12 -0800 (PST)
In-Reply-To: <1290079866.1496.55.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGkgQWxleGFuZGVyLAoKT24gVGh1LCBOb3YgMTgsIDIwMTAgYXQgOTozMSBBTSwgQWxleGFuZGVy
IDxzdWJhcGFydHNAeWFuZGV4LnJ1PiB3cm90ZToKPiBEb2VzIGFueW9uZSByZWFsbHkgaGF2ZSBz
dWNjZXNzIGV4cGVyaWVuY2Ugd2l0aCBTUEkgY29kZWNzIHdpdGggbmV3Cj4gbmFtZS1iYXNlZCBT
T0MgQVBJPwo+IFRoZXJlIGFyZSByZWFsbHkgZmV3IFNQSSBjb2RlY3MgaW4gQVNvQyBzdWJzeXN0
ZW0sIHNvIEkgd29uZGVyIGlmIG9ubHkgSQo+IGNhbm5vdCBiaW5kIG15IFNQSSBjb2RlYyB0byBt
YWNoaW5lIGRyaXZlci4KPgo+IFRoZSBjb2RlYyBpcyByZWdpc3RlcmVkIHdpdGggbmFtZSBzcGkw
LjAgaXQncyB0aGUgYmVoYXZpb3Igb2YgU1BJCj4gc3Vic3lzdGVtLCBJIHN1cHBvc2UuIFNvIHRo
ZSBmb3JtIGlzICVzJWQuJWQgYW5kIG5vdCAlcy4lZCBhcyBzdXBwb3NlZAo+IGluIGZtdF9zaW5n
bGVfbmFtZSgpIGluIHNvY19jb3JlLmMKPgo+IEZvciBtZQo+IGRldl9uYW1lKGRldik9PXNwaTAu
MAo+IGRldi0+ZHJpdmVyLT5uYW1lPT1jczQyNzEtY29kZWMKPgo+IElzIHRoaXMgcmVhbGx5IHdv
cmtpbmcgY29kZT8KPiAtLS0tLQo+IMKgIMKgIMKgIMKgc3RybmNweShuYW1lLCBkZXZfbmFtZShk
ZXYpLCBOQU1FX1NJWkUpOwo+Cj4gwqAgwqAgwqAgwqAvKiBhcmUgd2UgYSAiJXMuJWQiIG5hbWUg
KHBsYXRmb3JtIGFuZCBTUEkgY29tcG9uZW50cykgKi8KPiDCoCDCoCDCoCDCoGZvdW5kID0gc3Ry
c3RyKG5hbWUsIGRldi0+ZHJpdmVyLT5uYW1lKTsKPiDCoCDCoCDCoCDCoGlmIChmb3VuZCkgewo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogZ2V0IElEICovCj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoc3NjYW5mKCZmb3VuZFtzdHJsZW4oZGV2LT5kcml2ZXItPm5hbWUpXSwgIi4lZCIs
IGlkKSA9PSAxKSB7Cj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGRp
c2NhcmQgSUQgZnJvbSBuYW1lIGlmIElEID09IC0xICovCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoKmlkID09IC0xKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZm91bmRbc3RybGVuKGRldi0+ZHJpdmVyLT5uYW1lKV0gPSAn
XDAnOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+Cj4gwqAgwqAgwqAgwqB9IGVsc2Ugewo+
IC0tLS0tCgpIYXZlIHlvdSBtYW5hZ2VkIHRvIGJpbmQgdGhlIFNQSSBjb2RlYz8gSSBhbSB0cnlp
bmcgdGhlIHNhbWUgdGhpbmcKaGVyZS4gUGxlYXNlIGxldCBtZSBrbm93LgoKUmVnYXJkcywKCkZh
YmlvIEVzdGV2YW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
