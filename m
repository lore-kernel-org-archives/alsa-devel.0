From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Wed, 3 Jun 2009 08:37:54 -0400
Message-ID: <8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D9879243AF
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:37:55 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so5809812ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:37:54 -0700 (PDT)
In-Reply-To: <20090603105223.GE11507@sirena.org.uk>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdW4gMywgMjAwOSBhdCAwNjo1MiwgTWFyayBCcm93biB3cm90ZToKPiBIb3dldmVy
LCBnaXZlbiB0aGF0IHRoaXMgZml4IGhhcyBtaXNzZWQgdHdvIGtlcm5lbCByZWxlYXNlcyBkdWUg
dG8gdGhlCj4gdmVyeSBzbG93IHJhdGUgb2YgcmVzcG9uc2VzIHRvIHJldmlldyBjb21tZW50cyBJ
J3ZlIGFwcGxpZWQgaXQgc28gdXNlcnMKPiBnZXQgdGhlIGJlbmVmaXQgb2YgdGhlIGJ1ZyBmaXgu
Cgpub3Qgc3VyZSB3aGF0IHlvdSdyZSByZWZlcnJpbmcgdG8KCj7CoFRoaW5ncyB3b3VsZCBnbyBt
b3JlIHNtb290aGx5IGlmIHlvdQo+IGNvdWxkIGdldCBuZXcgdmVyc2lvbnMgb2YgcGF0Y2hlcyBz
dWJtaXR0ZWQgZmFzdGVyIGFmdGVyIHRoZSBvcmlnaW5hbAo+IHJldmlldy4KCnRoZSBwcmV2aW91
cyBCbGFja2ZpbiBrZXJuZWwgbWFpbnRhaW5lciBjaGFuZ2VkIGpvYnMgc28gd2UndmUgYmVlbgp0
cmFuc2l0aW9uaW5nLiAgcmVhbGl0eSBpcywgdGhpcyBkb2VzbnQgaGFwcGVuIG92ZXIgbml0ZS4K
LW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
