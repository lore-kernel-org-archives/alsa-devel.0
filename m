From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH RESEND v6 1/3] ASoC: uda1380: make driver
 more powersave-friendly
Date: Mon, 30 Aug 2010 10:31:30 +0100
Message-ID: <1283160690.3055.19.camel@odin>
References: <1283156889-5544-1-git-send-email-anarsoul@gmail.com>
	<1283156889-5544-2-git-send-email-anarsoul@gmail.com>
	<201008301043.22165.marek.vasut@gmail.com>
	<201008301218.52125.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 05937103849
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 11:31:33 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2960312ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 02:31:33 -0700 (PDT)
In-Reply-To: <201008301218.52125.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMDEwLTA4LTMwIGF0IDEyOjE4ICswMzAwLCBWYXNpbHkgS2hvcnV6aGljayB3cm90
ZToKPiDQkiDRgdC+0L7QsdGJ0LXQvdC40Lgg0L7RgiAzMCDQsNCy0LPRg9GB0YLQsCAyMDEwIDEx
OjQzOjIyINCw0LLRgtC+0YAgTWFyZWsgVmFzdXQg0L3QsNC/0LjRgdCw0Ls6Cj4gPiBEbmUgUG8g
MzAuIHNycG5hIDIwMTAgMTA6Mjg6MDcgVmFzaWx5IEtob3J1emhpY2sgbmFwc2FsKGEpOgo+ID4g
PiBEaXNhYmxlIHNvbWUgY29kZWMgbW9kdWxlcyBpbiBzdGFuZGJ5IG1vZGUsIGNvbXBsZXRlbHkg
ZGlzYWJsZQo+ID4gPiBjb2RlYyBpbiBvZmYgbW9kZSB0byBzYXZlIHNvbWUgcG93ZXIuCj4gPiA+
IEZpeCBzdXNwZW5kL3Jlc3VtZTogbWFyayBtaXhlciByZWdzIGFzIGRpcnR5IG9uIHJlc3VtZSB0
bwo+ID4gPiByZXN0b3JlIG1peGVyIHZhbHVlcywgb3RoZXJ3aXNlIGRyaXZlciBwcm9kdWNlcyBu
byBzb3VuZAo+ID4gPiAobWFzdGVyIGlzIG11dGVkIGJ5IGRlZmF1bHQpLgo+ID4gPiAKPiA+ID4g
U2lnbmVkLW9mZi1ieTogVmFzaWx5IEtob3J1emhpY2sgPGFuYXJzb3VsQGdtYWlsLmNvbT4KPiA+
IAo+ID4gUGxlYXNlIGhhdmUgbXk6Cj4gPiAKPiA+IEFja2VkLWJ5OiBNYXJlayBWYXN1dCA8bWFy
ZWsudmFzdXRAZ21haWwuY29tPgo+IAo+IERvZXMgaXQgbWVhbiBJIHNob3VsZCByZXNlbmQgcGF0
Y2hlcyB3aXRoIHRoaXMgbGluZSBpbmNsdWRlZD8gOikKCk5vLgotLSAKRnJlZWxhbmNlIERldmVs
b3BlciwgU2xpbUxvZ2ljIEx0ZApBU29DIGFuZCBWb2x0YWdlIFJlZ3VsYXRvciBNYWludGFpbmVy
LgpodHRwOi8vd3d3LnNsaW1sb2dpYy5jby51awoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
