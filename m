From: =?UTF-8?Q?Vedran_Mileti=C4=87?= <rivanvx@gmail.com>
Subject: Re: How can PCI resource allocation fail?
Date: Fri, 13 Mar 2009 11:24:16 +0100
Message-ID: <fd3eb9bf0903130324o59d5c4a0k47e584bdf2448a02@mail.gmail.com>
References: <49B9959F.1080705@digadd.de> <49BA0EDA.4080606@ladisch.de>
	<s5h1vt1vnio.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f174.google.com (mail-bw0-f174.google.com
	[209.85.218.174])
	by alsa0.perex.cz (Postfix) with ESMTP id EE7F21037EC
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 11:24:17 +0100 (CET)
Received: by bwz22 with SMTP id 22so2382347bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 03:24:17 -0700 (PDT)
In-Reply-To: <s5h1vt1vnio.wl%tiwai@suse.de>
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
Cc: "Christian P. Schmidt" <schmidt@digadd.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXIgMTMsIDIwMDkgYXQgOToyNCBBTSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPiB3cm90ZToKPiBBdCBGcmksIDEzIE1hciAyMDA5IDA4OjQ0OjI2ICswMTAwLAo+IENsZW1l
bnMgTGFkaXNjaCB3cm90ZToKPj4KPj4gQ2hyaXN0aWFuIFAuIFNjaG1pZHQgd3JvdGU6Cj4+ID4g
SSdtIHRveWluZyB3aXRoIHRoZSBhbHNhLWRyaXZlciBmb3IgdGhlIENyZWF0aXZlIExhYnMgWC1G
aS4gSSdtIHdvcmtpbmcKPj4gPiBvbiB0aGUgUENJIEV4cHJlc3MgdmVyc2lvbiBvZiB0aGlzIGNh
cmQsCj4+Cj4+IC4uLiB3aGljaCBpc24ndCBzdXBwb3J0ZWQgLi4uCj4KPiBZb3UgY2FuIHRyeSBz
b3VuZC11bnN0YWJsZSB0cmVlLiDCoElmIHlvdXIgZGV2aWNlIGlzIGEgVmlzdGEtY29tcGF0aWJs
ZQo+IG1vZGVsLCBpdCBtYXkgd29yayB3aXRoIHNuZC1oZGEtaW50ZWwgKHdpdGggYSBsdWNrKS4K
Pgo+IMKgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXdh
aS9zb3VuZC11bnN0YWJsZS0yLjYuZ2l0Cj4KPiBUaGUgY29ycmVzcG9uZGluZyBhbHNhLWRyaXZl
ciBzbmFwc2hvdCBpczoKPiDCoCBmdHA6Ly9mdHAua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVs
L3Blb3BsZS90aXdhaS9zbmFwc2hvdC9hbHNhLWRyaXZlci11bnN0YWJsZS1zbmFwc2hvdC50YXIu
Z3oKPgo+IElmIGl0J3Mgbm8gVmlzdGEtY29tcGF0aWJsZSAoaS5lLiBIRC1hdWRpbyBjb21wYXRp
YmxlKSBtb2RlbCwgeW91IGNhbgo+IHRyeSB0b3BpYy9zYnhmaSBicmFuY2ggb2YgdGhlIHNvdW5k
IHVuc3RhYmxlIHRyZWUgYWJvdmUuIMKgSnVzdAo+IHB1bGwvbWVyZ2UgdGhlIGJyYW5jaCBhZnRl
ciBjbG9uaW5nLgo+Cj4KPiBUYWthc2hpCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+IEFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCj4KCklJUkMsIGFsbCBQQ0ktRSBYLUZpIGNhcmRzIGFyZSBV
QUEgKHRoaXMgcGFydCBJJ20gcHJldHR5IGNlcnRhaW4KYWJvdXQpLCBhbmQgYWxsIFVBQSBYLUZp
IGNhcmRzIGFyZSBQQ0ktRSAoSSBzYXcgYXQgc29tZSBwb2ludCBzb21lIE9FTQpYLUZpIGNhcmQg
dGhhdCBoYWQgdHdvIGNoaXBzLCBvbmUgb24gdGhlIGZyb250IGFuZCBvdGhlciBvbiB0aGUgcmVh
ciwKc28gbm90IHRvdGFsbHkgc3VyZSBhYm91dCB0aGlzIG9uZSkuCgpWZWRyYW4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
