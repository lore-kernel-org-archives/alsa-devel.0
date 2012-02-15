From: "joey.jiaojg" <joey.jiaojg@gmail.com>
Subject: Re: Bug report - patch_realtek.c - Laptop HP COMPAQ
 B1900 Series
Date: Wed, 15 Feb 2012 17:45:37 +0800
Message-ID: <4F3B7EC1.4000503@gmail.com>
References: <4F35C191.9080401@gmail.com>
	<20120211020502.GA25041@marvin.atrad.com.au>
	<CAN8cciZejU6suH_pF5OzpVgjjUYsYgTCf14T5J=0G-c0wSfyAA@mail.gmail.com>
	<CAKOmCvoS+tgvyPZJey4gfFFq=Uz01pnZY7YvGbxgQPpAzQ7KCA@mail.gmail.com>
	<CAKOmCvofbM9+5SGSMkAP=ansfxCz835LF3GfM6=OF3zn-+10iw@mail.gmail.com>
	<CAN8cciY2M+9h-3BROUV03VuNL5WLJsxG-Tx1+MG5=+kxrZqaoQ@mail.gmail.com>
	<4F3B761D.4060306@gmail.com> <s5h8vk4wivv.wl%tiwai@suse.de>
	<4F3B7B80.5030102@gmail.com> <s5h39acwi30.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 19C6C2436C
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 10:45:46 +0100 (CET)
Received: by iabz21 with SMTP id z21so1290207iab.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 01:45:46 -0800 (PST)
In-Reply-To: <s5h39acwi30.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, pshou@realtek.com.tw, ALSA Development Mailing List <alsa-devel@alsa-project.org>, kailang@realtek.com.tw
List-Id: alsa-devel@alsa-project.org

SSBoYXZlIHRyaWVkIHRvIGVuYWJsZSBlYWNoIG9uZSBvZiB0aGVtIHNlcGFyYXRlbHksIGFuZCB0
aGUgc3BlYWtlciAKZG9lc24ndCB3b3JrLgpJIGhhdmUgdG8gdXNlIHRoZXNlIDMgd3JpdGVfY2Fj
aGUgdG8gbWFrZSBzd2l0Y2ggYW5kIGF1dG8tZGV0ZWN0IHdvcmsgCnNtb290aGx5LgoKT24gMjAx
MuW5tDAy5pyIMTXml6UgMTc6NDAsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBBdCBXZWQsIDE1IEZl
YiAyMDEyIDE3OjMxOjQ0ICswODAwLAo+IGpvZXkuamlhb2pnIHdyb3RlOgo+PiBIZXJlIGlzIHRo
ZSBkaWZmIGZpbGUuCj4gVGhhbmtzLgo+Cj4+ICsvKiB0b2dnbGUgc3BlYWtlci1vdXRwdXQgYWNj
b3JkaW5nIHRvIHRoZSBocC1qYWNrIHN0YXRlICovCj4+ICtzdGF0aWMgdm9pZCBhbGMyNjBfYjE5
MDBfYXV0b211dGUoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCj4+ICt7Cj4+ICsgICAgICAgIHVu
c2lnbmVkIGludCBwcmVzZW50Owo+PiArCj4+ICsJcHJlc2VudCA9IHNuZF9oZGFfamFja19kZXRl
Y3QoY29kZWMsIDB4MGYpOwo+PiArCWlmIChwcmVzZW50KSB7Cj4+ICsJCXNuZF9oZGFfY29kZWNf
d3JpdGVfY2FjaGUoY29kZWMsIDB4MDEsIDAsCj4+ICsJCQkJCSAgQUNfVkVSQl9TRVRfR1BJT19N
QVNLLCAwKTsKPj4gKwkJc25kX2hkYV9jb2RlY193cml0ZV9jYWNoZShjb2RlYywgMHgwMSwgMCwK
Pj4gKwkJCQkJICBBQ19WRVJCX1NFVF9HUElPX0RJUkVDVElPTiwKPj4gKwkJCQkJICAwKTsKPiBX
aGF0IGFjdHVhbGx5IHRoaXMgR1BJTyBiaXQgZG9lcyBvbiB5b3VyIGRldmljZT8KPiBUbyBtdXRl
L3VubXV0ZSB0aGUgc3BlYWtlcj8KPgo+IElmIHNvLCBkb2Vzbid0IHRoZSBzcGVha2VyIHRvZ2ds
ZSB3b3JrIHdpdGgganVzdCBjaGFuZ2luZyB0aGUKPiBwaW4tY29udHJvbCBvZiB0aGUgY29ycmVz
cG9uZGluZyBwaW4/Cj4KPgo+IFRha2FzaGkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
