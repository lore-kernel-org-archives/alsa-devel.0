From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 21:14:09 +0200
Message-ID: <51EED601.5050509@ti.com>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
 <1374583782.2475.26.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id CC28F265192
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 21:14:15 +0200 (CEST)
In-Reply-To: <1374583782.2475.26.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDcvMjMvMjAxMyAwMjo0OSBQTSwgTGlhbSBHaXJkd29vZCB3cm90ZToKPiBPbiBUdWUsIDIw
MTMtMDctMjMgYXQgMTE6MTIgKzAyMDAsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToKPj4gVGhl
c2UgdHdvIGZ1bmN0aW9ucyB3ZXJlIGFkZGVkIHR3byB5ZWFycyBhZ28gaW4gY29tbWl0IDQ4MDU2
MDggKCJBU29DOiBkYXBtIC0KPj4gQWRkIG1ldGhvZHMgdG8gcmV0cmlldmUgc25kX2NhcmQgYW5k
IHNvY19jYXJkIGZyb20gZGFwbSBjb250ZXh0LiIpIGJ1dCBoYXZlCj4+IHJlbWFpbmVkIHVudXNl
ZCBzbyBmYXIuIENvbnNpZGVyaW5nIHRoYXQgdGhlIGRhcG0gY29udGV4dCBhY3R1YWxseSBoYXMg
YSBkaXJlY3QKPj4gcG9pbnRlciB0byB0aGUgY2FyZCB0aGUgZnVuY3Rpb25zIGFsc28gc2VlbSB0
byBiZSB1bm5lY2Vzc2FyeS4gRS5nLiB0aGUKPj4gZXhwcmVzc2lvbnMgJ2RhcG1fZ2V0X3NvY19j
YXJkKGRhcG0pJyBhbmQgJ2RhcG0tPmNhcmQnIHlpZWxkIHRoZSBzYW1lIHJlc3VsdC4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Cj4+IC0t
LQo+IAo+IFBldGVyIG1heSBoYXZlIGEgdXNlciBmb3IgdGhlc2UsIGJ1dCBtYXliZSBub3QgPwoK
Tm8sIEkgZG8gbm90IHVzZSB0aGVzZS4KCi0tIApQw6l0ZXIKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
