From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Tue, 20 Dec 2011 13:07:02 +0200
Message-ID: <CALq1K=K4CHboFvexqRJdhWkvB+0MPCns+s7Y5873TEnXenSDBQ@mail.gmail.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<20111220004219.GG2860@opensource.wolfsonmicro.com>
	<E1RcwuM-0004M5-00.danindrey-mail-ru@f232.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D4A7A103AF2
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 12:07:23 +0100 (CET)
Received: by vbbfp1 with SMTP id fp1so4972548vbb.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 03:07:23 -0800 (PST)
In-Reply-To: <E1RcwuM-0004M5-00.danindrey-mail-ru@f232.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrey Danin <danindrey@mail.ru>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBEZWMgMjAsIDIwMTEgYXQgMTI6MjYsIEFuZHJleSBEYW5pbiA8ZGFuaW5kcmV5QG1h
aWwucnU+IHdyb3RlOgo+Cj4gMjAg0LTQtdC60LDQsdGA0Y8gMjAxMSwgMDQ6NDIg0L7RgiBNYXJr
IEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT46Cj4+IE9uIE1vbiwg
RGVjIDE5LCAyMDExIGF0IDA5OjUxOjUyUE0gKzAyMDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToK
Pj4gPiBBdCB0aGlzIHN0YWdlIG9ubHkgVG9zaGliYSBBQzEwMC9EeW5hYm9vayBzdXBwb3J0ZWQu
Cj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25AbGVvbi5udT4K
Pj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgRGFuaW4gPGRhbmluZHJleUBtYWlsLnJ1Pgo+Pgo+
PiBBcHBsaWVkLCB0aGFua3MuCj4KPiBUaGVyZSBpcyBhIGxpdHRsZSB0eXBvIC0gbXVzdCBiZSBh
bGM1NjMyIGluc3RlYWQgb2YgYWxjNTMzMgpNYXJrLCB3aGF0IGlzIHRoZSB3YXkgdG8gZml4IHRo
aXMgdHlwZSBvZiB0eXBvPwoKCgo+Pgo+PiA+IC0tCj4+ID4gQ2hhbmdlcyBzaW5jZSB2MjoKPj4K
Pj4gUGxlYXNlIGZvbGxvdyB0aGUgZm9ybWF0IGluIFN1Ym1pdHRpbmdQYXRjaGVzIC0gdGhlIGFi
b3ZlIG5lZWRzIHRvIGJlCj4+IC0tLSBub3QgLS0uCj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IEFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0Cj4+IEFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+PiBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo+PgoKCgotLSAKTGVvbiBSb21hbm92c2t5
IHwgSW5kZXBlbmRlbnQgTGludXggQ29uc3VsdGFudArCoCDCoCDCoCDCoMKgd3d3Lmxlb24ubnXC
oHwgbGVvbkBsZW9uLm51Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
