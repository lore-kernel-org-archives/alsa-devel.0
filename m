From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 3 Jul 2014 13:34:06 +0200
Message-ID: <20140703133406.2d3e3a1d@armhf>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702194252.GN410@sirena.org.uk>
 <20140703074959.7c489912@armhf>
 <20140703104432.GV410@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140703104432.GV410@sirena.org.uk>
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
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAzIEp1bCAyMDE0IDExOjQ0OjMyICswMTAwCk1hcmsgQnJvd24gPGJyb29uaWVAa2Vy
bmVsLm9yZz4gd3JvdGU6Cgo+ID4gPiBJJ2QgZXhwZWN0IHRoaXMgdG8gcmV0dXJuIGFuIGVycm9y
IGZvciB0aGUgYnVzeSBEQUkgcmF0aGVyIHRoYW4ganVzdAo+ID4gPiBzaWxlbnRseSBpZ25vcmUg
aXQgZmFpbGluZyB0byBzdGFydCBvciAoYmV0dGVyKSBpbXBsZW1lbnQgc29tZSBjb250cm9sCj4g
PiA+IHRvIGxldCB0aGUgdXNlciBzZWxlY3Qgd2hpY2ggb2YgdGhlIERBSXMgaXMgYWN0aXZlLiAg
Cj4gCj4gPiBUaGlzIGlzIG5vdCBhbiBlcnJvci4gSWYgdGhlIGF1ZGlvIHN1YnN5c3RlbSAoRFBD
TSwgbm90IHRoZSB1c2VyKQo+ID4gY2hvb3NlcyB0byBhY3RpdmF0ZSBib3RoIEkyUyBhbmQgUy9Q
RElGLCB0aGlzIG1lYW5zIHRoZSBIRE1JIGF1ZGlvIG1heQo+ID4gYmUgdGFrZW4gZWl0aGVyIGZy
b20gSTJTIG9yIGZyb20gUy9QRElGOiBib3RoIGlucHV0cyBoYXZlIHRoZSByaWdodAo+ID4gZm9y
bWF0IGFuZCByYXRlLiAgCj4gCj4gWW91ciBib2FyZCBoYXBwZW5zIHRvIG9ubHkgYmUgYWJsZSB0
byBwcmVzZW50IHRoZSBzYW1lIGlucHV0IG9uIGJvdGggSTJTCj4gYW5kIFMvUERJRiBidXQgdGhh
dCBtaWdodCBub3QgYXBwbHkgdG8gb3RoZXIgYm9hcmRzLCB0aGV5IG1heSBiZSBhYmxlIHRvCj4g
cm91dGUgZGlmZmVyZW50IHNpZ25hbHMgdG8gZWFjaCB3aGljaCB3b3VsZCBwcmVzZW50IGEgcHJh
Y3RpY2FsIHByb2JsZW0uCgpJZiB0aGVyZSBhcmUgdHdvIGRpZmZlcmVudCBzdHJlYW1zcyBvbiBJ
MlMgYW5kIFMvUERJRiwgYW5kIGlmIHRoZSBhdWRpbwpzdWJzeXN0ZW0gd2FudHMgdG8gcm91dGUg
dGhlc2Ugc3RyZWFtcyB0byB0aGUgc2FtZSBjb25uZWN0b3IgKHdpZGdldAonaGRtaS1vdXQnKSwg
dGhlbiwgc29tZXdoZXJlLCB0aGVyZSBzaG91bGQgYmUgYSBzb2Z0d2FyZSBvciBhIGRlc2lnbgpi
dWcuIE5vPwoKQW55d2F5LCB0aGUgdGRhOTk4eCBjYW5ub3Qga25vdyBpZiB0aGUgZG91YmxlIHJv
dXRlIGlzIHdhbnRlZCBvciBub3QuCgotLSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJy
ZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
