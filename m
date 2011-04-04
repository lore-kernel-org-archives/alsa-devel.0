From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: Correct i2s implementation for s3c2416
Date: Mon, 4 Apr 2011 21:01:24 +0200
Message-ID: <201104042101.25149.heiko@sntech.de>
References: <201104041630.58529.heiko@sntech.de>
	<BANLkTindPOvEHQz=rpaeGpMdxC+46d=M8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s15407518.onlinehome-server.info
	(s15407518.onlinehome-server.info [82.165.136.167])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F5A5103818
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 21:01:33 +0200 (CEST)
In-Reply-To: <BANLkTindPOvEHQz=rpaeGpMdxC+46d=M8A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QW0gTW9udGFnIDA0IEFwcmlsIDIwMTEsIDE5OjU2OjMwIHNjaHJpZWIgSmFzc2kgQnJhcjoKPiBP
biBNb24sIEFwciA0LCAyMDExIGF0IDg6MDAgUE0sIEhlaWtvIFN0w7xibmVyIDxoZWlrb0BzbnRl
Y2guZGU+IHdyb3RlOgo+ID4gVGhlIGkycy5jIGFuZCAuaCBzZWVtIHRvIGJlIG1hZGUgZm9yIHRo
ZSBzM2M2NHh4IGFuZCB1cCAoYWNjb3JkaW5nIHRvIHRoZQo+ID4gaW5pdGlhbCBjb21taXQgbWVz
c2FnZSkuCj4gCj4gWWVzLCB0aGF0IHNoYXJlcyB0aGUgY29tbW9uIGNvcmUgb2YgUzNDNjRYWCBh
bmQgdXAuCj4gCj4gPiBUaGlzIGxlYXZlcyB0aGUgczNjLWkycy12MitzM2MyNDEyX2kycyBjb21i
aW5hdGlvbiBhbmQgczNjMjR4eC1paXMuCj4gCj4gSUlSQywgMjQxNiBhbmQgNjR4eCBoYXZlIHNp
bWlsYXIgKGV4YWN0bHkgc2FtZT8pIEkyUyBibG9ja3MuIFNvLCB5b3UgbmVlZAo+IHRvIHNpbXBs
eSBmb2xsb3cgd2hhdCBpcyBiZWluZyBkb25lIGZvciBJMlMgb24gU01ESzY0MTAgYXMgYW4gZXhh
bXBsZS4KdGhhbmtzLgoKSSB0aGluayB0aGlzIHN1Z2dlc3Rpb24gc2F2ZWQgbWUgYWxvdCBvZiBo
b3VycyBhbmQgZ3JleSBoYWlyIDotKQoKRnJvbSBteSBpbmV4cGVyaWVuY2VkIHZpZXdwb2ludCB0
aGUgMjQxNiBzZWVtZWQgbW9yZSBzaW1pbGFyIHRvIHRoZSAyNDEyLiAKVGhlcmVmb3JlIEkgc3Rh
cnRlZCBtZWRkbGluZyB3aXRoIHRoaXMgaTJzIGRyaXZlci4gQnV0IHdpdGggeW91ciBwb2ludGVy
IGV2ZW4gCnRoZSBzM2M2NDAwLXJlbWVuYW50cyBpbiB0aGUgdmVuZG9yIGtlcm5lbHMgWzFdIHdl
IHBvc3NlcyBtYWtlIHNlbnNlLgoKU28gYWdhaW4gdGhhbmtzCkhlaWtvCgoKWzFdIGh0dHBzOi8v
Z2l0b3Jpb3VzLm9yZy9veW8taGFjay92ZW5kb3Ita2VybmVscwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
