From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] ASoC:
	AD1980/AD73311: make sure to set dev member
Date: Tue, 6 Oct 2009 05:59:11 -0400
Message-ID: <8bd0f97a0910060259y44e4528bld9c902b236141b1b@mail.gmail.com>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<20091006094232.GA27168@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199])
	by alsa0.perex.cz (Postfix) with ESMTP id ABBCD103921
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 11:59:31 +0200 (CEST)
Received: by ywh37 with SMTP id 37so3593901ywh.17
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 02:59:31 -0700 (PDT)
In-Reply-To: <20091006094232.GA27168@sirena.org.uk>
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

T24gVHVlLCBPY3QgNiwgMjAwOSBhdCAwNTo0MiwgTWFyayBCcm93biB3cm90ZToKPiBPbiBUdWUs
IE9jdCAwNiwgMjAwOSBhdCAwMTo1MTo1MEFNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gVGhlIGNvZGVjIGRyaXZlciBzaG91bGQgaW5pdGlhbGl6ZSBzbmRfc29jX2NvZGVjJ3MgZGV2
IG1lbWJlciB0byB0aGUKPj4gYXBwcm9wcmlhdGUgZGV2aWNlIHdoZW4gc2V0dGluZyB1cCB0aGUg
ZGV2aWNlLCBidXQgdGhlc2UgY29kZWNzIHdlcmVuJ3QuCj4KPiBObywgdGhpcyBpcyB0aGUgd3Jv
bmcgYXBwcm9hY2ggLSBjb2RlYy0+ZGV2IHNob3VsZCBuZXZlciBiZSBiZWluZyBzZXQgdG8KPiB0
aGUgc29jZGV2IGRldmljZSwgaXQgc2hvdWxkIGJlIGJlaW5nIHNldCB0byB0aGUgZGV2aWNlIG1v
ZGVsIGRldmljZSBmb3IKPiB0aGUgQ09ERUMgKGFzIHNob3VsZCB0aGUgZGV2IG1lbWJlcnMgZm9y
IHRoZSBEQUlzKS4gwqBGb3IgYWQ3MzMxMSB0aGlzCj4gbWVhbnMgaXQgbmVlZHMgdG8gYmUgY29u
dmVydGVkIHRvIHVzZSBwcm9wZXIgZGV2aWNlIG1vZGVsIGluc3RhbnRpYXRpb24sCj4gc2VlIHdt
ODczMSBmb3IgYW4gZXhhbXBsZSBvZiBkb2luZyB0aGlzLiDCoGFkMTk4MCBzaG91bGQgYmUgaGFu
ZGxlZCBieQo+IGdlbmVyaWMgQUM5NyBjb2RlIGluIHRoZSBjb3JlLgoKbWVoLCB0aGlzIHNvdW5k
cyBsaWtlIGVmZm9ydC4gIGknbGwgdHJpY2sgQ2xpZmYvQmFycnkgaW50byBkb2luZyBpdCA7KS4K
LW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
