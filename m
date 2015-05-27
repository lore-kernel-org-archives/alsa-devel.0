From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: OPL3 on cmipci doesn't survive suspend/resume
Date: Wed, 27 May 2015 15:59:07 +0200
Message-ID: <alpine.DEB.2.02.1505271554310.22011@lnxricardw1.se.axis.com>
References: <CADN=WdrzMgQCSYA_vp0VVWm0guVWdRXyhVO7CFXXJpvQCgPfqw@mail.gmail.com>
 <alpine.DEB.2.02.1505271529450.22011@lnxricardw1.se.axis.com>
 <CADN=Wdo5-Nkc-dLGwawq59w82RMv_VwUQw04i1YYwuD57h_ByQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8347C265A81
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 15:59:10 +0200 (CEST)
In-Reply-To: <CADN=Wdo5-Nkc-dLGwawq59w82RMv_VwUQw04i1YYwuD57h_ByQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <adam@spicenitz.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ck9uIFdlZCwgMjcgTWF5IDIwMTUsIEFkYW0gR29vZGUgd3JvdGU6Cgo+ID4+IEFueSBpZGVhcyBi
ZWZvcmUgSSBwZWVrIGludG8gdGhlIGNvZGU/Cj4gPgo+ID4gTm90IHJlYWxseSwgZXhjZXB0IHRo
YXQgaXQgaXMgYSB2ZXJ5IG9sZCBjYXJkIGJ5IG5vdy4gTm8gcmVhbCB3b3JrIGhhcwo+ID4gIGJl
ZW4gZG9uZSBpbiB0aGUgZHJpdmVyIGZvciBtYW55IHllYXJzLgo+ID4KPiA+IChJIHN0aWxsIGhh
dmUgb25lIGFyb3VuZCBpbiBhbiBhbmNpZW50IExpbnV4IGJveCwgZm9yIGl0cyBTL1BESUYKPiA+
IGNhcGFiaWxpdHkgKGZvciB3aGljaCBpdCB3YXMgdmVyeSBnb29kIHZhbHVlIGZvciBtb25leSBp
biBpdHMgZGF5KS4pCj4gPgo+IFRoYW5rcyEgSSdtIHN1cnByaXNlZCBpdCB3b3JrcyBhdCBhbGwu
Cj4gCj4gSSBoYXZlIHRoaXMgY2FyZCwgd2hpY2ggaXMgc3RpbGwgaW4gcHJvZHVjdGlvbiAoYW5k
IHdpdGggYSBnYW1lcG9ydCArCj4gTUlESSBVQVJUIGV2ZW4hKToKPiBodHRwOi8vd3d3LmFtYXpv
bi5jb20vZ3AvcHJvZHVjdC9CMDAxS1VTWVNPCgpUaGUgb25lIEkgaGF2ZSBpcyBhIFpvbHRyaXgg
TmlnaHRpbmdhbGUgUHJvNiB3aGljaCBoYXMgdGhlIGRpZ2l0YWwgSS9PIAooUy9QRElGIGNvYXgg
YW5kIFRPU0xJTkspIG9uIGEgc2VwYXJhdGUgc2lzdGVyIGNhcmQuCmh0dHA6Ly93d3cuem9sdHJp
eC5jb20vcHJvZHVjdHMvYXVkaW8vOFNCODczODZDSEdNWC5odG0KCkkgYWdyZWUgaXQncyBhbWF6
aW5nIHRoYXQgdGhlIGRyaXZlciBzdGlsbCB3b3JrcyAoYWx0aG91Z2ggdGhlIGJveCBpbiAKcXVl
c3Rpb24gc3RpbGwgcnVucyBEZWJpYW4gU3F1ZWV6ZSBzbyBJIGhhdmVuJ3Qga2VwdCB1cCB0byBk
YXRlIHdpdGggCmFueXRoaW5nIHRoYXQncyBoYXBwZW5lZCBzaW5jZSB0aGVuKS4KCkkgaGF2ZSBh
IHBhdGNoIHRoYXQgZml4ZXMgc29tZSBpc3N1ZSB3aXRoIHVzaW5nIHRoZSBTL1BESUYgcG9ydCBm
b3IgCmRpZ2l0YWwgc3RlcmVvIEkvTywgYnV0IEkgZmVhciBpdCBpcyBub3QgbWVyZ2FibGUgYXMg
SSB0aGluayBpdCB3b3VsZCAKYnJlYWsgYXBwbGljYXRpb25zIHdoaWNoIHVzZSB0aGUgdXBzdGVh
bSB2ZXJzaW9uLgoKKEdldHRpbmcgZmFyIG9mZiBPUEwzIGxhbmQgaGVyZS4gU29ycnkuIEkndmUg
bmV2ZXIgdXNlZCB0aGUgT1BMMyBzeW50aCBpbiAKdGhlIGNoaXApLgoKL1JpY2FyZAotLSAKUmlj
YXJkIFdvbGYgV2FuZGVybMO2ZiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpY2FyZHcoYXQp
YXhpcy5jb20KQXhpcyBDb21tdW5pY2F0aW9ucyBBQiwgTHVuZCwgU3dlZGVuICAgICAgICAgICAg
d3d3LmF4aXMuY29tClBob25lICs0NiA0NiAyNzIgMjAxNiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEZheCArNDYgNDYgMTMgNjEgMzAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
