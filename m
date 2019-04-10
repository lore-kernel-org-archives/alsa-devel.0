From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v3 2/4] dt-bindings: fsl,audmix: remove "model" attribute
Date: Wed, 10 Apr 2019 10:37:30 +0000
Message-ID: <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
References: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

UmVtb3ZlICJtb2RlbCIgYXR0cmlidXRlLg0KDQpTaWduZWQtb2ZmLWJ5OiBWaW9yZWwgU3VtYW4g
PHZpb3JlbC5zdW1hbkBueHAuY29tPg0KQWNrZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3Rz
dWthQGdtYWlsLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9mc2wsYXVkbWl4LnR4dCB8IDQgLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kL2ZzbCxhdWRtaXgudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kL2ZzbCxhdWRtaXgudHh0DQppbmRleCA0NWY4MDdlLi44NDBiN2UwIDEwMDY0NA0KLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbCxhdWRtaXgudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGF1ZG1peC50
eHQNCkBAIC0zOCw5ICszOCw2IEBAIERldmljZSBkcml2ZXIgcmVxdWlyZWQgcHJvcGVydGllczoN
CiAJCQkgIHRvIFNBSSBpbnRlcmZhY2VzIHRvIGJlIHByb3ZpZGVkLCB0aGUgZmlyc3QgU0FJIGlu
IHRoZQ0KIAkJCSAgbGlzdCBiZWluZyB1c2VkIHRvIHJvdXRlIHRoZSBBVURNSVggb3V0cHV0Lg0K
IA0KLSAgLSBtb2RlbAkJOiBNdXN0IGNvbnRhaW4gbWFjaGluZSBkcml2ZXIgbmFtZSB3aGljaCB3
aWxsIGNvbmZpZ3VyZQ0KLQkJCSAgYW5kIGluc3RhbnRpYXRlIHRoZSBhcHByb3ByaWF0ZSBhdWRp
byBjYXJkLg0KLQ0KIERldmljZSBkcml2ZXIgY29uZmlndXJhdGlvbiBleGFtcGxlOg0KID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICBhdWRtaXg6IGF1ZG1peEA1OTg0
MDAwMCB7DQpAQCAtNTAsNSArNDcsNCBAQCBEZXZpY2UgZHJpdmVyIGNvbmZpZ3VyYXRpb24gZXhh
bXBsZToNCiAgICAgY2xvY2stbmFtZXMgPSAiaXBnIjsNCiAgICAgcG93ZXItZG9tYWlucyA9IDwm
cGRfYXVkbWl4PjsNCiAgICAgZGFpcyA9IDwmc2FpND4sIDwmc2FpNT47DQotICAgIG1vZGVsID0g
ImlteC1hdWRtaXgiOw0KICAgfTsNCi0tIA0KMi43LjQNCg0K
