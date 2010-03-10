From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit
	definitions
Date: Wed, 10 Mar 2010 21:24:45 +0900
Message-ID: <1b68c6791003100424l56812e3fy69890846736acb6d@mail.gmail.com>
References: <1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<20100310110020.GH24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id B471910387C
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:24:47 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so467835qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 04:24:45 -0800 (PST)
In-Reply-To: <20100310110020.GH24422@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgODowMCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTWFyIDEwLCAyMDEwIGF0
IDA0OjQ5OjAwUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4+IERlZmluZSBtb3JlIGJpdCBk
ZWZpbml0aW9ucyBpbiB0aGUgb3JkZXIgb2YgbWFpbmxpbmUgc3VwcG9ydCBmb3IgdGhlCj4+IFNv
Qy4KPiBGb3IgY2hhbmdlcyBsaWtlIHRoaXMgaXQnZCBiZSBiZXR0ZXIgaWYgdGhlIGNoYW5nZWxv
ZyBzYWlkIHNvbWV0aGluZwo+IGxpa2UgIkFkZCByZWdpc3RlciBiaXQgZGVmaW5pdGlvbnMgZm9y
IFM1UEMxeHgiIC0gdGhpcyBpcyBhbGwgbWFpbmxpbmUKPiBjb2RlIHNvIGl0J3MgbXVjaCBjbGVh
cmVyIHRvIHNheSB0aGF0IHRoaXMgaXMgYWRkaW5nIHN1cHBvcnQgZm9yIGEgbmV3Cj4gU29DLgpJ
IHRob3VnaHQgb2YgYWRkaW5nIGRlZmluaXRpb25zIGluICdjaHJvbm9sb2dpY2FsIG9yZGVyIG9m
IHN1cHBvcnQnIGluIGtlcm5lbApyYXRoZXIgdGhhbiBTb0Mgd2lzZS4KT2ssIHdpbGwgZGl2aWRl
IGluIHR3byBwYXRjaGVzLgoKPiBPbmUgb3RoZXIgdGhpbmcgSSdkIHN1Z2dlc3QgaXMgdGhhdCB3
aGVuIGNvbnN0cnVjdGluZyBhIHBhdGNoIHNlcmllcwo+IGl0J2QgYmUgYmV0dGVyIHRvIHB1dCB0
aGUgbW9yZSBpbnZhc2l2ZSBvciBjb250cm92ZXJzaWFsIGNoYW5nZXMgKGxpa2UKPiBtb3Zpbmcg
dGhlIGhlYWRlcnMpIGxhc3QuIMKgVGhpcyBtYWtlcyBpdCBlYXNlciB0byBhcHBseSBiaXRzIG9m
IHRoZQo+IHNlcmllcyBpZiB0aGVyZSBpcyBhbnkgY29udHJvdmVyc3kuCkkgdGhvdWdodCBJIGFs
cmVhZHkgbWFkZSB0aGF0IHN1cmUuCkluIG15IG9waW5pb24sIHRoZSBvbmx5IGNvbnRyb3ZlcnNp
YWwgcGF0Y2ggd2FzICdoZWFkZXItY29weWluZycgYW5kIEkgY291bGRuJ3QKbW92ZSB0aGF0IGFu
eSBmdXJ0aGVyIGRvd24gdGhlIHNlcmllcyBvciBvdGhlciBjaGFuZ2VzIHdpdGhvdXQgdGhhdC4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
