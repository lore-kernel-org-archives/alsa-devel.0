From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
 name of I2S driver
Date: Sat, 11 Sep 2010 10:26:24 +0900
Message-ID: <AANLkTik_oqW8LbStDBG_2G80bE4=JJyPbEb2yjU2D-vu@mail.gmail.com>
References: <4C4CEDE1.5010605@samsung.com>
	<20100909132259.GF25855@rakim.wolfsonmicro.main>
	<AANLkTimV8hQ6L2j2djDdCp6XJGDj3Hjq2Dv4iLnGJHQ1@mail.gmail.com>
	<201009110040.49213.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C651F2433D
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Sep 2010 03:26:27 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3382511wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 18:26:24 -0700 (PDT)
In-Reply-To: <201009110040.49213.anarsoul@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Kyungmin Park <kmpark@infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Chanwoo Choi <cw00.choi@samsung.com>, ben-linux <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBTZXAgMTEsIDIwMTAgYXQgNjo0MCBBTSwgVmFzaWx5IEtob3J1emhpY2sgPGFuYXJz
b3VsQGdtYWlsLmNvbT4gd3JvdGU6Cj4g0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMTAg0YHQ
tdC90YLRj9Cx0YDRjyAyMDEwIDExOjQzOjE0INCw0LLRgtC+0YAgSmFzc2kgQnJhciDQvdCw0L/Q
uNGB0LDQuzoKPj4gT24gVGh1LCBTZXAgOSwgMjAxMCBhdCAxMDoyMiBQTSwgTWFyayBCcm93bgo+
Pgo+PiA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+PiA+IE9u
IFRodSwgU2VwIDA5LCAyMDEwIGF0IDA5OjU2OjIzUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6
Cj4+ID4+IEkgd291bGQgbGlrZSB0byBoYXZlIHBvaW50cyB0byBjb25zaWRlciBmcm9tIGV2ZXJ5
IHN0YWtlaG9sZGVyLgo+PiA+Cj4+ID4gSSBkb24ndCByZWFsbHkgaGF2ZSBhbnl0aGluZyBteXNl
bGYsIHRob3VnaCBJIG1heSBoYXZlIHNvbWUgY29tbWVudHMgb24KPj4gPiB0aGUgYWN0dWFsIHBy
b3Bvc2FsIEkgZ3Vlc3MuCj4+Cj4+IEJ0dywgQUM5NywgUENNIGFuZCBETUEgd2VyZSBlYXN5IGtp
bGwuCj4+Cj4+IEl0J3MgSTJTIHRoYXQncyBQSVRBLgo+PiBJIGFtIHRoaW5raW5nIG9mIGxlYXZp
bmcgMjR4eC1pMnMsIGkuZSBwcmUtNjR4eChzaGFyZWQgd2l0aCAyNDEyKSwKPj4gdW5jaGFuZ2Vk
IGFuZCBsZXR0aW5nCj4+IHRoZW0gZGllIG9mIG9sZCBhZ2UgKG9ic29sZXRlZCBhbmQgZHJvcHBl
ZCBkdWx5IGlmIG5vIHN0YWtlaG9sZGVyIGtlZXBzCj4+IHVwKS4KPgo+IERvZXMgaXQgbWVhbiB0
aGVyZSdzIG5vIG9uZSB0byBzdXBwb3J0IHMzYzI0eHgtaTJzIChmb3IgczNjMjR4eCBzb2NzKT8K
QXMgTWFyayBzYWlkLCB0aGVyZSBhcmUgaW5kZWVkIHNvbWUgcGVvcGxlLgpKdXN0IEkgZG9uJ3Qg
aGF2ZSB0aGUgaC93IGhhbmR5IHRvIHdvcmsgYW5kIHRlc3QgYW55IGNoYW5nZXMuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
