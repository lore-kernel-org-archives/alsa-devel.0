From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
Subject: Re: [PATCH v2 2/2] ASoC: Add bindings for PCM1789
Date: Thu, 8 Mar 2018 09:54:40 +0100
Message-ID: <20180308095440.515458eb@dell-desktop.home>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-3-mylene.josserand@bootlin.com>
 <20180307223048.lqnryaazr5egg2m7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E6A7E2673D6
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 09:54:42 +0100 (CET)
In-Reply-To: <20180307223048.lqnryaazr5egg2m7@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, michael@amarulasolutions.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, thomas.petazzoni@bootlin.com
List-Id: alsa-devel@alsa-project.org

SGVsbG8gUm9iLAoKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LgoKT24gV2VkLCA3IE1hciAyMDE4
IDE2OjMwOjQ4IC0wNjAwClJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOgoKPiBP
biBNb24sIE1hciAwNSwgMjAxOCBhdCAwMTo0ODoxN1BNICswMTAwLCBNeWzDqG5lIEpvc3NlcmFu
ZCB3cm90ZToKPiA+IEFkZCBhIGRldmljZS10cmVlIGJpbmRpbmcgZm9yIFRleGFzIEluc3RydW1l
bnQncyBQQ00xNzg5IGNvZGVjLgo+ID4gRm9yIHRoZSBtb21lbnQsIG9ubHkgSTJDIGJ1cyBpcyBz
dXBwb3J0ZWQgYnV0IFNQSSBjb3VsZCBiZSBhZGRlZAo+ID4gaW4gZnV0dXJlLgo+ID4gCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNeWzDqG5lIEpvc3NlcmFuZCA8bXlsZW5lLmpvc3NlcmFuZEBib290bGlu
LmNvbT4KPiA+IC0tLQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9wY20xNzg5LnR4dCB8IDIxICsrKysrKysrKysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9wY20xNzg5LnR4dAo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3BjbTE3ODkudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3BjbTE3ODkudHh0Cj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hNmNkYzJjODNj
OTgKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9wY20xNzg5LnR4dAo+ID4gQEAgLTAsMCArMSwyMSBAQAo+ID4gK1RleGFz
IEluc3RydW1lbnRzIHBjbTE3ODkgRFQgYmluZGluZ3MgIAo+IAo+IFdoYXQgZnVuY3Rpb24gZG9l
cyB0aGlzIGRldmljZSBwcm92aWRlPwoKU29ycnksIEkgZm9yZ290IHRvIG1lbnRpb24gdGhpcyBp
bmZvcm1hdGlvbi4KCj4gCj4gPiArCj4gPiArVGhpcyBkcml2ZXIgc3VwcG9ydHMgdGhlIEkyQyBi
dXMuICAKPiAKPiBCaW5kaW5ncyBkZXNjcmliZSBoL3csIG5vdCBkcml2ZXJzLgoKVHJ1ZSwgSSB3
aWxsIHJlZm9ybXVsYXRlIGl0LgoKPiAKPiA+ICsKPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+
ID4gKwo+ID4gKyAtIGNvbXBhdGlibGU6ICJ0aSxwY20xNzg5Igo+ID4gKwo+ID4gK1JlcXVpcmVk
IHByb3BlcnRpZXMgb24gSTJDOgo+ID4gKwo+ID4gKyAtIHJlZzogdGhlIEkyQyBhZGRyZXNzCj4g
PiArIC0gcmVzZXQtZ3Bpb3M6IEdQSU8gdG8gY29udHJvbCB0aGUgUkVTRVQgcGluCj4gPiArCj4g
PiArRXhhbXBsZXM6Cj4gPiArCj4gPiArCWNvZGVjOiBwY20xNzg5QDRjIHsgIAo+IAo+IGF1ZGlv
LWNvZGVjQDRjCj4gCj4gSWYgdGhhdCdzIHRoZSBmdW5jdGlvbi4uLgoKWWVwLCBJIHdpbGwgY2hh
bmdlIHRoYXQuCgo+IAo+ID4gKwkJY29tcGF0aWJsZSA9ICJ0aSxwY20xNzg5IjsKPiA+ICsJCXJl
ZyA9IDwweDRjPjsKPiA+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvMiAxNCBHUElPX0FDVElWRV9M
T1c+Owo+ID4gKwkJI3NvdW5kLWRhaS1jZWxscyA9IDwwPjsKPiA+ICsJfTsKPiA+IC0tIAo+ID4g
Mi4xMS4wCj4gPiAgIAoKVGhhbmtzLAoKQmVzdCByZWdhcmRzLAoKLS0gCk15bMOobmUgSm9zc2Vy
YW5kLCBCb290bGluIChmb3JtZXJseSBGcmVlIEVsZWN0cm9ucykKRW1iZWRkZWQgTGludXggYW5k
IEtlcm5lbCBlbmdpbmVlcmluZwpodHRwOi8vYm9vdGxpbi5jb20KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
