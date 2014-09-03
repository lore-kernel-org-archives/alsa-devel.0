From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCHv2 4/4] ASoC: simple-card: binding: update binding to
 support the new style.
Date: Wed, 3 Sep 2014 01:54:07 +0000
Message-ID: <80a8421c4c51407ba24d4e9c6c5f3309@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
	<1409649969-15759-5-git-send-email-Li.Xiubo@freescale.com>
 <20140902124114.6d95e0c5@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140902124114.6d95e0c5@armhf>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "andrew-g2DYL2Zd6BY@public.gmane.org" <andrew-g2DYL2Zd6BY@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "jsarha-l0cyMroinI0@public.gmane.org" <jsarha-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

PiBTdWJqZWN0OiBSZTogW1BBVENIdjIgNC80XSBBU29DOiBzaW1wbGUtY2FyZDogYmluZGluZzog
dXBkYXRlIGJpbmRpbmcgdG8NCj4gc3VwcG9ydCB0aGUgbmV3IHN0eWxlLg0KPiANCj4gT24gVHVl
LCAyIFNlcCAyMDE0IDE3OjI2OjA5ICswODAwDQo+IFhpdWJvIExpIDxMaS5YaXVib0BmcmVlc2Nh
bGUuY29tPiB3cm90ZToNCj4gDQo+ID4gK0V4YW1wbGUgNCAtIG1hbnkgREFJIGxpbmtzOg0KPiA+
ICBzb3VuZCB7DQo+ID4gIAljb21wYXRpYmxlID0gInNpbXBsZS1hdWRpby1jYXJkIjsNCj4gPiAg
CXNpbXBsZS1hdWRpby1jYXJkLG5hbWUgPSAiQ3Vib3ggQXVkaW8iOw0KPiA+IEBAIC0xMjgsNiAr
MTk1LDcgQEAgc291bmQgew0KPiA+ICAJCX07DQo+ID4gIAkJY29kZWMgew0KPiA+ICAJCQlzb3Vu
ZC1kYWkgPSA8JnRkYTk5OHggMD47DQo+ID4gKwkJCWZyYW1lLWludmVyc2lvbjsNCj4gPiAgCQl9
Ow0KPiA+ICAJfTsNCj4gDQo+IFRoaXMgaXMgbm90IHVzZWZ1bDogdGhlcmUgaXMgbm8gY2xvY2sv
ZnJhbWUgaGFuZGxpbmcgaW4gdGhlIGtpcmt3b29kDQo+IGF1ZGlvIGNvbnRyb2xsZXIuDQo+IA0K
DQoNCk9rYXksIGp1c3QgZm9yIG9uZSBleGFtcGxlLCBpZiBpdCByZWFsbHkgbWF0dGVyIGhlcmUg
SSB3aWxsIHJlbW92ZSB0aGlzLg0KDQpUaGFua3MsDQoNCkJScw0KWGl1Ym8NCg0KDQo=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
