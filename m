From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: S3C64XX: Fix to support BCLK,
	LRCLK rates 	setting
Date: Sat, 7 Aug 2010 01:26:21 +0900
Message-ID: <AANLkTimKjBgqNMkhYhSHQuJQWaBMjuRr6WbLpCPmCRc0@mail.gmail.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054999-18243-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim2g4=j0TdYZb7QCbyZVJvhxMsCFa4yFokJCu1W@mail.gmail.com>
	<AANLkTikQ2Mb=7mKghxJep-h4m2Myi3kF1ugKQHrjf1_y@mail.gmail.com>
	<20100806111750.GE398@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C0B11037F9
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 18:26:22 +0200 (CEST)
Received: by wwb17 with SMTP id 17so4999655wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 09:26:21 -0700 (PDT)
In-Reply-To: <20100806111750.GE398@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgNiwgMjAxMCBhdCA4OjE3IFBNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBBdWcgMDYsIDIwMTAgYXQg
MDM6MDI6NDlQTSArMDkwMCwgU2V1bmd3aGFuIFlvdW4gd3JvdGU6Cj4KPj4gSSBzZWUsIGlmIE1h
cmsncyBvcGluaW9uIGlzIHNhbWUgYXMgYmVmb3JlLCBJIHRoaW5rIEkgY2FuIHRyeSB0byBtYWtl
Cj4+IGFub3RoZXIgcGF0Y2ggZm9yIGl0LiA6KQo+Cj4gSSB3aWxsIGxvb2sgYXQgdGhpcyBteXNl
bGYsIHRoZSBtYWpvciBibG9ja2VyIG9uIGRvaW5nIHNvIGhhZCBiZWVuIHRoYXQKPiBmb3IgbWFu
eSBrZXJuZWwgcmVsZWFzZXMgaXQgd2FzIG5vdCBwb3NzaWJsZSB0byB1c2UgdGhlIElJU3Y0IGlu
dGVyZmFjZQo+IHNpbmNlIHRoZSBzdXBwb3J0IGZvciB0aGUgSUlTdjQgbWFpbiBjbG9jayBkaWRu
J3QgZ2V0IG1lcmdlZCBzbyBldmVyeQo+IHRpbWUgSSBzcGVudCBhbnkgdGltZSBvbiB0aGlzIGl0
IHdhcyBhbGwgY29uc3VtZWQgaW1wbGVtZW50aW5nIHRoYXQgYW5kCj4gcmVzdWJtaXR0aW5nIGNo
YW5nZXMgZm9yIHRoYXQuIMKgVGhhdCBhcHBlYXJzIHRvIGJlIHNvcnRlZCBpbiBhdCBsZWFzdAo+
IDIuNi4zNCBzbyBJIGNhbiBub3cgcnVuIHRlc3RzIG11Y2ggbW9yZSBlYXNpbHkuCj4KCk9rYXks
IFRoYW5rcy4KCkNsYXVkZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
