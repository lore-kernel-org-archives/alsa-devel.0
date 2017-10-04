From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: regression introduced by commit 70d435ba1cd6 ("ASoC:
 imx-pcm-dma: simplify pcm_config")
Date: Wed, 4 Oct 2017 10:36:57 +0200
Message-ID: <20171004103657.1c6a433d@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de
 [80.67.18.14]) by alsa0.perex.cz (Postfix) with ESMTP id 779D8267222
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 10:37:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

SGksCgp0aGUgY29tbWl0IDcwZDQzNWJhMWNkNiAoIkFTb0M6IGlteC1wY20tZG1hOiBzaW1wbGlm
eSBwY21fY29uZmlnIikKaW50cm9kdWNlZCBhIHJlZ3Jlc3Npb24gb24gdGhlIEthLVJvIFRYIHNl
cmllcyBtb2R1bGVzIChhbmQgcG9zc2libHkKb3RoZXIgaGFyZHdhcmUgYXMgd2VsbCkuCgpUaGUg
cHJvYmxlbSBpcywgdGhhdCB0aGlzIGNvbW1pdCByZXN0cmljdHMgdGhlIHN1cHBvcnRlZCBzb3Vu
ZCBmb3JtYXRzCnRvIFMyNF9MRSBvbmx5IHJhdGhlciB0aGFuIFMxNl9MRSwgUzI0X0xFLCBTMjBf
M0xFIHdpdGhvdXQgdGhlCnBhdGNoLiBUaGVyZWZvcmUgYXBsYXkgZmFpbHMgd2l0aCB0aGUgZm9s
bG93aW5nIGVycm9yIG1lc3NhZ2VzLCB3aGVuCnRyeWluZyB0byBwbGF5IGEgc291bmQgZmlsZSB3
aXRoIFMxNl9MRSBmb3JtYXQ6CnxBTFNBIGxpYiBhbHNhLWxpYi0xLjEuMi9zcmMvcGNtL3BjbV9w
YXJhbXMuYzoyMTYyOihzbmQxX3BjbV9od19yZWZpbmVfc2xhdmUpIFNsYXZlIFBDTSBub3QgdXNh
YmxlCnxhcGxheTogc2V0X3BhcmFtczoxMjA0OiBCcm9rZW4gY29uZmlndXJhdGlvbiBmb3IgdGhp
cyBQQ006IG5vIGNvbmZpZ3VyYXRpb25zIGF2YWlsYWJsZQoKVGhpcyBpcyB3aXRoIHRoZSBzaW1w
bGUtc291bmQtY2FyZCBkcml2ZXIgYXMgd2VsbCBhcyB0aGUgaW14LXNndGw1MDAwCmRyaXZlci4K
CkNhbiBzb21lb25lIHRlbGwgbWUgb24gd2hhdCBoYXJkd2FyZSBhbmQgd2l0aCB3aGF0IHNvZnR3
YXJlIGhhcyB0aGlzCnBhdGNoIGJlZW4gdGVzdGVkPwoKCkxvdGhhciBXYcOfbWFubgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
