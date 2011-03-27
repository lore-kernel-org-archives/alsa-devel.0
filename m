From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH 1/2] ASoC: SSM2602:
 drop rate and sample bits constraints
Date: Sun, 27 Mar 2011 00:07:56 -0400
Message-ID: <AANLkTinEubA65WO8ax9UcVtqJRDtYL7Kud39a7xBo8yV@mail.gmail.com>
References: <1301124539-527-1-git-send-email-vapier@gentoo.org>
	<20110326124409.GF28537@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E31301037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 06:08:16 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1444760fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 21:08:16 -0700 (PDT)
In-Reply-To: <20110326124409.GF28537@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBNYXIgMjYsIDIwMTEgYXQgMDg6NDQsIE1hcmsgQnJvd24gd3JvdGU6Cj4gSSBzdXNw
ZWN0IHRoaXMgY2hhbmdlIGlzIGluY29tcGxldGUgYW5kIHNob3VsZCBhbHNvIGJlIHNldHRpbmcg
dGhlCj4gc3ltbWV0cmljX3JhdGVzIGZsYWcgaW4gdGhlIGRyaXZlciB3aGljaCBkb2VzIHRoZSBl
cXVpdmFsZW50IHRoaW5nIGluCj4gdGhlIGNvcmUgYXMgdGhpcyBjb2RlIGlzIGRvaW5nLiDCoExv
b2tpbmcgYXQgdGhlIGNvZGUgc29tZSBzeW1tZXRyeQo+IGhhbmRsaW5nIGlzIHJlcXVpcmVkIGFz
IHRoZSBkcml2ZXIgaXMgc2V0dGluZyB0aGUgc2FtZSByZWdpc3RlcnMgZm9yCj4gcGxheWJhY2sg
YW5kIGNhcHR1cmUgcmF0ZXMgc28gc2ltdWx0YW5lb3VzIHBsYXliYWNrIGFuZCByZWNvcmQgd2l0
aAo+IGRpZmZlcmVudCByYXRlcyBpcyBub3Qgc3VwcG9ydGVkPwo+Cj4gQ29udmVydGluZyB0byBz
eW1tZXRyaWNfcmF0ZXMgd291bGQgZGVmaW5pdGVseSBiZSBhIGdvb2QgdGhpbmcuCgppIGltYWdp
bmUgeW91J3JlIHJpZ2h0IG9uIGFsbCB0aGVzZSBwb2ludHMuICB0aGlzIGNoYW5nZSB3YXMgbmVj
ZXNzYXJ5CmFzIGl0J3MgZWFzeSB0byBzZWUgZXJyb3JzIGluIHNhbXBsZSByYXRlIGNvbnZlcnNp
b24gb3IgZXZlbiBoYW5ncy4KaG9wZWZ1bGx5IENsaWZmIGNhbiBmaW5kIHNvbWUgdGltZSBmb3Ig
dGhpcyBhcyB0aGUgd29yZHMgeW91IHVzZSBnbwpyaWdodCBvdmVyIG15IGhlYWQgOykuCi1taWtl
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
