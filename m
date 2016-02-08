From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: rt5514: Fix up calculation for
	bclk_ms
Date: Mon, 08 Feb 2016 23:15:31 +0800
Message-ID: <1454944531.5682.0.camel@ingics.com>
References: <1454940293.6265.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9F02605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 16:15:40 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id ho8so74991446pac.2
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2016 07:15:40 -0800 (PST)
In-Reply-To: <1454940293.6265.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

5pa8IOS4gO+8jDIwMTYtMDItMDgg5pa8IDIyOjA0ICswODAw77yMQXhlbCBMaW4g5o+Q5Yiw77ya
Cj4gVGhlIGVxdWF0aW9uIHRvIGNhbGN1bGF0ZSBiY2xrX21zIGlzIHdyb25nLCBmaXggaXQuCgpP
b3BzLCBJIG1pcy11bmRlcnN0YW5kIHRoZSBjb2RlLgpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gs
IHNvcnJ5LgoKQXhlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
