From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH] ARM ASoC: add sound driver for
	imx27pdk using mc13783 codec
Date: Sat, 28 Jan 2012 18:57:45 -0200
Message-ID: <CAOMZO5CRmvwCy_qE81PauZ6jmPN7S3N3pky01V0OmWBLCJ5JyA@mail.gmail.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<4E1711EA.5070209@televic.com>
	<201107271028.09928.philippe.retornaz@epfl.ch>
	<2667396.yifGumf5nD@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 535AC2475A
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2012 21:57:46 +0100 (CET)
Received: by eekd49 with SMTP id d49so880854eek.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2012 12:57:45 -0800 (PST)
In-Reply-To: <2667396.yifGumf5nD@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Philippe_R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Cc: =?UTF-8?Q?Lambrecht_J=C3=BCrgen?= <J.Lambrecht@televic.com>, =?UTF-8?Q?J=C3=BCrgen_Lambrecht?= <juergen.lambrecht@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

SGkgUGhpbGlwcGUsCgpPbiBXZWQsIEphbiAyNSwgMjAxMiBhdCAxOjQ1IFBNLCBQaGlsaXBwZSBS
w6l0b3JuYXoKPHBoaWxpcHBlLnJldG9ybmF6QGVwZmwuY2g+IHdyb3RlOgoKPiBJIGhhdmUgYSB3
b3JraW5nIHNvdW5kIHN1cHBvcnQgZm9yIHRoZSBteDMxbW9ib2FyZCBib2FyZHMgYXZhaWxhYmxl
IGhlcmU6Cj4gaHR0cDovL2dpdGh1Yi5jb20vcmV0b3JuYXovbGludXgvY29tbWl0cy9tb2JvYXJk
LXNvdW5kCgpUaGF0J3MgY29vbCA6LSkKCj4gSXQncyBiYXNpY2FsbHkgU2FzY2hhIG1jMTM3ODMg
Y29kZWMgZHJpdmVyIChmcm9tIGhpcyBnaXQgdHJlZSkgcmViYXNlZCBvbiAzLjIKPiBhbmQgc29t
ZSBteDMxbW9ib2FkIHNwZWNpZmljIGNvZGUuCj4KPiBJIGNhbiBwbGF5YmFjayAmIHJlY29yZCBz
b3VuZCBvbiBvdXIgYm9hcmQgKDIgY2hhbm5lbHNAMTZLaHopIHdpdGggdGhlIHNkbWEuCj4KPiBT
YXNjaGEsIGRvIHlvdSBoYXZlIGFueSBwbGFuIHRvIHVwc3RyZWFtIHRoZSBtYzEzNzgzIGNvZGVj
IGRyaXZlciA/CgpJbiBjYXNlIFNhc2NoYSBkb2Vzbid0IGhhdmUgcGxhbnMgdG8gdXBzdHJlYW0g
bWMxMzc4MywgaXMgdGhpcwpzb21ldGhpbmcgeW91IGNvdWxkIGRvPwoKVGhhbmtzLAoKRmFiaW8g
RXN0ZXZhbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
