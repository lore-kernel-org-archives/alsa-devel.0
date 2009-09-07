From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] Minor WM8580 enhancements.
Date: Mon, 7 Sep 2009 21:40:40 +0900
Message-ID: <1b68c6790909070540v28a4e143g5289e6bafd27c2e6@mail.gmail.com>
References: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
	<20090906012232.GA4239@sirena.org.uk>
	<1b68c6790909051850y2386addhae71898ada96954@mail.gmail.com>
	<20090906111133.GA26748@opensource.wolfsonmicro.com>
	<1b68c6790909060513v4f315f93uf4203408ba5baeab@mail.gmail.com>
	<20090906134207.GA9009@sirena.org.uk>
	<1b68c6790909061935p4611208csf75f4802c669f28a@mail.gmail.com>
	<20090907115820.GD29898@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id DF61F10381A
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 14:40:41 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so592119qwf.56
	for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2009 05:40:41 -0700 (PDT)
In-Reply-To: <20090907115820.GD29898@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBTZXAgNywgMjAwOSBhdCA4OjU4IFBNLCBNYXJrCkJyb3duPGJyb29uaWVAb3BlbnNv
dXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBNb24sIFNlcCAwNywgMjAwOSBhdCAx
MTozNTowOEFNICswOTAwLCBqYXNzaSBicmFyIHdyb3RlOgo+PiBPbiBTdW4sIFNlcCA2LCAyMDA5
IGF0IDEwOjQyIFBNLCBNYXJrCj4+IEJyb3duPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWlj
cm8uY29tPiB3cm90ZToKPgo+PiA+PiDCoCDCoCBDb2RlYyByZWNvbW1lbmRzIMKgLSBCQ0xLPXsz
MiwgNDh9IMKgIFJGUz17Mzg0fQo+Cj4+ID4gSSdtIG5vdCBzdXJlIHdoZXJlIHRoZXNlIENPREVD
IHJlY29tbWVuZGF0aW9ucyBjb21lIGZyb20/Cj4KPj4gV2VsbCwgbXkgZXhhbXBsZSB3YXMgaW5z
cGlyZWQgZnJvbSBvbmUgcmVjb21tZW5kYXRpb24vY29uc3RyYWludCBpCj4+IGZvdW5kIGF0IFBh
Z2UtMjMsIG9mIFdNODU4MEEgbWFudWFsIFJldi00LjcgTWFyY2gtMjAwOS4KPj4gSXQgaW5kaWNh
dGVzIHRoYXQgd2UgY2FuJ3QgaGF2ZSBCQ0xLIGFzIDE2ZnMgaWYgUkZTKE1DTEsvTFJDTEspIGlz
Cj4+IGVpdGhlciAxMjhmcyBvciAxOTJmcy4KPgo+IFRoYXQncyBub3QgYSByZWNvbW1lbmRhdGlv
biwgdGhhdCdzIGEgaGFyZHdhcmUgbGltaXQuCkFub3RoZXIgd2F5IG9mIHB1dHRpbmcgaXQuCldo
ZW4gd2UgY2FuJ3QgZG8gc29tdGhpbmcsIGl0IGlzIHJlY29tbWVuZGVkIG90aGVyd2lzZSA6KQoK
PsKgVGhvdWdoIEkgc3RpbGwKPiBkb24ndCBzZWUgaG93IHdlIGdldCB0byBhIDQ4ZnMgQkNMSyAo
d2hpY2ggY291bGQgb25seSBiZSBnZW5lcmF0ZWQgd2l0aAo+IGEgNDhmcyBzeXN0ZW0gY2xvY2sp
IG9yIGEgcmVjb21tZW5kYXRpb24gZm9yIGEgMzg0ZnMgTUNMSyBpbiBwYXJ0aWN1bGFyLgo+IFRo
aXMgaXMgYWxsIGEgYml0IG9mIGEgc2lkZXRyYWNrIGFueXdheS4KWWVzLCBhIGJhZGx5IHB1dCBl
eGFtcGxlLgoKPj4gSnVzdCBhcyBXTTg1ODAgaGFzIGEgY29uc3RyYWludCBvbiBCQ0xLKDEyOGZz
KSBhdCBNQ0xLPTEyOCwxOTJmcywgc29tZQo+PiBTb0MgbWF5IGhhdmUgYSBjb25zdHJhaW50IG9m
IHVzaW5nIEJDTEs9NDhmcyBmb3IgTUNMSz0zODRmcwo+PiBAMTYtYml0cy9zYW1wbGUuCj4gTGlr
ZSBJIHNheSwgSSdkIGJlIHZlcnkgc3VycHJpc2VkIHRvIHNlZSBhbnkgc3VjaCBjb25zdHJhaW50
ClRoaXMgd2FzIGp1c3QgYW4gZXhhbXBsZS4KSSBvbmNlIGhhZCB0byBzZXQgbm9uLW9idmlvdXMg
dmFsdWVzIG9mIEJDTEsrTUNMSyBvbiB0aGUgY29kZWMgZHVlIHRvIHRoZSBjbG9jawpJIGhhZCB0
aGF0IHJhbiB0aGUgU29DIGluIE1hc3RlciBtb2RlLiBXaWxsIGxldCB5b3Uga25vdyB0aGUgcmVh
bCBsaWZlCmV4YW1wbGUgaWYgaSBjdWQgZGlnIHRoYXQgdXAgYWdhaW4uCgpJIHRoaW5rIGkgaGF2
ZSBtYWRlIHdoYXRldmVyIHBvaW50cyBpIGhhZC4gQW0gYXQgcGVhY2Ugbm93IDopCkRvIGFzIHUg
d2lzaCBhcHByb3ByaWF0ZSB3aXRoIHRoZSBwYXRjaC4KClJlZ2FyZHMuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
