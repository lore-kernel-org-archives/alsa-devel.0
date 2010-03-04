From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Add delay information for Samsung
	IISv2 DAIs
Date: Thu, 4 Mar 2010 22:38:39 +0900
Message-ID: <1b68c6791003040538u2e6cac5bjd3cdb5fa642d3967@mail.gmail.com>
References: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1b68c6791003040518k21b0894ap150bcad6a1195da3@mail.gmail.com>
	<20100304132416.GB12350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8E300243A6
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 14:38:42 +0100 (CET)
Received: by vws15 with SMTP id 15so1128291vws.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2010 05:38:39 -0800 (PST)
In-Reply-To: <20100304132416.GB12350@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXIgNCwgMjAxMCBhdCAxMDoyNCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFRodSwgTWFyIDA0LCAyMDEwIGF0
IDEwOjE4OjU5UE0gKzA5MDAsIGphc3NpIGJyYXIgd3JvdGU6Cj4+IE9uIFRodSwgTWFyIDQsIDIw
MTAgYXQgOTowNSBQTSwgTWFyayBCcm93bgo+Cj4+ID4gK3N0YXRpYyBsb25nIHMzYzI0MTJfaTJz
X2RlbGF5KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAo+PiA+ICsgPz8gPz8g
Pz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz8gPz9zdHJ1Y3Qgc25kX3NvY19kYWkgKmRh
aSkKPgo+PiByZXR1cm4gdHlwZSBzbmRfcGNtX3NmcmFtZXNfdCA/Cj4KPiBNZWgsIHllYWguIMKg
SXQncyBhY3R1YWxseSB0aGUgc2FtZSB0eXBlIHVuZGVybmVhdGguCm9mIGNvdXJzZSwgYnV0IHN0
aWxsLi4uCgo+PiBJIGFtIHRyeWluZyB0byBtYWtlIGZ1bmN0aW9ucyBpbiBzM2MtaTJzLXYyLmMg
cmUtZW50cmFudCBhcyBtdWNoIGFzIHBvc3NpYmxlLAo+PiAnZGVsYXknIHRvbyBzZWVtcyB0byBi
ZSBhIGdvb2QgY2FuZGlkYXRlLgo+Cj4gQ291bGQgeW91IGV4cGFuZCBvbiB3aGF0IHlvdSBtZWFu
IGJ5IHRoaXM/CkkgbWVhbiwgJ2RlbGF5JyBpcyBzdWNoIGEgdHJpdmFsIGZ1bmMgdGhhdCBpdCBj
YW4gcGVyaGFwcyBkbwpjb250cm9sbGVyIHNwZWNpZmljIHN0dWZmCmFmdGVyIGNoZWNraW5nIHNv
bWUgZmxhZyhuZXcpIGluIHMzY19pMnN2Ml9pbmZvLgoKPiBBbGwgd2UncmUgZG9pbmcgaGVyZSBp
cwo+IGRpcmVjdGx5IHJlcG9ydGluZyBhIHZhbHVlIHJlYWQgZnJvbSBhIG1lbW9yeSBtYXBwZWQg
cmVnaXN0ZXIgc28gdGhlcmUncwo+IG5vdGhpbmcgdG8gYmUgd29ycmllZCBhYm91dCBmcm9tIGEg
bG9ja2luZyBwb2ludCBvZiB2aWV3IHVubGVzcyB0aGVyZQo+IHdlcmUgYSBtdWx0aS1jb3JlIHN5
c3RlbSBhbmQgdGhlIGJ1cyB0byB0aGUgSVAgbmVlZGVkIHNvbWUgbG9ja2luZywKPiB3aGljaCBp
cyB2YW5pc2hpbmdseSB1bmxpa2VseSB0byBldmVyIGhhcHBlbi4KQXMgSSBzYWlkLCBJIGFtIE9L
LiBJIGp1c3Qgc2VlIHRoaXMgZnVuYyBiZWluZyBtb2RpZmllZCBzb29uIHRvIGhhbmRsZQppMnN2
NCB0b28uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
