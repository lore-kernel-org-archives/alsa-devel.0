From: David Weinehall <david.weinehall@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 3/4] snd: add support for
 displayport multi-stream to hda codec.
Date: Thu, 25 Jun 2015 15:52:42 +0300
Message-ID: <20150625125241.GR14570@boom>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <CAN8cciYWwDQaMdWXb-Tw9F728jxwqrQLWiGY2B+LszrDvFrw+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAN8cciYWwDQaMdWXb-Tw9F728jxwqrQLWiGY2B+LszrDvFrw+Q@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdW4gMjUsIDIwMTUgYXQgMDQ6MjI6MzhQTSArMDgwMCwgUmF5bW9uZCBZYXUgd3Jv
dGU6Cj4gPiA+Cj4gPiA+IFNoYWxsIHdlIG1vdmUgb3IgY2MgdGhpcyBkaXNjdXNzaW9uIG9uIGF1
ZGlvIGRyaXZlciBzaWRlIHRvIEFMU0EgTUw/Cj4gPgo+ID4gT29wcyBJIHRob3VnaHQgSSBoYWQg
Y2MnZWQgdGhlc2UgcGF0Y2hlcyB0byBhbHNhLWRldmVsIGFzIHdlbGwgd2hlbiBJCj4gc2VudCB0
aGVtLgo+ID4KPiA+ID4gSSB0aGluayB3ZSBhbHNvIG5lZWQgdG8gZGVjaWRlIGhvdyB0byBtYW5h
Z2UgUENNIGRldmljZXMgZm9yIERQIE1TVC4KPiA+ID4gTm93IHRoZSBIRC1BIGRyaXZlciBjcmVh
dGUgYSBQQ00gZGV2aWNlIGZvciBlYWNoIHBpbiwgYW5kIHRoZSBzdWJzdHJlYW0KPiA+ID4gbnVt
YmVyIGlzIDEgZm9yIGVhY2ggUENNLiBOb3cgd2l0aCBEUCBNU1QgZW5hYmxlZCwgZWFjaCBwaW4g
Y2FuIHN1cHBvcnQKPiA+ID4gbXVsdGlwbGUgc3RyZWFtcyAoZS5nLiAzIG9uIEludGVsIEhTVy9C
RFcvU0tMKS4KPiAKPiBXaGF0IGhhcmR3YXJlIGZlYXR1cmUgYXJlIGF2YWlsYWJsZSA/Cj4gCj4g
T25seSB0aHJlZSBtb25pdG9ycyBwbGF5aW5nIGRpZmZlcmVudCBhdWRpbyBzdHJlYW1zIG9yCj4g
Cj4gV2l0aCAxeDMgdmlkZW8gd2FsbCAsIGNhbiB0aGUgY2VudGVyIG1vbml0b3IgcGxheWJhY2sg
c3RlcmVvIHdoaWxlIHRoZSBsZWZ0Cj4gbW9uaXRvciBwbGF5IGxlZnQgY2hhbm5lbCBhbmQgcmln
aHQgbW9uaXRvciBwbGF5IHJpZ2h0IGNoYW5uZWwgPwoKT2hoaCwgY2xldmVyIGlkZWEgOikgIElm
IGl0IGlzbid0IHN1cHBvcnQgYWxyZWFkeSBpdCdkIG1ha2UgYW4gYXdlc29tZQpmZWF0dXJlIGF0
IGxlYXN0LgoKCktpbmQgcmVnYXJkcywgRGF2aWQKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pbnRlbC1nZngK
