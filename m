From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: ak5558: Remove redundant
 snd_soc_component_read32 calls
Date: Tue, 6 Nov 2018 09:47:44 +0000
Message-ID: <1541497661.3164.55.camel@nxp.com>
References: <20181106093919.20740-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0058.outbound.protection.outlook.com [104.47.0.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E797267839
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 10:47:47 +0100 (CET)
In-Reply-To: <20181106093919.20740-1-axel.lin@ingics.com>
Content-Language: en-US
Content-ID: <4461FDCB4309204FA14731ADBC63E8A5@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "axel.lin@ingics.com" <axel.lin@ingics.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTWEsIDIwMTgtMTEtMDYgYXQgMTc6MzkgKzA4MDAsIEF4ZWwgTGluIHdyb3RlOg0KPiBzbmRf
c29jX2NvbXBvbmVudF91cGRhdGVfYml0cygpIHdpbGwgb25seSB1cGRhdGUgdGhlIG1hc2sgYml0
cywNCj4gc28gcmVtb3ZlIHRoZSByZWR1bmRhbnQgc25kX3NvY19jb21wb25lbnRfcmVhZDMyKCku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AaW5naWNzLmNvbT4NCg0K
VGhhbmtzIEF4ZWwhwqANCg0KUmV2aWV3ZWQtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1
dGFAbnhwLmNvbT4NCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
