From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/3] Add runtime PM for SAI digital audio interface
Date: Sun, 21 Apr 2019 19:39:07 +0000
Message-ID: <20190421193853.10188-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Rmlyc3QgcGF0Y2ggZml4ZXMgYSBidWcgYnkgY29ycmVjdGx5IHNldHRpbmcgaXNfc2xhdmVfbW9k
ZSwgdGhlbg0Kc2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcnVudGltZSBQTSBhbmQgZmlu
YWxseSAzcmQgcGF0Y2ggbW92ZXMNCmNsb2NrIGhhbmRsaW5nIGZyb20gc3RhcnR1cC9zaHR1ZG93
biBmdW5jdGlvbiB0byBydW50aW1lIFBNIGhhbmRsZXJzLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0K
CS0gYWRkZWQgcGF0Y2ggMQ0KCS0gYWRkZWQgZnNsX3NhaV9yZW1vdmUgaW4gb3JkZXIgdG8gY2Fs
bCBwbV9ydW50aW1lX2Rpc2FibGUNCgktIG9ubHkgZGlzYWJsZS9lbmFibGUgbWNsayB3aGVuIFNB
SSBpbiBtYXN0ZXIgbW9kZS4NCg0KRGFuaWVsIEJhbHV0YSAoMik6DQogIEFTb0M6IGZzbF9zYWk6
IFVwZGF0ZSBpc19zbGF2ZV9tb2RlIHdpdGggY29ycmVjdCB2YWx1ZQ0KICBBU29DOiBmc2xfc2Fp
OiBBZGQgc3VwcG9ydCBmb3IgcnVudGltZSBwbQ0KDQpTaGVuZ2ppdSBXYW5nICgxKToNCiAgQVNv
QzogZnNsX3NhaTogTW92ZSBjbG9jayBvcGVyYXRpb24gdG8gUE0gcnVudGltZQ0KDQogc291bmQv
c29jL2ZzbC9mc2xfc2FpLmMgfCA4NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjE3LjENCg0K
