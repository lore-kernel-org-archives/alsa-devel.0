From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Mon, 28 Feb 2011 11:34:39 -0800
Message-ID: <4D6BF8CF.40600@localhost>
References: <4D69A0FC.60400@localhost>	<20110227111708.GK15327@ltw.loris.tv>	<4D6AA448.7050401@localhost>	<4D6AE436.6000201@localhost>	<4D6BCB59.30709@drcomp.erfurt.thur.de>
	<AANLkTikr=sBcis_2V=qm9jgWha3P6QR2-xiY9WpXw+vH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp1.Stanford.EDU [171.67.219.81])
	by alsa0.perex.cz (Postfix) with ESMTP id B3BFA103800
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 20:34:46 +0100 (CET)
In-Reply-To: <AANLkTikr=sBcis_2V=qm9jgWha3P6QR2-xiY9WpXw+vH@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Craig Bourne <craigbourne@gmail.com>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDIvMjgvMjAxMSAwOToyMyBBTSwgQ3JhaWcgQm91cm5lIHdyb3RlOgo+IEkgZXhwZWN0IHRo
YXQgSSBtYXkgaGF2ZSB0aW1lIFdlZG5lc2RheSBvZiB0aGlzIHdlZWsgdG8gaGVscCB3aXRoIHRo
ZSAKPiB0ZXN0aW5nLCBldGMuCgooSSByZWxlYXNlZCBhIG5ldyBwYWNrYWdlIG9mIGFsc2EtdG9v
bHMgaW4gdGhlIHBsYW5ldGNjcm1hLXRlc3RpbmcgCnJlcG9zaXRvcnkgc28geW91IGNhbiB0ZXN0
IC0geW91IGhhdmUgdG8gaW5zdGFsbCAKcGxhbmV0Y2NybWEtcmVwby10ZXN0aW5nIGFuZCB0aGVu
IHl1bSAtLWVuYWJsZXJlcG8gcGxhbmV0Y2NybWEtdGVzdGluZyAKaW5zdGFsbCBhbHNhLXRvb2xz
IHRvIGdldCBpdCkuCgotLSBGZXJuYW5kbwoKCj4KPiBUaG91Z2ggbG93IGxldmVsIHRlY2huaWNh
bCBkZXRhaWxzIGFyZSBtb3N0bHkgYWJzZW50IGZyb20gdGhlIAo+IGRvY3VtZW50YXRpb24gdGhh
dCBSTUUgcHJvdmlkZWQsIEkgd2lsbCB0cnkgdG8gbG9jYXRlIGFuZCBmb3J3YXJkIGEgCj4gY29w
eSBvZiB0aGVpciB0ZWNobmljYWwgbWFudWFsIGp1c3QgaW4gdGhlIGV2ZW50IHRoYXQgdGhhdCBt
aWdodCBiZSBvZiAKPiBzb21lIGhlbHAuIFtBaCEgSGVyZSBpdCBpcyEgCj4gPGh0dHA6Ly9tZWRp
YS56em91bmRzLmNvbS9tZWRpYS9oZHNwOTY1Ml9lLTJjMWJiYTc5NTMyZGI4Y2QxYzliNmYwYmVi
MzFlODU1LnBkZj5dCj4KPiBNZWFud2hpbGUsIHBsZWFzZSBoYXZlIGEgbG9vayBhdCAvUk1FOTY1
Mi5jb25mLyB3aGljaCByZWFkcywgaW4gcGFydCAKPiAoc3RhcnRpbmcgZnJvbSBhYm91dCBsaW5l
IDM4KToKPgo+IC4uLgo+Cj4gIHNsYXZlLnBjbSB7Cj4gICAgICAgdHlwZSByb3V0ZQo+ICAgICAg
IHNsYXZlIHsKPiAgICAgICAgICBwY20gewo+ICAgICAgICAgICAgIHR5cGUgaHcKPiAgICAgICAg
ICAgICBjYXJkICRDQVJECj4gICAgICAgICAgfQo+IGNoYW5uZWxzIDI2Cj4gICAgICAgfQo+ICAg
ICAgIHR0YWJsZS4wLjI0IDEKPiAgICAgICB0dGFibGUuMS4yNSAxCj4gICAgfQo+IC4uLgo+Cj4g
VGhpcyBudW1iZXIgYWxzbyByZWZsZWN0cyBSTUUncyBjaGFyYWN0ZXJpemF0aW9uIG9mIHRoZSBj
YXJkIChmcm9tIHRoZSAKPiB0aXRsZSBwYWdlIG9mIHRoZWlyIG1hbnVhbCkKPgo+IFBDSSBCdXNt
YXN0ZXIgRGlnaXRhbCBJL08gU3lzdGVtCj4gMiArIDI0IENoYW5uZWxzIFNQRElGIC8gQURBVCBJ
bnRlcmZhY2UKPiAyNCBCaXQgLyA5NiBrSHogRGlnaXRhbCBBdWRpbwo+IEFEQVQgU3luYyBJbgo+
IE1JREkgSS9PCj4gVG90YWxNaXjihKIKPiAyNCBCaXQgLyA5NiBrSHogw7wKPiBTeW5jQWxpZ27C
riBaTE3CriBTeW5jQ2hlY2vCrgo+Ci4uLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
