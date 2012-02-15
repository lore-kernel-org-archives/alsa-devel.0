From: "joey.jiaojg" <joey.jiaojg@gmail.com>
Subject: Re: Bug report - patch_realtek.c - Laptop HP COMPAQ
 B1900 Series
Date: Wed, 15 Feb 2012 18:06:39 +0800
Message-ID: <4F3B83AF.3020301@gmail.com>
References: <4F35C191.9080401@gmail.com>
	<20120211020502.GA25041@marvin.atrad.com.au>
	<CAN8cciZejU6suH_pF5OzpVgjjUYsYgTCf14T5J=0G-c0wSfyAA@mail.gmail.com>
	<CAKOmCvoS+tgvyPZJey4gfFFq=Uz01pnZY7YvGbxgQPpAzQ7KCA@mail.gmail.com>
	<CAKOmCvofbM9+5SGSMkAP=ansfxCz835LF3GfM6=OF3zn-+10iw@mail.gmail.com>
	<CAN8cciY2M+9h-3BROUV03VuNL5WLJsxG-Tx1+MG5=+kxrZqaoQ@mail.gmail.com>
	<4F3B761D.4060306@gmail.com> <s5h8vk4wivv.wl%tiwai@suse.de>
	<4F3B7B80.5030102@gmail.com> <s5h39acwi30.wl%tiwai@suse.de>
	<4F3B7EC1.4000503@gmail.com> <s5hy5s4v2og.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 91B172440D
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 11:06:57 +0100 (CET)
Received: by iabz21 with SMTP id z21so1314264iab.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 02:06:56 -0800 (PST)
In-Reply-To: <s5hy5s4v2og.wl%tiwai@suse.de>
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

