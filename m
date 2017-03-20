From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 3/5] ASoC: sun8i-codec: Fix space on
	audio-routing widget
Date: Mon, 20 Mar 2017 19:47:23 +0800
Message-ID: <CAGb2v65f2jGog41HAV3p2i9PTZkzFbifqCzX+SXZ1jaOTN4V4A@mail.gmail.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-4-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 627F2266DD6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:47:47 +0100 (CET)
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
 [209.85.214.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id C4B4F226CA
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 19:47:45 +0800 (CST)
Received: by mail-it0-f45.google.com with SMTP id w124so85389559itb.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 04:47:45 -0700 (PDT)
In-Reply-To: <20170318075509.3836-4-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBNYXIgMTgsIDIwMTcgYXQgMzo1NSBQTSwgTXlsw6huZSBKb3NzZXJhbmQKPG15bGVu
ZS5qb3NzZXJhbmRAZnJlZS1lbGVjdHJvbnMuY29tPiB3cm90ZToKPiBBbiB1bndhbnRlZCBzcGFj
ZSBpcyBwcmVzZW50IGluIGFuIGF1ZGlvIHdpZGdldCdzIG5hbWUgb24gdGhlIGRhcG0KPiByb3V0
aW5nLiBJdCBjYXVzZXMgYW4gZXJyb3Igb24gdGhlIHJlY29nbml0aW9uIG9mIHRoaXMgd2lkZ2V0
IChlcnJvcjoKPiAoIm5vIGRhcG0gbWF0Y2ggZm9yIEFJRjEgU2xvdCAwIFJpZ2h0IikuCj4KPiBS
ZW1vdmUgdGhlIHNwYWNlIGZpeGVzIGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTXlsw6huZSBKb3Nz
ZXJhbmQgPG15bGVuZS5qb3NzZXJhbmRAZnJlZS1lbGVjdHJvbnMuY29tPgoKQXMgbWVudGlvbmVk
LCB0aGlzIHBhdGNoIGNhbiBiZSBzcXVhc2hlZCBpbnRvIHRoZSBwcmV2aW91cyBwYXRjaCwgbm93
CnRoYXQgeW91J3JlIHJlc2VuZGluZyB0aGUgd2hvbGUgYnVuY2ggb2YgcGF0Y2hlcy4KCk90aGVy
d2lzZSwKCkFja2VkLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
