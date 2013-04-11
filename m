From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 18:33:46 +0400
Message-ID: <5166C9CA.9040601@list.ru>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
 <5166C139.8@list.ru> <5166C6F7.3070706@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp12.mail.ru (smtp12.mail.ru [94.100.176.89])
 by alsa0.perex.cz (Postfix) with ESMTP id E45742610A3
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 16:33:49 +0200 (CEST)
In-Reply-To: <5166C6F7.3070706@metafoo.de>
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

MTEuMDQuMjAxMyAxODoyMSwgTGFycy1QZXRlciBDbGF1c2VuINC/0LjRiNC10YI6Cj4gT24gMDQv
MTEvMjAxMyAwMzo1NyBQTSwgU3RhcyBTZXJnZWV2IHdyb3RlOgo+PiAxMS4wNC4yMDEzIDE0OjQx
LCBMYXJzLVBldGVyIENsYXVzZW4g0L/QuNGI0LXRgjoKPj4+IE9uIDA0LzExLzIwMTMgMTI6MzYg
UE0sIFN0YXMgU2VyZ2VldiB3cm90ZToKPj4+PiBIaS4KPj4+Pgo+Pj4+IFRoZSBhdHRhY2hlZCBw
YXRjaCBhZGRzIGEgZHVtbXkgY29kZWMgZm9yIHRoZQo+Pj4+IGFzb2Mgc3Vic3lzdGVtLgo+Pj4+
IEkgdXNlIGl0IHdpdGggdGhlIGRyaXZlciB0aGF0IHByb2dyYW1zIHRoZSBzb2MgdG8gZHJpdmUK
Pj4+PiBJMlMgZnJvbSBhbiBpbnRlcm5hbCBQTExzLCBhbmQgdGhlIGF1ZGlvIHRoZW4gZ29lcyB0
bwo+Pj4+IEhETUksIHNvIG5vIGV4dGVybmFsIGNvZGVjIGlzIHVzZWQuCj4+Pj4gSSd2ZSBmb3Vu
ZCBzcGRpZl90cmFuc2NpZXZlci5jLCB3aGljaCBleGFjdGx5IGlzIHN1Y2ggYQo+Pj4+IGR1bW15
IGRyaXZlciwgYnV0IGl0IGlzIGJvdW5kIHRvIHRoZSBwYXJ0aWN1bGFyIHBsYXQKPj4+PiBkZXZp
Y2UsIHNvIEkgbWFkZSB0aGUgZGV2aWNlIG5hbWUgYSBjb25maWcgb3B0aW9uLCBhbmQKPj4+PiBp
ZiBub3Qgc2V0LCB0aGUgcGxhdCBkZXZpY2UgaXMgY3JlYXRlZCB3aXRoIHRoZSBkZWZhdWx0Cj4+
Pj4gbmFtZS4KPj4+Pgo+Pj4+IEl0IG1heSBiZSBwb3NzaWJsZSB0byBhdm9pZCB0aGUgdXNhZ2Ug
b2YgdGhlIGNvZGVjIGRyaXZlcgo+Pj4+IGF0IGFsbCwgYnV0IEkgaGF2ZW4ndCBzdWNjZWVkZWQg
d2l0aCB0aGlzLCBhbmQgdGhlIGV4aXN0YW5jZQo+Pj4+IG9mIHNwZGlmX3RyYW5zY2lldmVyLmMg
c3VnZ2VzdHMgdGhlcmUgaXMgbm8gc3VjaCB3YXkuCj4+Pj4gVGhvdWdodHM/Cj4+Pj4KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBTdGFzIFNlcmdlZXYgPHN0c3BAdXNlcnMuc291cmNlZm9yZ2UubmV0Pgo+
Pj4+Cj4+PiBIaSwKPj4+Cj4+PiBUaGVyZSBpcyBhbHJlYWR5IGEgZHVtbXkgY29kZWMgZHJpdmVy
Lgo+Pj4KPj4+IFBsZWFzZSB0YWtlIGEgbG9vayBhdCBzb3VuZC9zb2Mvc29jLXV0aWxzLmMKPj4g
SGksIEkndmUgc2VlbiB0aGF0LCBidXQgaG93IGNhbiBJIGdldCB1c2Ugb2YgaXQ/Cj4+IEl0IGRv
ZXNuJ3QgZG8gc25kX3NvY19yZWdpc3Rlcl9jb2RlYygpLCBhbmQgaW4gZGVidWdmcwo+IEl0IGRv
ZXM6Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFs
ZHMvbGludXguZ2l0L3RyZWUvc291bmQvc29jL3NvYy11dGlscy5jI24xMDEKQXJyLCB0aGF0J3Mg
aXQsIHRoYW5rIHlvdSEKSXQgZG9lc24ndCBkbyBzbyBvbiBhbiBhbmRyb2lkIGtlcm5lbCBJIGhh
dmUgaGVyZQooYmFzZWQgb24gbGludXgtMy4wKSwgYnV0IGl0IGluZGVlZCBkb2VzIHNvIGluIGEg
Z2l0IGtlcm5lbC4uLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
