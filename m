From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 00/10] Convert wm8xxx codec drivers to use
 snd_soc_cache_sync
Date: Thu, 06 Oct 2011 15:10:16 +0800
Message-ID: <1317885016.13399.21.camel@phoenix>
References: <1317881417.13399.1.camel@phoenix>
	<1317883960.13399.17.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DCF7C103A95
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 09:10:24 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so1660909ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 00:10:24 -0700 (PDT)
In-Reply-To: <1317883960.13399.17.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lartey <ian@opensource.wolfsonmicro.com>, Kenneth Kiraly <kiraly@lab126.com>, Richard Purdie <rpurdie@rpsys.net>, Jonathan Cameron <jic23@cam.ac.uk>, Mike Arthur <linux@wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

5pa8IOWbm++8jDIwMTEtMTAtMDYg5pa8IDE0OjUyICswODAw77yMQXhlbCBMaW4g5o+Q5Yiw77ya
Cj4gU29ycnkuIEkganVzdCBmb3VuZCB3ZSBuZWVkIHRvIHNldCBjb2RlYy0+Y2FjaGVfc3luYyA9
IDEgaW4KPiBTTkRfU09DX0JJQVNfT0ZGLiBPdGhlcndpc2UsIHNuZF9zb2NfY2FjaGVfc3luYyB3
b24ndCBzeW5jIHdvcmsuCj4gCj4gV2lsbCBzZW5kIGEgdjIgc29vbi4KCkkgdGFrZSBpdCBiYWNr
LiBzb3JyeSBhZ2Fpbi4KQWZ0ZXIgY29tbWl0IDdiZTRiYTI0ICJBU29DOiBNYXJrIGNhY2hlIGFz
IGRpcnR5IHdoZW4gc3VzcGVuZGluZyIsClRoZSBzb2MtY29yZSB3aWxsIHNldCBjb2RlYy0+Y2Fj
aGVfc3luYyBmbGFnIG5vdy4KClJlZ2FyZHMsCkF4ZWwKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
