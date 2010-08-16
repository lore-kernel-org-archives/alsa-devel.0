From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Mon, 16 Aug 2010 13:36:50 +0900
Message-ID: <AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B013E245CB
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 06:36:50 +0200 (CEST)
Received: by fxm11 with SMTP id 11so2799128fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2010 21:36:50 -0700 (PDT)
In-Reply-To: <20100815110924.GA25723@opensource.wolfsonmicro.com>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBBdWcgMTUsIDIwMTAgYXQgODowOSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+Cj4gV2hhdCB3b3VsZCBiZSBtdWNoIG1v
cmUgc3RyYWlnaHRmb3J3YXJkIGZvciB0aGlzIGNvbmZpZ3VyYXRpb24gaXMgdG8gcnVuCj4gdGhl
IFBMTCBvdXRwdXQgZnJvbSB0aGUgQ09ERUMgaW50byB0aGUgQ1BVIGFuZCB0aGVuIGhhdmUgdGhl
IENQVSBtYXN0ZXIKPiB0aGUgYWN0dWFsIGF1ZGlvIGludGVyZmFjZSBidXQgSmFzc2kgd2FzIGZh
aXJseSBpbnNpc3RlbnQgb24gaGF2aW5nIHRoZQo+IENPREVDIG1hc3RlciB0aGUgYnVzIGFuZCBJ
J2QgbmVlZCB0byB2ZXJpZnkgYWdhaW4gd2l0aCB0aGUgc2NoZW1hdGljIGlmCj4gdGhlIGFwcHJv
cHJpYXRlIGNsb2NrIGxpbmVzIGFyZSBydW4uIMKgQWN0dWFsbHksIEkgdGhpbmsgSSdsbCBqdXN0
IGRvCj4gdGhhdCBpZiB0aGUgaGFyZHdhcmUgYWxsb3dzLgoKRm9yIHVzLCBoYXZpbmcgQ1BVIGlu
IHNsYXZlIG1vZGUgaXMgbW9yZSBpbXBvcnRhbnQgdGhhbiBjbGVhcmluZyBhbGwgdGhlCnVzZSBj
YXNlcyBwZXJmZWN0bHkgb24gYSBfcmVmZXJlbmNlXyBwbGF0Zm9ybS4KTW9yZSBzbyB3aGVuIHRo
ZSAncHJvYmxlbScgY2FuIGJlIG9idmlvdXNseSBhdHRyaWJ1dGVkIHRvIHRoZSBoL3cgZGVzaWdu
LgoKU28gcGxlYXNlIG1vZGlmeSBvbmx5IGlmIHlvdSBtdXN0LCBvdGhlcndpc2UsIGFzIEkgc2Fp
ZCwgd2UnZCBwcmVmZXIKQ1BVIHNsYXZlIG1vZGUgd29ya2luZwpieSBkZWZhdWx0IGluIG1haW5s
aW5lLgoKVGhhbmtzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
