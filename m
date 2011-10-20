From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: ak4671: Use snd_soc_update_bits for
	read-modify-write
Date: Thu, 20 Oct 2011 10:47:53 +0100
Message-ID: <CABS+qY3XFUgc3ZVGJdCtLoM_6a6Y3Z6NkqdXj+Rv45DNCYe8qQ@mail.gmail.com>
References: <1319079253.5380.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 938C524719
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 11:47:55 +0200 (CEST)
Received: by mail-yx0-f180.google.com with SMTP id 34so3731241yxm.11
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2011 02:47:54 -0700 (PDT)
In-Reply-To: <1319079253.5380.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAgT2N0b2JlciAyMDExIDAzOjU0LCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBVc2Ugc25kX3NvY191cGRhdGVfYml0cyBmb3IgcmVhZC1tb2RpZnktd3JpdGUgcmVn
aXN0ZXIgYWNjZXNzIGluc3RlYWQgb2YKPiBvcGVuLWNvZGluZyBpdCB1c2luZyBzbmRfc29jX3Jl
YWQgYW5kIHNuZF9zb2Nfd3JpdGUKPgo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxp
bkBnbWFpbC5jb20+Cj4gLS0tCj4gwqBzb3VuZC9zb2MvY29kZWNzL2FrNDY3MS5jIHwgwqAgMTgg
KysrKysrLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pCj4KCkFja2VkLWJ5OiBMaWFtIEdpcmR3b29kIDxscmdAdGkuY29tPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
