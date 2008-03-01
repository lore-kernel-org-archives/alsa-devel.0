From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] improved snd-aloop quality when
	using	certain samplerates and kernel HZ
Date: Sat, 1 Mar 2008 12:55:06 +0100
Message-ID: <20080301115506.GA7175@mathematik.uni-freiburg.de>
References: <20080219030144.GA12698@mathematik.uni-freiburg.de>
	<20080219125046.GA6455@mathematik.uni-freiburg.de>
	<s5hhcg3svd4.wl%tiwai@suse.de>
	<20080220141906.GA15096@mathematik.uni-freiburg.de>
	<s5h3arnpq4i.wl%tiwai@suse.de>
	<20080221000601.GA4829@mathematik.uni-freiburg.de>
	<s5hmypusssj.wl%tiwai@suse.de>
	<20080222180528.GD6860@mathematik.uni-freiburg.de>
	<s5h7igps3nv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 20273247D3
	for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2008 12:55:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7igps3nv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

PiA+IHNlZSwgdGhhdCB0aGUgYnVmZmVyIGFjdHVhbGx5IGRpZCBnbyBmdXJ0aGVyLCB3aGljaCBp
cyBwcm92aWRlZCBieSB0aGVzZQo+ID4gcGF0Y2hlcy4KPiBBcHBsaWVkIHRvIEhHIHRyZWUgbm93
LiAgVGhhbmtzLgoKY291bGQgaXQgYmUsIHRoYXQgeW91IHN0aWxsIGZvcmdvdCB0byBhcHBseSB0
aGlzIHBhdGNoLCBidXQgZGlkIHRoZSBvdGhlcj8KCltzbmQtYWxvb3AgLSBiZXR0ZXIgcmVhbHRp
bWUgYXBwIHN1cHBvcnRdCmh0dHA6Ly93d3cubWF0aGVtYXRpay51bmktZnJlaWJ1cmcuZGUvSUFN
L2hvbWVwYWdlcy9haW5hbi9hbHNhLWRyaXZlci1oZy1hbG9vcC1haW5hbi1wYXRjaDIuZGlmZgpb
U2lnbmVkLW9mZi1ieTogQWhtZXQgxLBuYW4gPGFpbmFuIDxhdD4gbWF0aGVtYXRpay51bmktZnJl
aWJ1cmcuZGU+XQoKb3IgeW91IGhhdmVudCBzeW5jZWQgaG9tZSBhbHNhLWRyaXZlciB3aXRoIG1h
aW4gcmVwb3NpdG9yeSB5ZXQsCnRoZW4gbmV2ZXIgbWluZCA6KQoKdGhhbmtzCgphaG1ldAoKLS0K
YWRtaW4gZGVyIGFidGVpbHVuZyBmw7xyIGFuZ2V3YW5kdGUgbWF0aGVtYXRpaywgdGVsLiAwNzYx
LTIwMy01NjI2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
