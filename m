From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: SAMSUNG: Fix initial return value
Date: Sat, 4 Dec 2010 09:07:40 +0900
Message-ID: <AANLkTikJXhtxEE6H38bjyVw8buhOsZRujGjpvOaBcXpK@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<20101203164225.GY859@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B2AC7103B8A
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 01:07:40 +0100 (CET)
Received: by wyi11 with SMTP id 11so10064835wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 16:07:40 -0800 (PST)
In-Reply-To: <20101203164225.GY859@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBEZWMgNCwgMjAxMCBhdCAxOjQyIEFNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBEZWMgMDMsIDIwMTAgYXQg
MDY6Mjc6MzNQTSArMDkwMCwgU2V1bmd3aGFuIFlvdW4gd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggZml4
ZWQgaW50aWFsIHJldHVybiB2YWx1ZSB0byBiZSBhICcwJyBhcyBhc3VjY2VzcyBvbgo+PiBzZXRf
YXVkaW9fY2xvY2tfaGVpcmFjaHkoKS4gVGhpcyBhdm9pZHMgdW5pbnRlbmRlZCBlcnJvciBvbiBp
bml0aWFsaXplLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTZXVuZ3doYW4gWW91biA8c3cueW91bkBz
YW1zdW5nLmNvbT4KPj4gLS0tCj4+IMKgc291bmQvc29jL3MzYzI0eHgvc21ka19zcGRpZi5jIHwg
wqAgwqAyICstCj4KPiBDb3VsZCB5b3UgcmVnZW5lcmF0ZSBhZ2FpbnN0IGN1cnJlbnQgZm9yLTIu
Ni4zOCBwbGVhc2U/IMKgVGhlIG1vdmUgdG8gdGhlCj4gU2Ftc3VuZyBkaXJlY3RvcnkgbWVhbnMg
dGhpcyB3b24ndCBhcHBseSBhbnkgbW9yZS4KCk9mIGNvdXJzZSwgSSBkby4gOi0pCgpUaGFua3Mu
CkNsYXVkZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
