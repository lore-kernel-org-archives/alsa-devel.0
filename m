From: Michael Zoran <mzoran@crowfest.net>
Subject: Re: [PATCH 4/4] dts: bcm283x.dtsi: Add analog
 audio/headphone jack for bcm2835
Date: Tue, 14 Mar 2017 03:18:44 -0700
Message-ID: <1489486724.656.9.camel@crowfest.net>
References: <20170312063820.19313-1-mzoran@crowfest.net>
 <20170312063820.19313-4-mzoran@crowfest.net>
 <a5ae562f-6843-f137-6470-36c53cfd1799@i2se.com>
 <1489481279.656.1.camel@crowfest.net>
 <952dc3e0-a01a-bb21-78bd-d3639251c84a@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw.crowfest.net (gw.crowfest.net [52.42.241.221])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A84E266E41
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 11:18:46 +0100 (CET)
In-Reply-To: <952dc3e0-a01a-bb21-78bd-d3639251c84a@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Wahren <stefan.wahren@i2se.com>, perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, eric@anholt.net, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAyMDE3LTAzLTE0IGF0IDExOjA3ICswMTAwLCBTdGVmYW4gV2FocmVuIHdyb3RlOgo+
IEFtIDE0LjAzLjIwMTcgdW0gMDk6NDcgc2NocmllYiBNaWNoYWVsIFpvcmFuOgo+ID4gT24gVHVl
LCAyMDE3LTAzLTE0IGF0IDA5OjA1ICswMTAwLCBTdGVmYW4gV2FocmVuIHdyb3RlOgo+ID4gCj4g
PiA+IEFGQUlLIHRoZSBSYXNwYmVycnkgUGkgMyB1c2VzIHBpbiA0MCBhbmQgNDEuCj4gPiA+IAo+
ID4gCj4gPiBJIGRpZCBhbGwgbXkgdGVzdGluZyBvbiB0aGUgUlBJIDMsIHNvIEknbSBhbG1vc3Qg
Y2VydGFpbiBpdCdzCj4gPiBjb3JyZWN0LsKgCj4gPiBJdCBtYXRjaGVzIHdpdGggdGhlIHNjaGVt
YXRpYyBhbmQgaXQgbWF0Y2hlcyB3aXRoIHdoYXQgdGhlCj4gPiBkb3duc3RyZWFtCj4gPiB0cmVl
IHVzZXMgZm9yIHRoZSBmaXJtd2FyZSBiYXNlZCBkcml2ZXIoZHVtbXkgY2xhaW1pbmcgb2YgcGlu
cykuCj4gCj4gVGhlIHJlZHVjZWQgc2NoZW1hdGljIHRoYXQgaSBoYXZlIG5hbWUgdGhlIHBpbnMg
YXMgQVVEX1BXTTAgYW5kCj4gQVVEX1BXTTEsIHdoaWNoIHNheXMgbm90aGluZyBhYm91dCB0aGUg
YWN0dWFsIHBpbnMuIERvIHlvdSBoYXZlIGEKPiBiZXR0ZXIKPiBkb2N1bWVudD8KPiAKPiBJbiB0
aGUgZmlybXdhcmUgZHQtYmxvYi5kdHMgWzFdIHRoZSBSYXNwYmVycnkgUGkgMyB1c2VzIHBpbiA0
MCBhbmQKPiA0MS4KPiAKPiBbMV0gLSBodHRwczovL2dpdGh1Yi5jb20vcmFzcGJlcnJ5cGkvZmly
bXdhcmUvYmxvYi9tYXN0ZXIvZXh0cmEvZHQtYmwKPiBvYi5kdHMKCkhlcmUgYXJlIHRoZSByZWZl
cmVuY2VzIEkgdXNlZDoKCmh0dHBzOi8vd3d3LnJhc3BiZXJyeXBpLm9yZy9kb2N1bWVudGF0aW9u
L2hhcmR3YXJlL3Jhc3BiZXJyeXBpL3NjaGVtYXRpCmNzL1Jhc3BiZXJyeS1QaS1SZXYtMi4wLU1v
ZGVsLUFCLVNjaGVtYXRpY3MucGRmCgpodHRwczovL2dpdGh1Yi5jb20vcmFzcGJlcnJ5cGkvbGlu
dXgvYmxvYi9ycGktNC45LnkvYXJjaC9hcm0vYm9vdC9kdHMvbwp2ZXJsYXlzL3B3bS0yY2hhbi1v
dmVybGF5LmR0cwoKQnV0IGxvb2tpbmcgYXQgdGhlIGRvd25zdHJlYW0gc3BlY2lmaWMgUlBJIDMg
ZGV2aWNlIHRyZWUsIG1heWJlIGl0CnNob3VsZCBiZSA0MCw0MSBpbnN0ZWFkIG9mIDQwLDQ1LgoK
VGhlIHNvdXJjZSBjb2RlIGFuZCB0cmVlIEkgc3VibWl0dGVkIGRvZXMgd29yay4gIEJ1dCBJIGFn
cmVlIHRoaXMgaXMKc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQuCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
