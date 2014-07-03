From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 3 Jul 2014 18:26:00 +0200
Message-ID: <20140703182600.7a98c5b6@armhf>
References: <20140702165628.GO20799@lunn.ch> <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
 <20140703133406.2d3e3a1d@armhf>
 <20140703115924.GY410@sirena.org.uk>
 <20140703152826.103c9d6c@armhf>
 <20140703134346.GW32514@n2100.arm.linux.org.uk>
 <20140703172909.60caf2c7@armhf>
 <20140703154325.GY32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140703154325.GY32514@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAzIEp1bCAyMDE0IDE2OjQzOjI1ICswMTAwClJ1c3NlbGwgS2luZyAtIEFSTSBMaW51
eCA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cgo+IFdoYXQgeW91J3JlIGRvaW5nIGlu
IGtpcmt3b29kLWkycyBpcyBwcm92aWRpbmcgdHdvIHBsYWluIERBSSBsaW5rcywKPiBhbmQgdGhl
biBpbnNpc3RpbmcgdGhhdCBvbmx5IG9uZSBjYW4gYmUgYWN0aXZlIGFueSBhbnkgb25lIHRpbWUu
Cj4gCj4gQSBEUENNIHNvbHV0aW9uIHByb3ZpZGVzIGF0IGxlYXN0IG9uZSBmcm9udGVuZCBEQUkg
bGluayBhbmQgYXQgbGVhc3QKPiBvbmUgYmFja2VuZCBEQUkgbGluay4gIFlvdXIgY29kZSBkb2Vz
IG5vdCBkbyB0aGlzLgoKWW91IGtub3cgd2h5IEkgZGlkIG5vdCBpbnNlcnQgdGhlIERQQ00gY29k
ZSBpbiB0aGUga2lya3dvb2QgZHJpdmVyOiBpdApkb2VzIG5vdCB3b3JrLiBCdXQsIGFzIEkgdGVz
dGVkIGl0IGVuZCAyMDEzLCBJIHN0aWxsIGhhdmUgdGhlIGNvZGUuCkRvIHlvdSB3YW50IEkgcHJv
cG9zZSBhIHBhdGNoPwoKPiBXaGljaCBiaXQgb2YgIndlIG5lZWQgdG8gc3VwcG9ydCBib3RoIEky
UyBhbmQgU1BESUYiIGluIG15IHByZXZpb3VzCj4gZW1haWxzIHdhcyBub3QgY2xlYXIuICBXaGlj
aCBiaXQgb2YgIldlIHNob3VsZCBvbmx5IHN1cHBvcnQgU1BESUYKPiBvbiB0aGUgQ3Vib3giIHdh
cyBub3QgY2xlYXI/Cj4gCj4gSSAqZnVsbHkqIGFja25vd2xlZGdlIHRoYXQgd2UgbmVlZCB0byBz
dXBwb3J0IGJvdGgsIGJ1dCBJJ20gcHV0dGluZwo+IGEgX3N0cm9uZ18gcmVjb21tZW5kYXRpb24g
dG8geW91IF93aXRoXyB0ZWNobmljYWwgcmVhc29ucyB3aHkgd2UKPiBzaG91bGQgX29ubHlfIHN1
cHBvcnQgU1BESUYgb24gdGhlIEN1Ym94LgoKU29ycnksIEkgc3RpbGwgZG9uJ3Qgc2VlIHdoeSBv
bmx5IFMvUERJRiBzaG91bGQgYmUgc3VwcG9ydGVkIG9uIHRoZQpDdWJveC4gSSBoYXZlIGJvdGgs
IGFuZCBib3RoIGFyZSB3b3JraW5nIG9uIEhETUkuIEkgaG9wZSBzb21lb25lIHdpbGwKdGVsbCBt
ZSBpdCBhbHNvIHdvcmtzIG9uIFMvUERJRjogdGhlcmUgaXMgbm8gcmVhc29uIGl0IGNvdWxkIG5v
dC4KCkkgZG9uJ3Qgc2VlIHlvdXIgdGVjaG5pY2FsIHJlYXNvbnM6IHlvdSBrbm93IHRoZSBjb25z
dHJhaW50cyBvZiBlYWNoCnByb3RvY29sIEkyUyBhbmQgUy9QRElGLiBJZiB5b3UgZG9uJ3Qgd2Fu
dCBJMlMsIGp1c3QgZG9uJ3QgZGVjbGFyZSBpdAppbiB0aGUgRFQgKHNlZSBteSBwcmV2aW91cyBt
YWlsKS4gWW91IG1heSBhbHNvIG5vdGUgdGhhdCBJIGRpZCBub3QgcHV0CmFueSBjaGFuZ2UgcmVs
YXRpdmUgdG8gdGhlIEN1Ym94IERUIGluIG15IHBhdGNoLgoKLS0gCktlbiBhciBjJ2hlbnRhw7EJ
fAkgICAgICAqKiBCcmVpemggaGEgTGludXggYXRhdiEgKioKSmVmCQl8CQlodHRwOi8vbW9pbmVq
Zi5mcmVlLmZyLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
