From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
	define the relationship between audio channel and tdm slot
Date: Thu, 20 Aug 2009 10:37:25 +0800
Message-ID: <3c17e3570908191937h53f5bcf0mb9c753b94402e3f5@mail.gmail.com>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
	<3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
	<20090818131117.GA12512@rakim.wolfsonmicro.main>
	<3c17e3570908181834q6dd0e0c5n157697bd02836b35@mail.gmail.com>
	<20090819113400.GC18285@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4162440A
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 04:37:47 +0200 (CEST)
Received: by yxe6 with SMTP id 6so5919031yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 19:37:45 -0700 (PDT)
In-Reply-To: <20090819113400.GC18285@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBdWcgMTksIDIwMDkgYXQgNzozNCBQTSwgTWFyawpCcm93bjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBBdWcgMTksIDIwMDkgYXQg
MDk6MzQ6MTZBTSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToKPgo+PiBUaGUgdGltaW5nIGlzIGxp
a2UgdGhlIGF0dGFjaGVkIGRpYWdyYW0sIEkgdGhpbmsgaXQncyBub3QgSTJTIGJ1dCBsaWtlIERT
UC4KPgo+IFl1cCwgdGhhdCBEU1AgbW9kZSB3aXRoIEkyUyBsaWtlIGNoYW5uZWwgbGF5b3V0IChk
b2VzIGl0IGFsc28gZG8gVERNIGluCj4gSTJTIG1vZGUgYnkgYW55IGNoYW5jZT8pLiDCoENvdWxk
IHlvdSBzdWJtaXQgYSB2ZXJzaW9uIG9mIHlvdXIgcGF0Y2gKPiB3aGljaCB1c2VzIHRoZSBkZWZh
dWx0IFRETSBsYXlvdXQgLSBhbiBBUEkgdG8gcmV3cml0ZSB0aGluZ3MgaXMgbGlrZWx5Cj4gdG8g
YmUgYSBzZXBhcmF0ZSBBUEk/Cj4KSSBkb24ndCBrbm93IHdoYXQgaXMgeW91ciBleGFjdCBtZWFu
aW5nLiAgRG8geW91IG1lYW4gSSBzZW5kIGEgcGF0Y2gKd2hvc2UgdGRtIHNsb3QgaXMgbm90IGNo
YW5nZWQsIHRoZW4gc2VuZCBhIHBhdGNoIHdoaWNoIGNoYW5nZSB0aGUgdGRtCnNsb3Q/Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
