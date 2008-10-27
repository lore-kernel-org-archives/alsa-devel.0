From: The Source <thesourcehim@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Mon, 27 Oct 2008 08:32:05 +0300
Message-ID: <49055255.8030102@gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk>	<4900DBBD.2020806@jasonline.co.uk>	<s5hljwee68t.wl%tiwai@suse.de>	<49017FBF.4030005@jasonline.co.uk>	<s5hfxmm47kb.wl%tiwai@suse.de>	<20081025130652.GA27621@rzle423.uni-duisburg.de>	<s5hej24psn6.wl%tiwai@suse.de>	<20081025194255.GA27872@rzle423.uni-duisburg.de>	<s5hod18fntg.wl%tiwai@suse.de>	<49038448.3090704@jasonline.co.uk>	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>	<s5h7i7v22cl.wl%tiwai@suse.de>
	<ge3irb$knf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F534245EE
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 06:32:25 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so697180eyc.56
	for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2008 22:32:07 -0700 (PDT)
In-Reply-To: <ge3irb$knf$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QWxleGFuZGVyIEUuIFBhdHJha292INC/0LjRiNC10YI6Cj4gVGFrYXNoaSBJd2FpIHdyb3RlOgo+
ICAgCj4+IEEgZmV3IGltcG9ydGFudCBmZWF0dXJlcyBhcmUgaW4gbXkgbWluZDoKPj4gLSBjb250
aW51b3VzIHJhdGUgc3VwcG9ydAo+PiAgICAgCj4KPiBJbiB0aGUgc291cmNlcywgeW91IGhhdmU6
Cj4KPiAgIAo+PiBOb3RlOiA0NC4xa0h6IGlzIHBvc3NpYmxlLCBidXQgaXMgbW9yZSBjb21wbGV4
IGJlY2F1c2UgaXQgdXNlcyBhIG1ldGhvZAo+PiB3aGVyZWJ5IHRoZSBjaGFubmVsIHJpbmcgbWFy
a3MgZWFjaCBzYW1wbGUgaW4gdGhlIGNoYW5uZWwgcmluZyBhcyB2YWxpZAo+PiBvciBub3QsIHNv
IHRvIGdldCA0NC4xa0h6LCBzb21lIHNhbXBsZXMgYXJlIHNpbXBseSB0YWdnZWQgaW52YWxpZC4g
VGhlCj4+ICJjaGFubmVsIHJpbmciIGlzIG5vdCB0aGUgcmluZyBidWZmZXIgdGhhdCBpcyB1c2Vk
IHRvIGdldCBzb3VuZCBzYW1wbGVzCj4+IHRvIHRoZSBjYXJkLiBUaGUgImNoYW5uZWwgcmluZyIg
aXMgdXNlZCB0byBwYXNzIHNhbXBsZXMgYmV0d2Vlbgo+PiBkaWZmZXJlbnQgcHJvY2Vzc2luZyBt
b2R1bGVzIG9uIHRoZSBjYXJkLiBPbmUgb2YgdGhlc2UgcHJvY2Vzc2luZwo+PiBtb2R1bGVzIGlz
IHRoZSBTUkMsIGFub3RoZXIgaXMgdGhlIElOcy9PVVRzLCBhbm90aGVyIGlzIHRoZSBoYXJkd2Fy
ZQo+PiBtaXhlciwgYW5kIHlldCBhbm90aGVyIGlzIHRoZSBEU1AuCj4+ICAgICAKPgo+IERvIEkg
dW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB0aGUgY2FyZCBpbnRlcm5hbGx5IHJlc2FtcGxlcyB0
aGUgc291bmQgCj4gdG8gYSBkaWZmZXJlbnQgcmF0ZSB1c2luZyB0aGUgemVyby1vcmRlci1ob2xk
IG1ldGhvZD8gSWYgc28sIEknZCByYXRoZXIgCj4gbm90IHNlZSB0aGlzIGZlYXR1cmUgYXQgYWxs
IHVubGVzcyB0aGUgImlfd2FudF9ob3JyaWJsZV9zb3VuZCIgcGFyYW1ldGVyIAo+IGlzIHBhc3Nl
ZCwgYmVjYXVzZSBzb2Z0d2FyZSBjYW4gZG8gaXQgYmV0dGVyLCBhbmQgc29tZSBwcm9ncmFtIHdp
bGwgCj4gc3VyZWx5IGRlZmF1bHQgdG8gdXNpbmcgdGhpcyBoYXJkd2FyZSBtaXNmZWF0dXJlLgo+
Cj4gT1RPSCwgV2luZSBpcyBkb2luZyB0aGlzIGZvciBhZ2VzIGFuZCBub2JvZHkgZXhjZXB0IG1l
IGNvbXBsYWlucyAKPiAoaHR0cDovL2J1Z3Mud2luZWhxLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTQ3
MTcpCj4KPiAgIApXaW5lIGNhdXNlcyBzb3VuZCBjb3JydXB0aW9uIHdpdGggdGhpcyBkcml2ZXIg
Zm9yIG1lIChhbG9uZyB3aXRoIHNvbWUgCm90aGVyIHNvZnR3YXJlIGxpa2UgUHVsc2VhdWRpbyku
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
