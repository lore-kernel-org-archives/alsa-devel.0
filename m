From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] eukrea-tlv320: add support for cpuimx35sd
Date: Mon, 19 Jul 2010 19:55:03 +0100
Message-ID: <1279565703.3063.7.camel@odin>
References: <1279528832-7916-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B3019243E2
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 20:55:10 +0200 (CEST)
Received: by wwe15 with SMTP id 15so471312wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 11:55:07 -0700 (PDT)
In-Reply-To: <1279528832-7916-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMDEwLTA3LTE5IGF0IDEwOjQwICswMjAwLCBFcmljIELDqW5hcmQgd3JvdGU6Cj4g
U2lnbmVkLW9mZi1ieTogRXJpYyBCw6luYXJkIDxlcmljQGV1a3JlYS5jb20+Cj4gLS0tCj4gIHNv
dW5kL3NvYy9pbXgvS2NvbmZpZyAgICAgICAgIHwgICAgMiArLQo+ICBzb3VuZC9zb2MvaW14L2V1
a3JlYS10bHYzMjAuYyB8ICAgIDMgKystCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW14L0tjb25m
aWcgYi9zb3VuZC9zb2MvaW14L0tjb25maWcKPiBpbmRleCAyZjBkNmQzLi41MmRhYzVlIDEwMDY0
NAo+IC0tLSBhL3NvdW5kL3NvYy9pbXgvS2NvbmZpZwo+ICsrKyBiL3NvdW5kL3NvYy9pbXgvS2Nv
bmZpZwo+IEBAIC0zMiw2ICszMiw2IEBAIGNvbmZpZyBTTkRfU09DX0VVS1JFQV9UTFYzMjAKPiAg
CXNlbGVjdCBTTkRfU09DX1RMVjMyMEFJQzIzCj4gIAloZWxwCj4gIAkgIEVuYWJsZSBJMlMgYmFz
ZWQgYWNjZXNzIHRvIHRoZSBUTFYzMjBBSUMyM0IgY29kZWMgYXR0YWNoZWQKPiAtCSAgdG8gdGhl
IFNTSTQgaW50ZXJmYWNlCj4gKwkgIHRvIHRoZSBTU0kgaW50ZXJmYWNlCj4gIAo+ICBlbmRpZgkj
IFNORF9JTVhfU09DCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5j
IGIvc291bmQvc29jL2lteC9ldWtyZWEtdGx2MzIwLmMKPiBpbmRleCA0NWY1ZTRiLi5mMTVkZmJk
IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5jCj4gKysrIGIvc291
bmQvc29jL2lteC9ldWtyZWEtdGx2MzIwLmMKPiBAQCAtMTAxLDcgKzEwMSw4IEBAIHN0YXRpYyBp
bnQgX19pbml0IGV1a3JlYV90bHYzMjBfaW5pdCh2b2lkKQo+ICB7Cj4gIAlpbnQgcmV0Owo+ICAK
PiAtCWlmICghbWFjaGluZV9pc19ldWtyZWFfY3B1aW14MjcoKSAmJiAhbWFjaGluZV9pc19ldWty
ZWFfY3B1aW14MjVzZCgpKQo+ICsJaWYgKCFtYWNoaW5lX2lzX2V1a3JlYV9jcHVpbXgyNygpICYm
ICFtYWNoaW5lX2lzX2V1a3JlYV9jcHVpbXgyNXNkKCkKPiArCQkmJiAhbWFjaGluZV9pc19ldWty
ZWFfY3B1aW14MzVzZCgpKQo+ICAJCS8qIHJldHVybiBoYXBweS4gV2UgbWlnaHQgcnVuIG9uIGEg
dG90YWxseSBkaWZmZXJlbnQgbWFjaGluZSAqLwo+ICAJCXJldHVybiAwOwo+ICAKQWNrZWQtYnk6
IExpYW0gR2lyZHdvb2QgPGxyZ0BzbGltbG9naWMuY28udWs+Ci0tIApGcmVlbGFuY2UgRGV2ZWxv
cGVyLCBTbGltTG9naWMgTHRkCkFTb0MgYW5kIFZvbHRhZ2UgUmVndWxhdG9yIE1haW50YWluZXIu
Cmh0dHA6Ly93d3cuc2xpbWxvZ2ljLmNvLnVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
