From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 08/11] ASoC: phycore-ac97: Add DT support
Date: Fri, 31 May 2013 09:51:03 +0800
Message-ID: <20130531015101.GA22536@S2101-09.ap.freescale.net>
References: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
 <1369925513-19329-9-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369925513-19329-9-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXkgMzAsIDIwMTMgYXQgMDQ6NTE6NTBQTSArMDIwMCwgTWFya3VzIFBhcmdtYW5u
IHdyb3RlOgo+IEFkZCBkZXZpY2V0cmVlIHN1cHBvcnQgZm9yIHBoeWNvcmUtYWM5NyBkcml2ZXIu
Cj4gCj4gcGxhdGZvcm1fb2Zfbm9kZSBhbmQgY3B1X29mX25vZGUgYXJlIHNldCBhY2NvcmRpbmcg
dG8gdGhlIGZzbCxhdWRtdXgKPiBwaGFuZGxlLgo+IAo+IFRoaXMgcGF0Y2ggYWRkcyBoYW5kbGlu
ZyBvZiBhYzk3IHJlc2V0IGZ1bmN0aW9ucyBhY2NvcmRpbmcgdG8gZnNsIGFjOTcKPiBzdXBwb3J0
LiBUaGV5IGFyZSBzZXR1cCBmcm9tIGhlcmUgdG8gYXZvaWQgYm9hcmQgc3BlY2lmaWMgY29kZSBp
biB0aGUKPiBnZW5lcmljIGZzbC1zc2kgZHJpdmVyLgo+IAo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0
aGUgaGFuZGxpbmcgb2YgcGNhMTAwIGJvYXJkcyBmcm9tIG5vbi1EVCB0byBEVCBvbmx5Lgo+IHBj
bTA0MyBpcyBzdGlsbCBoYW5kbGVkIHdpdGhvdXQgRFQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFy
a3VzIFBhcmdtYW5uIDxtcGFAcGVuZ3V0cm9uaXguZGU+CgpDb21waWxpbmcgcGh5Y29yZS1hYzk3
IGFzIG1vZHVsZSwgIEkgZ290IHRoZSBmb2xsb3dpbmcgZXJyb3JzLgoKICBDQyBbTV0gIHNvdW5k
L3NvYy9mc2wvcGh5Y29yZS1hYzk3Lm8Kc291bmQvc29jL2ZzbC9waHljb3JlLWFjOTcuYzozMDU6
MTogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhfX2luaXR0ZXN04oCZCnNvdW5kL3NvYy9mc2wv
cGh5Y29yZS1hYzk3LmM6MTQ2OjE6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2Yg4oCYX19p
bml0dGVzdOKAmSB3YXMgaGVyZQpzb3VuZC9zb2MvZnNsL3BoeWNvcmUtYWM5Ny5jOjMwNToxOiBl
cnJvcjogcmVkZWZpbml0aW9uIG9mIOKAmGluaXRfbW9kdWxl4oCZCnNvdW5kL3NvYy9mc2wvcGh5
Y29yZS1hYzk3LmM6MTQ2OjE6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2Yg4oCYaW5pdF9t
b2R1bGXigJkgd2FzIGhlcmUKc291bmQvc29jL2ZzbC9waHljb3JlLWFjOTcuYzozMDU6MTogZXJy
b3I6IHJlZGVmaW5pdGlvbiBvZiDigJhfX2V4aXR0ZXN04oCZCnNvdW5kL3NvYy9mc2wvcGh5Y29y
ZS1hYzk3LmM6MTQ3OjE6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2Yg4oCYX19leGl0dGVz
dOKAmSB3YXMgaGVyZQpzb3VuZC9zb2MvZnNsL3BoeWNvcmUtYWM5Ny5jOjMwNToxOiBlcnJvcjog
cmVkZWZpbml0aW9uIG9mIOKAmGNsZWFudXBfbW9kdWxl4oCZCnNvdW5kL3NvYy9mc2wvcGh5Y29y
ZS1hYzk3LmM6MTQ3OjE6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2Yg4oCYY2xlYW51cF9t
b2R1bGXigJkgd2FzIGhlcmUKbWFrZVs0XTogKioqIFtzb3VuZC9zb2MvZnNsL3BoeWNvcmUtYWM5
Ny5vXSBFcnJvciAxCgpTaGF3bgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZGV2aWNldHJlZS1kaXNjdXNzIG1haWxpbmcgbGlzdApkZXZpY2V0cmVlLWRp
c2N1c3NAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8v
ZGV2aWNldHJlZS1kaXNjdXNzCg==
