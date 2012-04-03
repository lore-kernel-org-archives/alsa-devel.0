From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix warning due to the
	lack of REGULATOR_CHANGE_VOLTAGE
Date: Tue, 3 Apr 2012 17:43:20 -0300
Message-ID: <CAOMZO5AaqN8aXPwQQbQDopRsx3ndra8SQNkvmxH08HTyiKCORQ@mail.gmail.com>
References: <1333483353-12273-1-git-send-email-festevam@gmail.com>
	<20120403203746.GB11910@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B15C7104334
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 22:43:21 +0200 (CEST)
Received: by eaak11 with SMTP id k11so29514eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2012 13:43:21 -0700 (PDT)
In-Reply-To: <20120403203746.GB11910@opensource.wolfsonmicro.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBcHIgMywgMjAxMiBhdCA1OjM3IFBNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMDMsIDIwMTIgYXQg
MDU6MDI6MzNQTSAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToKPj4gRml4IHRoZSBmb2xsb3dp
bmcgd2FybmluZyBkdXJpbmcga2VybmVsIGJvb3Q6Cj4+Cj4+IDAtMDAwYTogODUwIDwtLT4gMTYw
MCBtViBhdCAxMjAwIG1WIG5vcm1hbAo+PiAwLTAwMGE6IFZvbHRhZ2UgcmFuZ2UgYnV0IG5vIFJF
R1VMQVRPUl9DSEFOR0VfVk9MVEFHRQo+Cj4gQXJlIHlvdSBzdXJlIHRoaXMgaXMgdGhlIGJlc3Qg
Zml4PyDCoFRoZXJlJ3Mgbm8gc2V0X3ZvbHRhZ2UoKSBjYWxsIGluIHRoZQo+IGRyaXZlci4KClNv
cnJ5LCBJIHdhcyBub3QgYWJsZSB0byB1bmRlcnN0YW5kIHlvdXIgbGFzdCBjb21tZW50LgoKSG93
IGRvIHlvdSBzdWdnZXN0IG1lIHRvIGZpeCB0aGlzLCBwbGVhc2U/Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
