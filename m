From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Fix unbalanced regulator
 disables
Date: Wed, 3 Nov 2010 16:29:14 +0200
Message-ID: <20101103162914.fc5c33fa.jhnikula@gmail.com>
References: <1288263940-4602-1-git-send-email-jhnikula@gmail.com>
	<s5hpqumqzgz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4D5243DC
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 15:29:02 +0100 (CET)
Received: by eyg24 with SMTP id 24so262961eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 07:29:02 -0700 (PDT)
In-Reply-To: <s5hpqumqzgz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwMyBOb3YgMjAxMCAxNTowMDoxMiArMDEwMApUYWthc2hpIEl3YWkgPHRpd2FpQHN1
c2UuZGU+IHdyb3RlOgoKPiBUaGlzIHNlZW1zIHRyaWdnZXJpbmcgYSBjb21waWxlIHdhcm5pbmc6
Cj4gCj4gICBzb3VuZC9zb2MvY29kZWNzL3RwYTYxMzBhMi5jOjEyMjo2OiB3YXJuaW5nOiDigJhy
ZXTigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uCj4gCk15IHNo
YW1lLiBJIHNlbmQgYSBwYXRjaCBpbiBhIG1pbnV0ZS4KCgotLSAKSmFya2tvCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
