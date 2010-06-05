From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2 1/3]AsoC/nuc900: patch for
	SUBSTREAM_TYPE', 'PCM_TX' and 'PCM_RX' removal
Date: Sat, 5 Jun 2010 15:08:42 +0800
Message-ID: <AANLkTin_BgTdvaZ8ElKl5ljGuOw9i_CS1mchU6lYeIeS@mail.gmail.com>
References: <4C05F211.7070308@gmail.com> <1275471787.3037.28.camel@odin>
	<20100602104056.GC2457@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E04E103B4A
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jun 2010 09:08:44 +0200 (CEST)
Received: by vws8 with SMTP id 8so2329232vws.38
	for <alsa-devel@alsa-project.org>; Sat, 05 Jun 2010 00:08:42 -0700 (PDT)
In-Reply-To: <20100602104056.GC2457@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCjIwMTAvNi8yIE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29u
bWljcm8uY29tPjoKPiBPbiBXZWQsIEp1biAwMiwgMjAxMCBhdCAxMDo0MzowN0FNICswMTAwLCBM
aWFtIEdpcmR3b29kIHdyb3RlOgo+PiBPbiBXZWQsIDIwMTAtMDYtMDIgYXQgMTM6NTQgKzA4MDAs
IFdhbiBab25nU2h1biB3cm90ZToKPj4gPiBUaGlzIHBhdGNoIGlzIHRvIHJlbW92ZSB0aGUgJ1NV
QlNUUkVBTV9UWVBFJywnUENNX1RYJyBhbmQgJ1BDTV9SWCcgZGVmaW5pdGlvbi4KPj4gPgo+PiA+
IFRoZXJlIGlzIG5vIG5lZWQgdG8gcmVkZWZpbmUgU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSyBh
cyBQQ01fVFgsCj4+ID4gdGhlIFNVQlNUUkVBTV9UWVBFKHN1YnN0cmVhbSkgY2FuIGJlIGRlbGV0
ZWQgdG9vLCB0aGUgcGxheWJhY2sgb3IgcmVjb3JkIGNhbiBiZQo+PiA+IGp1ZGdlZCBieSAnaWYg
KHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spJyBkaXJlY3Rs
eSByYXRoZXIKPj4gPiB0aGFuICdpZiAoUENNX1RYID09IHN0eXBlKScsIHdoaWNoIG1ha2VzIHRo
ZSBjb2RlcyBlYXN5IHRvIHJlYWQuCj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBXYW4gWm9uZ1No
dW48bWN1b3MuY29tQGdtYWlsLmNvbT4KPgo+IE5vdGUgaGVyZSB0aGF0IHlvdSdyZSBzdGlsbCBt
aXNzaW5nIGEgc3BhY2UgYmV0d2VuIHlvdXIgbmFtZSBhbmQgZS1tYWlsCj4gYWRkcmVzcy4KPgoK
RG8gSSBuZWVkIHJlLXNlbnQgdGhpcyBwYXRjaCB3aXRoIHRoZSBtaXNzaW5nIHNwYWNlIGZpeD8K
Cj4+IEFsbAo+Cj4+IEFja2VkLWJ5OiBMaWFtIEdpcmR3b29kIDxscmdAc2xpbWxvZ2ljLmNvLnVr
Pgo+Cj4gSSd2ZSBhcHBsaWVkIGFsbCB0aGUgcGF0Y2hlcywgc2luY2UgSSBoYWQgdG8gZml4IHVw
IHRoZSBjaGFuZ2Vsb2dzCj4gYW55d2F5IEkgdXBkYXRlZCB0aGUgbXMgdG8gdXMgaW4gdGhlIGNo
YW5nZWxvZyBmb3IgcGF0Y2ggMi4gwqBUaGFua3MuCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+IEFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCj4KCgoKLS0gCipsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdAptYWlsIGFkZHI6bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
CnlvdSBjYW4gc3Vic2NyaWJlIGJ5OgpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKCiogbGludXgtYXJtLU5VQzkwMCBtYWlsaW5nIGxp
c3QKbWFpbCBhZGRyOk5VQzkwMEBnb29nbGVncm91cHMuY29tCm1haW4gd2ViOiBodHRwczovL2dy
b3Vwcy5nb29nbGUuY29tL2dyb3VwL05VQzkwMAp5b3UgY2FuIHN1YnNjcmliZSBpdCBieSBzZW5k
aW5nIG1lIG1haWw6Cm1jdW9zLmNvbUBnbWFpbC5jb20KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
