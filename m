From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ASoC: TLV320AIC3x: Adding additional functionality
 for 3106 with [Patch] for discuss
Date: Tue, 15 Mar 2016 13:47:19 +0200
Message-ID: <56E7F647.7060500@ti.com>
References: <56E69B3F.8090306@mcsplus.ru> <56E6CEE9.5030802@ti.com>
 <56E6D177.5050108@mcsplus.ru> <56E6E921.5030007@ti.com>
 <56E7E145.5010904@mcsplus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A28472612AF
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 12:47:25 +0100 (CET)
In-Reply-To: <56E7E145.5010904@mcsplus.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Karaldin <karaldin@mcsplus.ru>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Jyri Sarha <jsarha@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

T24gMDMvMTUvMTYgMTI6MTcsIFRpbXVyIEthcmFsZGluIHdyb3RlOgo+IDE0LjAzLjIwMTYgMTk6
MzgsIFBldGVyIFVqZmFsdXNpINC/0LjRiNC10YI6Cj4+IE9uIDAzLzE0LzIwMTYgMDQ6NTcgUE0s
IFRpbXVyIEthcmFsZGluIHdyb3RlOgo+Pj4gSGksIFBldGVyIQo+Pj4gV2hhdCdzIGFib3V0IHBs
YWNpbmcgY2FwdHVyZSBjb250cm9scyBpbiB0aGUgUGxheWJhY2sgc2VjdGlvbiBvZiBBbHNhbWl4
ZXIKPj4+IHZpZXc/Cj4+IFllYWgsIGl0IGlzIGFubm95aW5nLiBUaGV5IGNhbiBiZSBmaXhlZCBi
eToKPj4gIkxpbmUxTCBTd2l0Y2giIC0+ICJMaW5lMUwgQ2FwdHVyZSBTd2l0Y2giIGFuZCBzbyBv
bi4gT24gdGhlIG90aGVyIGhhbmQgd2UgaGFkCj4+IHRoZXNlIHVuZm9ydHVuYXRlIGNvbnRyb2wg
bmFtZXMgSSB0aGluayBzaW5jZSB0aGUgYmVnaW5uaW5nIGFuZCBpdCBpcyBraW5kIG9mCj4+IGFu
IEFCSSBmb3IgZXhpc3RpbmcgcHJvZHVjdHMuIEkgZG9uJ3QgaGF2ZSBpc3N1ZSBjaGFuZ2luZyB0
aGVtLCBidXQgZXhpc3RpbmcKPj4gc2V0dXBzIHJlbHlpbmcgb24gdGhlIGNvbnRyb2wgbmFtZXMg
bWlnaHQgYnJlYWsuLi4KPj4KPj4+IERvZXMgcmVzZXR0aW5nIG9mIHNvbWUgcmVnaXN0ZXJzIGR1
cmluZyBzdGFydC9zdG9wIG9mIHJlY29yZGluZwo+Pj4gY29ubmVjdCB3aXRoIGl0Pwo+PiBOb3Qg
c3VyZSB3aGF0IHlvdSBtZWFuLgo+Pgo+IEkgbWVhbiBjdXJyZW50IHNpdHVhdGlvbjoKPiAKPiAj
aTJjZHVtcCAtZiAteSAtciAxMy0xMyAxIDB4MWIKPiBSZXN1bHQ6IDB4MDAKPiAjYXJlY29yZCB0
ZXN0LndhdiAmCj4gI2kyY2R1bXAgLWYgLXkgLXIgMTMtMTMgMSAweDFiCj4gUmVzdWx0OiAweDAw
Cj4gIyBhbWl4ZXIgc3NldCAnSGVhZHNldCBEZXRlY3QgRW5hYmxlJyAqb24qCj4gI2kyY2R1bXAg
LWYgLXkgLXIgMTMtMTMgMSAweDFiCj4gUmVzdWx0OioweDgwKgo+ICNraWxsYWxsIGFyZWNvcmQK
PiAjaTJjZHVtcCAtZiAteSAtciAxMy0xMyAxIDB4MWIKPiBSZXN1bHQ6IDB4MDAKPiAjYXJlY29y
ZCB0ZXN0LndhdiAmCj4gI2kyY2R1bXAgLWYgLXkgLXIgMTMtMTMgMSAweDFiCj4gUmVzdWx0Oiow
eDAwCj4gKiNraWxsYWxsIGFyZWNvcmQqCj4gKmFtaXhlciBzc2V0ICdIZWFkc2V0IERldGVjdCBF
bmFibGUnKm9uKioKPiAqI2kyY2R1bXAgLWYgLXkgLXIgMTMtMTMgMSAweDFiCj4gUmVzdWx0Oioq
MHgwMAo+ICoqI2FtaXhlciBzc2V0ICdIZWFkc2V0IERldGVjdCBFbmFibGUnIG9mZgo+ICphbWl4
ZXI6IEludmFsaWQgY29tbWFuZCEqCj4gCj4gU28gc3RhdGUgb2YgJ0hlYWRzZXQgRGV0ZWN0IEVu
YWJsZScgYW5kIG90aGVycyBvZiBteSBjb250cm9scyB3ZXJlIG5vdCBzdG9yZWQKPiBkdXJpbmcg
YXJlY29yZC9hcGxheSByZXN0YXJ0IChvcGVuIGFuZCBjbG9zZSBkZXZpY2UpLgoKYWljM3hfc2V0
X3Bvd2VyKCkgd2lsbCBzb2Z0IHJlc2V0IHRoZSBjb2RlYyBvbiBwb3dlciBvZmYgd2hpY2ggcmVz
ZXRzIGFsc28gdGhlCmhlYWRzZXQgZGV0ZWN0IHJlZ2lzdGVycy4KCi0tIApQw6l0ZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
