From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] ASoC: Amstrad Delta: fix NULL pointer
	dereference
Date: Wed, 2 Feb 2011 11:02:20 +0100
Message-ID: <201102021102.20679.jkrzyszt@tis.icnet.pl>
References: <201102011840.55512.jkrzyszt@tis.icnet.pl>
	<20110201213301.GB12101@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A9E7103832
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 11:03:21 +0100 (CET)
In-Reply-To: <20110201213301.GB12101@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

RG5pYSB3dG9yZWsgMDEgbHV0eSAyMDExIG8gMjI6MzM6MDEgTWFyayBCcm93biBuYXBpc2HFgihh
KToKPiBPbiBUdWUsIEZlYiAwMSwgMjAxMSBhdCAwNjo0MDo1NVBNICswMTAwLCBKYW51c3ogS3J6
eXN6dG9maWsgd3JvdGU6Cj4gPiBJdCBsb29rcyBsaWtlIHRoZSAuY2FyZCBtZW1iZXIgb2YgdGhl
IHNuZF9zb2NfcGNtX3J1bnRpbWUgc3RydWN0dXJlCj4gPiBwb2ludGVkIHRvIGJ5IHRoZSBzbmRf
c29jX2RhaV9saW5rLmluaXQoKSBhcmd1bWVudCBpcyBubyBsb25nZXIKPiA+IGluaXRpYWxpemVk
IGJlZm9yZSB0aGUgZnVuY3Rpb24gYmVpbmcgY2FsbGVkLiBBcyB0aGUgQW1zdHJhZCBEZWx0YQo+
ID4gc291bmQgY2FyZCBkcml2ZXIgd2FzIG1ha2luZyB1c2Ugb2YgaXQgZm9yIGxvY2F0aW5nIGl0
cwo+ID4gc25kX3NvY19jYXJkIHN0cnVjdHVyZSwgdGhpcyByZXN1bHRlZCBpbiBhY3R1YWwgb3Ig
cG90ZW50aWFsIE5VTEwKPiA+IHBvaW50ZXIgZGVyZWZlcmVuY2VzLgo+IAo+IFNlZW1zIGxpa2Ug
aXQnZCBiZSBiZXR0ZXIgdG8gZml4IHRoaXMgaW4gdGhlIGNvcmUgLSB0aGlzIGlzIGEKPiByZWFz
b25hYmxlIHRoaW5nIHRvIHdhbnQgdG8gaGF2ZSBzZXQgdXAgYW5kIHRoZSB1c2UgYW1zLWRlbHRh
IG1ha2VzCj4gb2YgaXQgc2VlbXMgcGVyZmVjdGx5IHNlbnNpYmxlLiAgQ2FyZSB0byBkbyBhIHBh
dGNoPwoKU3VyZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