T0ssIHRoZSBzaXR1YXRpb24gaXMgMHgwMSBpcyB0byBjb250cm9sIEdQSU8wOgoxLiBpZiBJIHdy
aXRlIChjb2RlYywweDAxLDAsQUNfVkVSQl9TRVRfR1BJT19NQVNLLDEpIG9ubHk7IHRoZSByZXN1
bHQgaXMgCnNwZWFrZXIgbm90IHdvcmsuCgoyLiBpZiBJIHdyaXRlIChjb2RlYywweDAxLDAsQUNf
VkVSQl9TRVRfR1BJT19ESVJFQ1RJT04sMSkgb25seTsgdGhlIApyZXN1bHQgaXMgc3BlYWtlciBu
b3Qgd29yay4KCjMuIElmIEkgd3JpdGUgc3RlcCAxICYgMiB0b2dldGhlciwgc3BlYWtlciB3b3Jr
cyB3aGVuIEkgcmVib290LgoKNC4gVGhlbiBJZiBJIHBsdWdnZWQgaW4gdGhlIGhlYWRwaG9uZSwg
dGhlIGhlYWRwaG9uZSBkb2Vzbid0IHdvcmsuIEl0IApvbmx5IHdvcmtzIHdoZW4gSSB3cml0ZSAK
KGNvZGVjLDB4MEYsMCxBQ19WRVJCX1NFVF9QSU5fV0lER0VUX0NPTlRST0wsUElOX0hQKS4KCjUu
IEZyb20gc3RlcCAzICYgNCwgaXQncyBzaW1pbGFyIGZvciBjYXNlcyB0aGF0IEkgcmVib290IHdp
dGggaGVhZHBob25lIApwbHVnZ2VkIGluLiBUaGF0IGlzLCBpZiBJIHJlbW92ZSBoZWFkcGhvbmUs
IHNwZWFrZXIgZG9lc24ndCB3b3JrIAphdXRvbWF0aWNhbGx5LiBJZiBJIHdyaXRlIAooY29kZWMs
MHgwRiwwLEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09OVFJPTCxQSU5fT1VUKSwgdGhlIAphdXRv
LWRldGVjdGlvbiBmdW5jdGlvbiB3b3JrcyB3ZWxsIGNhbiBzd2l0Y2ggc3BlYWtlci9oZWFkcGhv
bmUgCmF1dG9tYXRpY2FsbHkuCgpJIGRvbid0IGtub3cgd2h5IGl0J3MgdGhpcyBjYXNlLCBhbmQg
ZnJvbSBhbHNhIGRvY3VtZW50LCBpdCBzZWVtcyBvbmx5IAplbmFibGUgR1BJTzAgd2lsbCB3b3Jr
IGJ1dCBhY3R1YWxseSBub3QuCgoKT24gMjAxMuW5tDAy5pyIMTXml6UgMTc6NTgsIFRha2FzaGkg
SXdhaSB3cm90ZToKPiBBdCBXZWQsIDE1IEZlYiAyMDEyIDE3OjQ1OjM3ICswODAwLAo+IGpvZXku
amlhb2pnIHdyb3RlOgo+PiBJIGhhdmUgdHJpZWQgdG8gZW5hYmxlIGVhY2ggb25lIG9mIHRoZW0g
c2VwYXJhdGVseSwgYW5kIHRoZSBzcGVha2VyCj4+IGRvZXNuJ3Qgd29yay4KPiBTb3JyeSwgaXQn
cyBub3QgY2xlYXIgd2hhdCB5b3UgbWVhbnQuICBFYWNoIG9mIHdoYXQgc2VwYXJhdGVseT8KPiBB
bmQgd2hhdCBkb2VzIEdQSU8gZG8gZXhhY3RseT8KPgo+PiBJIGhhdmUgdG8gdXNlIHRoZXNlIDMg
d3JpdGVfY2FjaGUgdG8gbWFrZSBzd2l0Y2ggYW5kIGF1dG8tZGV0ZWN0IHdvcmsKPj4gc21vb3Ro
bHkuCj4gV2UgbmVlZCB0byBrbm93IHRoZSByZWFzb24gd2h5IHRoZXNlIG11c3QgYmUgbmVlZGVk
Lgo+Cj4KPiBUYWthc2hpCj4KPgo+PiBPbiAyMDEy5bm0MDLmnIgxNeaXpSAxNzo0MCwgVGFrYXNo
aSBJd2FpIHdyb3RlOgo+Pj4gQXQgV2VkLCAxNSBGZWIgMjAxMiAxNzozMTo0NCArMDgwMCwKPj4+
IGpvZXkuamlhb2pnIHdyb3RlOgo+Pj4+IEhlcmUgaXMgdGhlIGRpZmYgZmlsZS4KPj4+IFRoYW5r
cy4KPj4+Cj4+Pj4gKy8qIHRvZ2dsZSBzcGVha2VyLW91dHB1dCBhY2NvcmRpbmcgdG8gdGhlIGhw
LWphY2sgc3RhdGUgKi8KPj4+PiArc3RhdGljIHZvaWQgYWxjMjYwX2IxOTAwX2F1dG9tdXRlKHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjKQo+Pj4+ICt7Cj4+Pj4gKyAgICAgICAgdW5zaWduZWQgaW50
IHByZXNlbnQ7Cj4+Pj4gKwo+Pj4+ICsJcHJlc2VudCA9IHNuZF9oZGFfamFja19kZXRlY3QoY29k
ZWMsIDB4MGYpOwo+Pj4+ICsJaWYgKHByZXNlbnQpIHsKPj4+PiArCQlzbmRfaGRhX2NvZGVjX3dy
aXRlX2NhY2hlKGNvZGVjLCAweDAxLCAwLAo+Pj4+ICsJCQkJCSAgQUNfVkVSQl9TRVRfR1BJT19N
QVNLLCAwKTsKPj4+PiArCQlzbmRfaGRhX2NvZGVjX3dyaXRlX2NhY2hlKGNvZGVjLCAweDAxLCAw
LAo+Pj4+ICsJCQkJCSAgQUNfVkVSQl9TRVRfR1BJT19ESVJFQ1RJT04sCj4+Pj4gKwkJCQkJICAw
KTsKPj4+IFdoYXQgYWN0dWFsbHkgdGhpcyBHUElPIGJpdCBkb2VzIG9uIHlvdXIgZGV2aWNlPwo+
Pj4gVG8gbXV0ZS91bm11dGUgdGhlIHNwZWFrZXI/Cj4+Pgo+Pj4gSWYgc28sIGRvZXNuJ3QgdGhl
IHNwZWFrZXIgdG9nZ2xlIHdvcmsgd2l0aCBqdXN0IGNoYW5naW5nIHRoZQo+Pj4gcGluLWNvbnRy
b2wgb2YgdGhlIGNvcnJlc3BvbmRpbmcgcGluPwo+Pj4KPj4+Cj4+PiBUYWthc2hpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
