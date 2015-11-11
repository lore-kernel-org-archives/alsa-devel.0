From: Caleb Crome <caleb@crome.org>
Subject: Re: ASoC: multicodec: No matching channels with system
 with DACs and ADCs on same bus
Date: Wed, 11 Nov 2015 12:15:27 -0800
Message-ID: <CAG5mAdwBuHdq=+b_NYWfC=awLaA94jwE_LHBLk28JuBQSzj_2w@mail.gmail.com>
References: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
 <alpine.DEB.2.02.1511110828390.15792@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id A6C5F261AAB
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 21:15:47 +0100 (CET)
Received: by wmec201 with SMTP id c201so62649386wme.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 12:15:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1511110828390.15792@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBOb3YgMTAsIDIwMTUgYXQgMTE6MzggUE0sIFJpY2FyZCBXYW5kZXJsb2YgPApyaWNh
cmQud2FuZGVybG9mQGF4aXMuY29tPiB3cm90ZToKCj4KPiBPbiBUdWUsIDEwIE5vdiAyMDE1LCBD
YWxlYiBDcm9tZSB3cm90ZToKPgo+ID4gICBJIGhhdmUgYSBzeXN0ZW0gdGhhdCBoYXMgc2VwYXJh
dGUgREFDcyBhbmQgQURDcywgYXMgb3Bwb3NlZCB0bwo+ID4gYmlkaXJlY3Rpb25hbCBDT0RFQ1Mu
Cj4gPgo+ID4gVGhlIEFEQ3MgaGF2ZSBhIHNuZF9zb2NfZGFpX2RyaXZlciBzdHJ1Y3R1cmUgdGhh
dCBoYXZlIGEgLmNhcHR1cmUKPiA+IGZpZWxkIGRlZmluZWQgd2l0aCBhIC5yYXRlcyBwYXJhbWV0
ZXIsIGFuZCB0aGUgREFDcyBoYXZlIGEKPiA+IHNuZF9zb2NfZGFpX2RyaXZlciBzdHJ1Y3R1cmUg
dGhhdCBoYXZlIGEgLnBsYXliYWNrIGZpZWxkIGRlZmluZWQgd2l0aAo+ID4gYSAucmF0ZXMgcGFy
YW1ldGVyLgo+ID4KPiA+IEhvd2V2ZXIsIHRoZSBBRENzIGhhdmUgbm8gLnBsYXliYWNrLnJhdGVz
LCBhbmQgdGhlIERBQ3MgaGF2ZSBubwo+ID4gLmNhcHR1cmUucmF0ZXMuIEV2ZW4gdGhvdWdoIHRo
ZSBBREMgY2FuIHJlY29yZCBhdCBhIGdpdmVuIHJhdGUgYW5kIHRoZQo+ID4gREFDIGNhbiBwbGF5
IGF0IHRoYXQgc2FtZSByYXRlLCB0aGUgc29jX3BjbV9pbml0X3J1bnRpbWVfaHcgZnVuY3Rpb24K
PiA+IGNhbGN1bGF0ZXMgdGhlIHJhdGVzIGluIHRoaXMgbG9vcDoKPiA+IC4uLgo+Cj4gSSBoYWQg
dGhlIHNhbWUgcHJvYmxlbSBlYXJsaWVyIHRoaXMgeWVhci4gSSBzdWJtaXR0ZWQgYSBwYXRjaCB3
aGljaCB0YWtlcwo+IGNhcmUgb2YgdGhpcyB0aGF0IHdhcyBhcHBsaWVkIGEgbGl0dGxlIG92ZXIg
YSBtb250aCBhZ286Cj4KPgo+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJt
YWlsL2Fsc2EtZGV2ZWwvMjAxNS1TZXB0ZW1iZXIvMDk3NzI5Lmh0bWwKPgo+Ci9SaWNhcmQKPiAt
LQo+IFJpY2FyZCBXb2xmIFdhbmRlcmzDtmYgICAgICAgICAgICAgICAgICAgICAgICAgICByaWNh
cmR3KGF0KWF4aXMuY29tCj4gQXhpcyBDb21tdW5pY2F0aW9ucyBBQiwgTHVuZCwgU3dlZGVuICAg
ICAgICAgICAgd3d3LmF4aXMuY29tCj4gUGhvbmUgKzQ2IDQ2IDI3MiAyMDE2ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRmF4ICs0NiA0NiAxMyA2MSAzMAo+CgpZZXAsIHBlcmZlY3QuICBUaGFu
a3MsCiAgLUNhbGViCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
