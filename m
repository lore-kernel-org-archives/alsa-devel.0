From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 09:03:33 -0600
Message-ID: <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
References: <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E0C19267AF7
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 16:03:35 +0100 (CET)
In-Reply-To: <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDEyLzE3LzE4IDY6MTcgQU0sIERpbWl0cmlzIFBhcGF2YXNpbGlvdSB3cm90ZToKPiBPbiAx
Mi8xMy8xOCA3OjQyIFBNLCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBTYXQsIE5vdiAyNCwgMjAx
OCBhdCAxMDoxNzo0OVBNICswMjAwLCBEaW1pdHJpcyBQYXBhdmFzaWxpb3Ugd3JvdGU6Cj4+Cj4+
PiBkaXNjdXNzaW9uIGhlcmUuwqAgSSBzdGlsbCBmZWVsIHRoYXQgZml4aW5nIHRoZSBtYWNoaW5l
IGRyaXZlciwgc28KPj4+IHRoYXQgaXQgZG9lc24ndCBnZW5lcmF0ZSB0aGUgcG9wIGF0IGFsbCB3
b3VsZCBiZSBkZXNpcmFibGUsIGFzCj4+PiBJJ20gbm90IHN1cmUgd2hldGhlciB0aGUgZGlnaXRh
bF9tdXRlIGNhbGxiYWNrIGlzIGd1YXJhbnRlZWQgdG8KPj4+IGhhdmUgbXV0ZWQgdGhlIGRldmlj
ZSB3aGVuIHRoZSBjbG9jayBzb3VyY2UgdGFrZXMgcGxhY2UuCj4+Cj4+IE1ha2luZyB0aGUgbWFj
aGluZSBkcml2ZXIgbW9yZSByb2J1c3QgaXMgZGVmaW5pdGVseSBiZXR0ZXIsIGl0J3MgbW9yZQo+
PiByb2J1c3QgaW4gY2FzZSB0aGUgbXV0ZSBpcyBmb3IgZXhhbXBsZSBqdXN0IGEgdmVyeSBsb3cg
Z2FpbiB3aGljaCBtaWdodAo+PiBzdGlsbCBsZXQgdGhlIHBvcCB0aHJvdWdoIGF0IGEgbG93ZXIg
bGV2ZWwuCj4KPiBFdmVuIHdvcnNlLCBpdCB3b3VsZCBsZXQgdGhlIHBvcCB0aHJvdWdoIGF0IGZ1
bGwgdm9sdW1lLCBhcyBpdAo+IGRvZXNuJ3QgZGVwZW5kIG9uIHRoZSBnYWluLsKgIFN0aWxsLCB0
aGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgYQo+IHNhZmUgd2F5IHRvIGF2b2lkIHRoZSBwb3AgYWx0
b2dldGhlciwgYXMgZmFyIGFzIEkgY2FuIHNlZSwgc2luY2UKPiB0aGUgb25seSB3YXkgSSBoYXZl
IGZvdW5kIHRvIGF2b2lkIGl0LCBpcyB0byBzdXNwZW5kIHRoZSBjaGlwCj4gZHVyaW5nIHRoZSBz
d2l0Y2gsIGFuZCBJIGNhbid0IHN5bmNocm9uaXplIGFjY2VzcyB0byB0aGUgcmVsZXZhbnQKPiBy
ZWdpc3RlciBieSB0aGUgbWFjaGluZSBhbmQgQ09ERUMgZHJpdmVycy4KPgo+IElmIHlvdSBoYXZl
IGFueSBvdGhlciBpZGVhcy9wb2ludGVycyBvbiBhcHByb2FjaGVzIEkgY291bGQKPiBpbnZlc3Rp
Z2F0ZSwgcGxlYXNlIGxldCBtZSBrbm93Lgo+Ckkgc3RhcnRlZCBwcm90b3R5cGluZyBhIGRpZmZl
cmVudCBhcHByb2FjaCB3aGVyZSB0aGUgY29kZWMgZHJpdmVyIHBhc3NlcyAKdGhlIHJlZ21hcCBp
bmZvcm1hdGlvbiB0byB0aGUgY2xvY2sgZHJpdmVyLiBXaGF0J3MgbWlzc2luZyBpbiB0aGUgCnBh
dGNoc2V0IGlzIHRoZSBhZGRpdGlvbiBvZiBhIGNsb2NrIGNvbnRyb2wgaW4gdGhlIG1hY2hpbmUg
ZHJpdmVyLCBhbmQgCmxvZ2ljIGFkZGVkIHNvIHRoYXQgcmF0ZcKgIGNoYW5nZSBjYW4gb25seSBi
ZSBkb25lIGluIGEgaHdfcGFyYW1zIGlmIAp0aGVyZSB3YXMgYSBjb21wbGV0ZSBzdG9wIGFuZCBy
ZXNldCBvbiBhIERBUE1fT0ZGIGV2ZW50LiBjb21waWxlLXRlc3RlZCAKb25seSBmb3Igbm93LgoK
aHR0cHM6Ly9naXRodWIuY29tL3BsYm9zc2FydC9zb3VuZC9jb21taXRzL2hpZmliZXJyeS9jbGtz
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
