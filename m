From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/5] ASoC : dwc : support dw i2s in slave mode
Date: Wed, 7 Oct 2015 00:54:50 +0530
Message-ID: <CANv6ZMZuYuB7-ZjW6L8QC85qUJAqmBYfdMGyTpB4GNn4-dC6aQ@mail.gmail.com>
References: <1443217704-28814-1-git-send-email-alexander.deucher@amd.com>
 <1443217704-28814-2-git-send-email-alexander.deucher@amd.com>
 <20151005153117.GW12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20151005153117.GW12635@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBPY3QgNSwgMjAxNSBhdCA5OjAxIFBNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDI1LCAyMDE1IGF0IDA1OjQ4OjIyUE0gLTA0MDAs
IEFsZXggRGV1Y2hlciB3cm90ZToKPj4gRnJvbTogTWFydXRoaSBTcmluaXZhcyBCYXl5YXZhcmFw
dSA8TWFydXRoaS5CYXl5YXZhcmFwdUBhbWQuY29tPgo+Pgo+PiBkdyBpMnMgY29udHJvbGxlciBj
YW4gd29yayBpbiBzbGF2ZSBtb2RlLCBjb2RlYyBiZWluZyBtYXN0ZXIuCj4+IGR3IGkycyBpcyBt
YWRlIHRvIHN1cHBvcnQgbWFzdGVyL3NsYXZlIG9wZXJhdGlvbiwgYnkgcmVhZGluZyBkd2MKPj4g
cmVnaXN0ZXIuCj4KPiBJJ2xsIGFwcGx5IHRoaXMgYnV0IGNhbiB5b3UgcGxlYXNlIHNlbmQgYSBm
b2xsb3d1cCBpbXBsZW1lbnRpbmcgYQo+IF9kYWlfZm10KCkgb3BlcmF0aW9uIHRoYXQgY2hlY2tz
IHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBtb2RlIHdlJ3JlCj4gc2V0dGluZyBjb3JyZXNwb25kcyB0
byB3aGF0IHdlIHJlYWQgYmFjayBmcm9tIHRoZSBoYXJkd2FyZS4KCk9rLCBJIHdpbGwgc2VuZC4K
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IEFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCj4gaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
