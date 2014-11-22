From: "devendra.aaru" <devendra.aaru@gmail.com>
Subject: Re: randconfig errors in ts3a227e.c
Date: Sat, 22 Nov 2014 18:51:45 -0500
Message-ID: <CAHdPZaM9XSwq5y-AFaZJNQcAmJhftgiXRkEdM3U54jSafC4bcw@mail.gmail.com>
References: <CAHdPZaOSP87jqj_9yz9No-tR0JYio0wxNEhD7K7AsOEtgR4dnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 260AB260637
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 00:51:46 +0100 (CET)
Received: by mail-wg0-f48.google.com with SMTP id y19so9439857wgg.7
 for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2014 15:51:45 -0800 (PST)
In-Reply-To: <CAHdPZaOSP87jqj_9yz9No-tR0JYio0wxNEhD7K7AsOEtgR4dnA@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

VGhpcyBhcHBlYXJzIG9uIHRoZSBsaW51eC1uZXh0IHRyZWUgKHRoZSBsYXRlc3QgY29tbWl0IGlz
CmVkNjc3OGFlZjc0MjhhNmM1ZmMxYWNmMDhhM2U5MTI2ZjVlZWY3NzAuLgoKT24gU2F0LCBOb3Yg
MjIsIDIwMTQgYXQgNjo1MCBQTSwgZGV2ZW5kcmEuYWFydSA8ZGV2ZW5kcmEuYWFydUBnbWFpbC5j
b20+IHdyb3RlOgo+IEhlbGxvIEFsbCwKPgo+IFdoaWxlIHRlc3RpbmcgdGhlIGJ1aWxkLCBpIGhh
dmUgZ290IHRoZSBmb2xsb3dpbmcgZXJyb3JzOgo+Cj4KPiBzb3VuZC9zb2MvY29kZWNzL3RzM2Ey
MjdlLmM6IEluIGZ1bmN0aW9uIOKAmHRzM2EyMjdlX2VuYWJsZV9qYWNrX2RldGVjdOKAmToKPiBz
b3VuZC9zb2MvY29kZWNzL3RzM2EyMjdlLmM6MjIzOjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJh
dGlvbiBvZgo+IGZ1bmN0aW9uIOKAmHNuZF9qYWNrX3NldF9rZXnigJkgWy1XZXJyb3I9aW1wbGlj
aXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICBzbmRfamFja19zZXRfa2V5KGphY2stPmphY2ss
IFNORF9KQUNLX0JUTl8wLCBLRVlfTUVESUEpOwo+ICAgXgo+IGNjMTogc29tZSB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwo+IG1ha2VbM106ICoqKiBbc291bmQvc29jL2NvZGVjcy90
czNhMjI3ZS5vXSBFcnJvciAxCj4KPgo+IFRoZSBDT05GSUdfU05EX0pBQ0sgaXMgbm90IGVuYWJs
ZWQgaW4gdGhlIC5jb25maWcgYW5kIHRoZSAjZWxzZQo+IHBvcnRpb24gb2YgaW5jbHVkZS9zb3Vu
ZC9qYWNrLmggZG9lc24ndCBjb250YWluIHNuZF9qYWNrX3NldF9rZXkgc3R1Yi4KPiBUaGlzIHJl
c3VsdGluZyBpbiB0aGUgYnVpbGQgZXJyb3IuIEkgYW0gdW5zdXJlIGlmIGFkZGluZyBzdHViIGlu
Cj4gaW5jbHVkZS9zb3VuZC9qYWNrLmggb3IgYWRkaW5nIGEgS2NvbmZpZyBrbm9iIHRvIGRlc2Vs
ZWN0IHRoZQo+IHRzM2EyMjdlLmMgZml4ZXMgdGhlIGlzc3VlID8KPgo+IGZ1bGwgcmFuZGNvbmZp
ZyBhdHRhY2hlZC4gKHNvcnJ5IGFib3V0IHRoZSA1NWsgZmlsZSBzaXplKQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
