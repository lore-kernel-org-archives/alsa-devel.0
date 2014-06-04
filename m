From: ShaRab Shaik <sharab.shaik@gmail.com>
Subject: Re: [PATCH] sound: tlv320aic32x4: Fixed Coding style
	issues
Date: Wed, 4 Jun 2014 23:06:30 +0530
Message-ID: <CAHWZSxiceBwayYgN7N9LSeo+q9qf+_zzw8Y1J+Zg4Q+90L-xKw@mail.gmail.com>
References: <CAHWZSxgM17azkvwxOAcR3skaUXRcaoxbiHxE3bMNrfg2dNTRkw@mail.gmail.com>
 <20140604124224.GK2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 246212650F5
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 19:37:15 +0200 (CEST)
Received: by mail-wi0-f176.google.com with SMTP id n15so8859551wiw.15
 for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2014 10:37:11 -0700 (PDT)
In-Reply-To: <20140604124224.GK2520@sirena.org.uk>
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
Cc: tiwai@suse.de, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

4oCL4oCLCkhpIE1hcmssCgpTb3JyeSBmb3IgdGhlIG1pc3Rha2VzIGFuZCB0aGFua3MgZm9yIHRo
ZSBzdWdnZXN0aW9ucy4KSSB3aWxsIGdldCBiYWNrIGFnYWluIHdpdGggcHJvcGVyIHBhdGNoZXMu
CgoKVGhhbmtzLApTaGFoaW5hCgoKT24gV2VkLCBKdW4gNCwgMjAxNCBhdCA2OjEyIFBNLCBNYXJr
IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOgoKPiBPbiBXZWQsIEp1biAwNCwgMjAx
NCBhdCAwNDo0OTo1NFBNICswNTMwLCBTaGFSYWIgU2hhaWsgd3JvdGU6Cj4gPiBGcm9tIDYxN2Q3
YTI1ZjNjMGMwOGUwYjk1YjI0ZGUyZDFlYTBmM2Y0Yjk4YzcgTW9uIFNlcCAxNyAwMDowMDowMCAy
MDAxCj4gPiBGcm9tOiBTaGFoaW5hIFNoYWlrIDxzaGFyYWIuc2hhaWtAZ21haWwuY29tPgo+ID4g
RGF0ZTogV2VkLCA0IEp1biAyMDE0IDE2OjI3OjE5ICswNTMwCj4gPiBTdWJqZWN0OiBbUEFUQ0hd
IHNvdW5kOiB0bHYzMjBhaWMzMng0OiBGaXhlZCBDb2Rpbmcgc3R5bGUgaXNzdWVzLgo+ID4KPiA+
IEZpeGVkIGJyYWNlIGNvZGluZyBzdHlsZSwgbGluZXMgbW9yZXRoYW4gODAgY2hhcmFjdGVycyBp
c3N1ZXMuCj4KPiBZb3VyIHBhdGNoIGFwcGVhcnMgdG8gaGF2ZSBiZWVuIGNvcnJ1cHRlZCBieSB5
b3VyIG1haWxlciwgaXQncyB3b3JkCj4gd3JhcHBlZCBzbyBjYW4ndCBiZSBhcHBsaWVkIGJ5IHRo
ZSB0b29scy4gIFBsZWFzZSBzZWUKPiBEb2N1bWVudGF0aW9uL1N1Ym1pdHRpbmdQYXRjaGVzIGFu
ZCBEb2N1bWVudGF0aW9uL2VtYWlsLWNsaWVudHMudHh0IGZvcgo+IHNvbWUgc3VnZ2VzdGlvbnMg
b24gaG93IHRvIHNldCB0aGlzIHVwLgo+Cj4gPiBSZXBsYWNlZCBwcmludGsgd2l0aCBwcl9lcnIg
YXMgcHJfZXJyIGlzIHByZWZlcmVkIHRoYW4gcHJpbnRrLgo+Cj4gSW4gZ2VuZXJhbCBkZXZfZXJy
KCkgaXMgZ29pbmcgdG8gYmUgdXNhYmxlIGJ5IENPREVDIGRyaXZlcnMgYW5kIGlzIGV2ZW4KPiBt
b3JlIHN0cm9uZ2x5IHByZWZlcnJlZCB0aGFuIHByX2VycigpIHNpbmNlIGl0IHByb3ZpZGVzIG1v
cmUgaW5mb3JtYXRpb24KPiBhYm91dCB0aGUgc291cmNlIG9mIHRoZSBlcnJvci4KPgo+IFBsZWFz
ZSBhbHNvIGF2b2lkIG1ha2luZyBtdWx0aXBsZSBraW5kcyBvZiBjaGFuZ2UgaW4gdGhlIHNhbWUg
cGF0Y2ggLSBpdAo+IGlzIG11Y2ggZWFzaWVyIHRvIHJldmlldyB0aGluZ3MgaWYgdGhlIHBhdGNo
IGlzIHNpbXBsZXIuCj4KPiA+IC0gICAgaWYgKGFpYzMyeDQtPnBvd2VyX2NmZyAmIEFJQzMyWDRf
UFdSX0FWRERfRFZERF9XRUFLX0RJU0FCTEUpIHsKPiA+ICsgICAgaWYgKGFpYzMyeDQtPnBvd2Vy
X2NmZyAmIEFJQzMyWDRfUFdSX0FWRERfRFZERF9XRUFLX0RJU0FCTEUpCj4gPiAgICAgICAgICBz
bmRfc29jX3dyaXRlKGNvZGVjLCBBSUMzMlg0X1BXUkNGRywgQUlDMzJYNF9BVkREV0VBS0RJU0FC
TEUpOwo+ID4gLSAgICB9Cj4gPiArCj4KPiBTbyBmb3IgZXhhbXBsZSB0aGUgcHJpbnQgY2hhbmdl
cyBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCB0byB0aGVzZQo+IGJyYWNlICBjaGFuZ2VzLiAg
SWYgeW91J3JlIHJlbW92aW5nIHRoZSB9IHlvdSBzaG91bGQgYWxzbyBqdXN0IGRlbGV0ZQo+IHRo
ZSBsaW5lLgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
