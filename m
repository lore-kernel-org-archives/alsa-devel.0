From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 3/3] uda1380: make driver more
	powersave-friendly
Date: Sun, 27 Jun 2010 22:40:38 +0100
Message-ID: <AF5669A2-7C35-4EC9-84A3-AD0018CD18C2@opensource.wolfsonmicro.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006271343.36646.anarsoul@gmail.com>
	<047B7693-6E49-4FB6-99C4-9C9DE53E0486@opensource.wolfsonmicro.com>
	<201006280015.27486.anarsoul@gmail.com>
	(sfid-20100627_221541_441941_B6DACF5F)
Mime-Version: 1.0 (iPad Mail 7B367)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47D092450B
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 23:39:56 +0200 (CEST)
In-Reply-To: <201006280015.27486.anarsoul@gmail.com>
	(sfid-20100627_221541_441941_B6DACF5F)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gMjcgSnVuIDIwMTAsIGF0IDIyOjE1LCBWYXNpbHkgS2hvcnV6aGljayA8YW5hcnNvdWxAZ21h
aWwuY29tPiB3cm90ZToKCj4g0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjcg0LjRjtC90Y8g
MjAxMCAyMzo1NToyOSDQsNCy0YLQvtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cj4gCj4+
IEFmdGVyIHBvd2VyIG9uIGl0J3Mgbm90IG5lZWRlZCwgdGhlIGRldmljZSBzaG91bGQgYmUgaW4g
dGhlIGRlZmF1bHQgc3RhdGUKPj4gYWxyZWFkeS4gSXQncyBvbmx5IHJlcXVpcmVkIG9uIHN0YXJ0
dXAgd2hlbiB0aGVyZSdzIG5vIHBvd2VyIGNvbnRyb2wgZm9yCj4+IHRoZSBkZXZpY2UuCj4gCj4g
QnV0IHRoYXQncyBub3QgcG9zc2libGUgdG8gcmVzZXQgY29kZWMgaWYgaXQgaXMgbm90IHBvd2Vy
ZWQgb24gOigKClNvIGRvbid0IHJlc2V0IGl0IGlmIHlvdSBoYXZlIGNvbnRyb2wgb2YgdGhlIHBv
d2VyPyBSZW1lbWJlciwgbm90IGFsbApzeXN0ZW1zIHdpbGwgaGF2ZSBzb2Z0IGNvbnRyb2wgb2Yg
dGhlIHBvd2VyIGZvciB0aGUgZGV2aWNlLiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
