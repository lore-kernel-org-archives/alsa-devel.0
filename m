From: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AK4458: add regulator for ak4458
Date: Thu, 16 May 2019 14:11:31 +0000
Message-ID: <1558015890.29679.3.camel@nxp.com>
References: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
         <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
Content-Language: en-US
Content-ID: <9AFBB40C861ED643B8A18A2B24339827@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "festevam@gmail.com" <festevam@gmail.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "colin.king@canonical.com" <colin.king@canonical.com>, "viorel.suman@gmail.com" <viorel.suman@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>, Daniel Baluta <daniel.baluta@nxp.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gSm8sIDIwMTktMDUtMTYgYXQgMTA6MTQgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+
IE9uIFRodSwgTWF5IDE2LCAyMDE5IGF0IDEwOjAyIEFNIFZpb3JlbCBTdW1hbiA8dmlvcmVsLnN1
bWFuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGkg
PSAwOyBpIDwgQVJSQVlfU0laRShhazQ0NTgtPnN1cHBsaWVzKTsgaSsrKQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhazQ0NTgtPnN1cHBsaWVzW2ldLnN1cHBseSA9IGFrNDQ1
OF9zdXBwbHlfbmFtZXNbaV07DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IGRldm1f
cmVndWxhdG9yX2J1bGtfZ2V0KGFrNDQ1OC0+ZGV2LCBBUlJBWV9TSVpFKGFrNDQ1OC0+c3VwcGxp
ZXMpLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFrNDQ1OC0+c3VwcGxpZXMpOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChyZXQgIT0gMCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBkZXZfZXJyKGFrNDQ1OC0+ZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3Qgc3VwcGxpZXM6ICVk
XG4iLCByZXQpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0
Ow0KPiBUaGlzIHdvdWxkIGJyZWFrIGV4aXN0aW5nIHVzZXJzIHRoYXQgZG8gbm90IHBhc3MgdGhl
IHJlZ3VsYXRvcnMgaW4gZGV2aWNlIHRyZWUuDQo+IA0KPiBPaywgaW4gdGhpcyBjYXNlIHRoZXJl
IGlzIG5vIGFrNDQ1OCB1c2VyIGluIGFueSBkdHMsIHNvIHRoYXQgd291bGQgbm90DQo+IGJlIGFu
IGlzc3VlLg0KPiANCj4gUGxlYXNlIHVwZGF0ZSB0aGUgZHQtYmluZGluZ3Mgd2l0aCB0aGUgcmVn
dWxhdG9yIGVudHJpZXMuDQoNClRoYW5rcywgd2lsbCBzZW5kIGluIFYyLg0KDQovVmlvcmVs
