From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/5] ASoC: Remove -dai suffix from Samsung
 DAI devices
Date: Fri, 13 Aug 2010 15:14:51 +0900
Message-ID: <4C64E2DB.5020602@samsung.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTinKaUygGxZc+pBg_LdOpvWcEErcf8yCvqfid5CU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DD37C24493
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 08:14:55 +0200 (CEST)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L7200AIFUORYY90@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 13 Aug 2010 15:14:51 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L72009JOUORWK@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 13 Aug 2010 15:14:51 +0900 (KST)
In-reply-to: <AANLkTinKaUygGxZc+pBg_LdOpvWcEErcf8yCvqfid5CU@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassisinghbrar@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Seungwhan Youn <sw.youn@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAyMDEwLTA4LTEzIOyYpO2bhCAyOjEyLCBTZXVuZ3doYW4gWW91biB3cm90ZToKPiBI
aSBNYXJrLAo+Cj4gT24gVGh1LCBBdWcgMTIsIDIwMTAgYXQgNzowMiBQTSwgTWFyayBCcm93bgo+
IDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gIHdyb3RlOgo+PiBUaGUgSVAg
YmxvY2tzIGFyZSBhbGwgZml4ZWQgZnVuY3Rpb24gYXVkaW8gY29udHJvbGxlcnMgc28gdGhlcmUn
cyBubwo+PiBuZWVkIHRvIGRlZHVwZSBhZ2FpbnN0IG90aGVyIHVzYWdlcyBhbmQgdGhlIGNvcnJl
c3BvbmRpbmcgYXJjaC9hcm0KPj4gdXBkYXRlcyBnb3QgbWlzc2VkIGFueXdheSBzbyByZXZlcnQg
dG8gdGhlIG9yaWdpbmFsIG5hbWVzIGZvciB0aGUKPj4gZHJpdmVycy4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogTWFyayBCcm93bjxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4KPj4g
LS0tCj4+ICAgc291bmQvc29jL3MzYzI0eHgvYXF1aWxhX3dtODk5NC5jICAgICAgICAgICAgICB8
ICAgIDIgKy0KPj4gICBzb3VuZC9zb2MvczNjMjR4eC9nb25pX3dtODk5NC5jICAgICAgICAgICAg
ICAgIHwgICAgMiArLQo+PiAgIHNvdW5kL3NvYy9zM2MyNHh4L2ppdmVfd204NzUwLmMgICAgICAg
ICAgICAgICAgfCAgICAyICstCj4+ICAgc291bmQvc29jL3MzYzI0eHgvbG4yNDQwc2JjX2FsYzY1
MC5jICAgICAgICAgICB8ICAgIDIgKy0KPj4gICBzb3VuZC9zb2MvczNjMjR4eC9uZW8xOTczX2d0
YTAyX3dtODc1My5jICAgICAgIHwgICAgMiArLQo+PiAgIHNvdW5kL3NvYy9zM2MyNHh4L25lbzE5
NzNfd204NzUzLmMgICAgICAgICAgICAgfCAgICAyICstCj4+ICAgc291bmQvc29jL3MzYzI0eHgv
czNjMjQxMi1pMnMuYyAgICAgICAgICAgICAgICB8ICAgIDIgKy0KPj4gICBzb3VuZC9zb2MvczNj
MjR4eC9zM2MyNHh4LWkycy5jICAgICAgICAgICAgICAgIHwgICAgMiArLQo+PiAgIHNvdW5kL3Nv
Yy9zM2MyNHh4L3MzYzI0eHhfc2ltdGVjX2hlcm1lcy5jICAgICAgfCAgICAyICstCj4+ICAgc291
bmQvc29jL3MzYzI0eHgvczNjMjR4eF9zaW10ZWNfdGx2MzIwYWljMjMuYyB8ICAgIDIgKy0KPj4g
ICBzb3VuZC9zb2MvczNjMjR4eC9zM2MyNHh4X3VkYTEzNHguYyAgICAgICAgICAgIHwgICAgMiAr
LQo+PiAgIHNvdW5kL3NvYy9zM2MyNHh4L3MzYzY0eHgtaTJzLXY0LmMgICAgICAgICAgICAgfCAg
ICAyICstCj4+ICAgc291bmQvc29jL3MzYzI0eHgvczNjNjR4eC1pMnMuYyAgICAgICAgICAgICAg
ICB8ICAgIDIgKy0KPj4gICBzb3VuZC9zb2MvczNjMjR4eC9zbWFydHFfd204OTg3LmMgICAgICAg
ICAgICAgIHwgICAgMiArLQo+PiAgIHNvdW5kL3NvYy9zM2MyNHh4L3NtZGs2NHh4X3dtODU4MC5j
ICAgICAgICAgICAgfCAgICA0ICsrLS0KPj4gICAxNSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zM2My
NHh4L2FxdWlsYV93bTg5OTQuYyBiL3NvdW5kL3NvYy9zM2MyNHh4L2FxdWlsYV93bTg5OTQuYwo+
PiBpbmRleCA0NGIwNmU5Li4yMzVkMTk3IDEwMDY0NAo+PiAtLS0gYS9zb3VuZC9zb2MvczNjMjR4
eC9hcXVpbGFfd204OTk0LmMKPj4gKysrIGIvc291bmQvc29jL3MzYzI0eHgvYXF1aWxhX3dtODk5
NC5jCj4+IEBAIC0yMzMsNyArMjMzLDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5r
IGFxdWlsYV9kYWlbXSA9IHsKPj4gICB7Cj4+ICAgICAgICAgLm5hbWUgPSAiV004OTk0IiwKPj4g
ICAgICAgICAuc3RyZWFtX25hbWUgPSAiV004OTk0IEhpRmkiLAo+PiAtICAgICAgIC5jcHVfZGFp
X25hbWUgPSAiczNjNjR4eC1pMnMtdjQtZGFpIiwKPj4gKyAgICAgICAuY3B1X2RhaV9uYW1lID0g
InMzYzY0eHgtaTJzLXY0IiwKPgo+IFRoaXMgYXF1aWxhIGJvYXJkIGFsc28gdXNlIEkyU3Y0IGZy
b20gJ3MzYzY0eHgtaTJzLXY0LmMnLCBzbyBJIHRoaW5rCj4gaXQnbGwgbm90IHdvcmsgaWYgY3B1
X2RhaV9uYW1lIGlzICdzM2M2NHh4LWkycy12NCcgbm90Cj4gJ3MzYzY0eHgtaWlzLXY0Jy4KCkl0
IGNvbmZ1c2VkIG1lIGEgbGl0dGxlIHRvIHVzZSB0d28gbmFtZXMgImlpcyIgYW5kICJpMnMiLiBD
YW4gd2UgdW5pZnkgCnRvIG9uZT8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
