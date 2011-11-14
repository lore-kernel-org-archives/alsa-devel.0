From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: Remove unused control_data and mutex
 fields from struct alc5632_priv
Date: Mon, 14 Nov 2011 23:42:06 +0200
Message-ID: <CALq1K=K+qsMbA174-kqWxwASZ6Z1BrSOfWt0o=gvwSQoEcTOyA@mail.gmail.com>
References: <1321156588.23115.1.camel@phoenix>
	<CALq1K=KZVhVMXWhrq0MeBOvr7kXjdRe7yxVdqdCg4HBuD3FB-g@mail.gmail.com>
	<20111114212136.GB6528@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 81DAA243DA
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:42:27 +0100 (CET)
Received: by wwe6 with SMTP id 6so4286707wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 13:42:27 -0800 (PST)
In-Reply-To: <20111114212136.GB6528@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, Andrey Danin <danindrey@mail.ru>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBOb3YgMTQsIDIwMTEgYXQgMjM6MjEsIE1hcmsgQnJvd24KPGJyb29uaWVAb3BlbnNv
dXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBTdW4sIE5vdiAxMywgMjAxMSBhdCAw
OTo0Nzo1OVBNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6Cj4KPj4gTWFyaywgTGlhbSBk
byBJIG5lZWQgdG8gc2lnbiBBY2tlZC1PZmYtQnkgb24gdGhpcyB0eXBlIG9mIHBhdGNoPwo+Cj4g
WW91IGRvbid0IGhhdmUgdG8gYnV0IGlmIHlvdSd2ZSByZXZpZXdlZCBwYXRjaGVzIHRoYXQgaGF2
ZW4ndCB5ZXQgYmVlbgo+IGFwcGxpZWQgaXQncyBhbHdheXMgaGVscGZ1bCB0byBzYXkgc28uCk9r
LCBpbiB0aGlzIGNhc2UsIEkgcmV2aWV3ZWQgaXQgYW5kIHRlc3RlZCA6KQoKQWNrZWQtb2ZmLWJ5
OiBMZW9uIFJvbWFub3Zza3kgPGxlb25AbGVvbi5udT4KCgotLSAKTGVvbiBSb21hbm92c2t5IHwg
SW5kZXBlbmRlbnQgTGludXggQ29uc3VsdGFudArCoCDCoCDCoCDCoMKgd3d3Lmxlb24ubnXCoHwg
bGVvbkBsZW9uLm51Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
