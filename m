From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 17:57:13 +0400
Message-ID: <5166C139.8@list.ru>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [94.100.177.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AA73026109D
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 15:57:21 +0200 (CEST)
In-Reply-To: <51669353.7090903@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>
List-Id: alsa-devel@alsa-project.org

MTEuMDQuMjAxMyAxNDo0MSwgTGFycy1QZXRlciBDbGF1c2VuINC/0LjRiNC10YI6Cj4gT24gMDQv
MTEvMjAxMyAxMjozNiBQTSwgU3RhcyBTZXJnZWV2IHdyb3RlOgo+PiBIaS4KPj4KPj4gVGhlIGF0
dGFjaGVkIHBhdGNoIGFkZHMgYSBkdW1teSBjb2RlYyBmb3IgdGhlCj4+IGFzb2Mgc3Vic3lzdGVt
Lgo+PiBJIHVzZSBpdCB3aXRoIHRoZSBkcml2ZXIgdGhhdCBwcm9ncmFtcyB0aGUgc29jIHRvIGRy
aXZlCj4+IEkyUyBmcm9tIGFuIGludGVybmFsIFBMTHMsIGFuZCB0aGUgYXVkaW8gdGhlbiBnb2Vz
IHRvCj4+IEhETUksIHNvIG5vIGV4dGVybmFsIGNvZGVjIGlzIHVzZWQuCj4+IEkndmUgZm91bmQg
c3BkaWZfdHJhbnNjaWV2ZXIuYywgd2hpY2ggZXhhY3RseSBpcyBzdWNoIGEKPj4gZHVtbXkgZHJp
dmVyLCBidXQgaXQgaXMgYm91bmQgdG8gdGhlIHBhcnRpY3VsYXIgcGxhdAo+PiBkZXZpY2UsIHNv
IEkgbWFkZSB0aGUgZGV2aWNlIG5hbWUgYSBjb25maWcgb3B0aW9uLCBhbmQKPj4gaWYgbm90IHNl
dCwgdGhlIHBsYXQgZGV2aWNlIGlzIGNyZWF0ZWQgd2l0aCB0aGUgZGVmYXVsdAo+PiBuYW1lLgo+
Pgo+PiBJdCBtYXkgYmUgcG9zc2libGUgdG8gYXZvaWQgdGhlIHVzYWdlIG9mIHRoZSBjb2RlYyBk
cml2ZXIKPj4gYXQgYWxsLCBidXQgSSBoYXZlbid0IHN1Y2NlZWRlZCB3aXRoIHRoaXMsIGFuZCB0
aGUgZXhpc3RhbmNlCj4+IG9mIHNwZGlmX3RyYW5zY2lldmVyLmMgc3VnZ2VzdHMgdGhlcmUgaXMg
bm8gc3VjaCB3YXkuCj4+IFRob3VnaHRzPwo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTdGFzIFNlcmdl
ZXYgPHN0c3BAdXNlcnMuc291cmNlZm9yZ2UubmV0Pgo+Pgo+IEhpLAo+Cj4gVGhlcmUgaXMgYWxy
ZWFkeSBhIGR1bW15IGNvZGVjIGRyaXZlci4KPgo+IFBsZWFzZSB0YWtlIGEgbG9vayBhdCBzb3Vu
ZC9zb2Mvc29jLXV0aWxzLmMKSGksIEkndmUgc2VlbiB0aGF0LCBidXQgaG93IGNhbiBJIGdldCB1
c2Ugb2YgaXQ/Ckl0IGRvZXNuJ3QgZG8gc25kX3NvY19yZWdpc3Rlcl9jb2RlYygpLCBhbmQgaW4g
ZGVidWdmcwpJIGNhbiBkbyAnY2F0IGFzb2MvY29kZWNzJyBhbmQgaXQgc2hvd3Mgb25seSAnZHVt
bXktY29kZWMnLAp3aGljaCBpcyBpbnN0YWxsZWQgYnkgbXkgZHJpdmVyLgpTbyBjb3VsZCB5b3Ug
cGxlYXNlIGNsYXJpZnk/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
