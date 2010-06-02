From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2 1/3]AsoC/nuc900: patch for
	SUBSTREAM_TYPE', 'PCM_TX' 	and 'PCM_RX' removal
Date: Wed, 2 Jun 2010 14:07:29 +0800
Message-ID: <AANLkTimXnh5C5Yz0Xd7BtOCx3MVucSU2POtJNiM9AOLr@mail.gmail.com>
References: <4C05F211.7070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 80239244CD
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 08:07:31 +0200 (CEST)
Received: by vws8 with SMTP id 8so875330vws.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 23:07:29 -0700 (PDT)
In-Reply-To: <4C05F211.7070308@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

SSBhbSBzb3JyeSBmb3Igd3Jvbmcgc3ViamVjdC4KSXQgc2hvdWxkIGJlIFtQQVRDSCB2MiAxLzRd
LgoKCgo+IFRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIHRoZSAnU1VCU1RSRUFNX1RZUEUnLCdQQ01f
VFgnIGFuZCAnUENNX1JYJyBkZWZpbml0aW9uLgo+Cj4gVGhlcmUgaXMgbm8gbmVlZCB0byByZWRl
ZmluZSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLIGFzIFBDTV9UWCwKPiB0aGUgU1VCU1RSRUFN
X1RZUEUoc3Vic3RyZWFtKSBjYW4gYmUgZGVsZXRlZCB0b28sIHRoZSBwbGF5YmFjayBvciByZWNv
cmQgY2FuIGJlCj4ganVkZ2VkIGJ5ICdpZiAoc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENN
X1NUUkVBTV9QTEFZQkFDSyknIGRpcmVjdGx5IHJhdGhlcgo+IHRoYW4gJ2lmIChQQ01fVFggPT0g
c3R5cGUpJywgd2hpY2ggbWFrZXMgdGhlIGNvZGVzIGVhc3kgdG8gcmVhZC4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFdhbiBab25nU2h1bjxtY3Vvcy5jb21AZ21haWwuY29tPgo+Cj4gLS0tCj4gwqBzb3Vu
ZC9zb2MvbnVjOTAwL251YzkwMC1hYzk3LmMgwqB8IMKgIMKgNiArKystLS0KPiDCoHNvdW5kL3Nv
Yy9udWM5MDAvbnVjOTAwLWF1aWRvLmggfCDCoCDCoDQgLS0tLQo+IMKgc291bmQvc29jL251Yzkw
MC9udWM5MDAtcGNtLmMgwqAgfCDCoCAxOCArKysrKysrKysrLS0tLS0tLS0KPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
