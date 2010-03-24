From: lieven moors <lievenmoors@gmail.com>
Subject: Re: [Patch v2] aconnect -x: Do not update index after
 removal of connection.
Date: Wed, 24 Mar 2010 16:32:29 +0100
Message-ID: <4BAA308D.6020305@gmail.com>
References: <4B9E306F.8070705@gmail.com>	<1268663545.9635.10.camel@mattotaupa>
	<4B9E7123.4000207@gmail.com> <1268686034.16974.39.camel@mattotaupa>
	<4B9EB507.1060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id D37C810388F
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 16:32:34 +0100 (CET)
Received: by bwz20 with SMTP id 20so8834103bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 08:32:32 -0700 (PDT)
In-Reply-To: <4B9EB507.1060406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDMvMTUvMjAxMCAxMTozMCBQTSwgbGlldmVuIG1vb3JzIHdyb3RlOgo+IE9uIDAzLzE1LzIw
MTAgMDk6NDcgUE0sIFBhdWwgTWVuemVsIHdyb3RlOgo+PiBBbSBNb250YWcsIGRlbiAxNS4wMy4y
MDEwLCAxODo0MCArMDEwMCBzY2hyaWViIGxpZXZlbiBtb29yczoKPj4gICAKPj4+IE9uIDAzLzE1
LzIwMTAgMDM6MzIgUE0sIFBhdWwgTWVuemVsIHdyb3RlOgo+Pj4gICAgIAo+PiBb4oCmXQo+Pgo+
PiAgIAo+Pj4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24sIGhlcmUgaXMgYSBzZWNvbmQgdHJ5
Li4uCj4+PiBJJ20gbm90IHN1cmUgd2hhdCBjYXVzZWQgdGhlIGV4dHJhIGxpbmUgYnJlYWtzLCBi
dXQgdGhpcyBzaG91bGQgYmUgcGxhaW4gCj4+PiB0ZXh0IG5vdy4KPj4+IEhvcGUgdGhpcyB3b3Jr
cy4uLgo+Pj4gICAgIAo+PiBVbmZvcnR1bmF0ZWx5IEkgZGlkIG5vdC4gQ291bGQgeW91IGp1c3Qg
YXR0YWNoIHRoZSBwYXRjaCwgcGxlYXNlPwo+Pgo+Pgo+PiBUaGFua3MsCj4+Cj4+IFBhdWwKPj4g
ICAKPj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCj4+IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCj4+ICAgCj4gT2ssIGRvbmUuCgpIaSBQYXVsLAoKRGlkIHlvdSBnZXQgbXkgcGF0
Y2ggaW4gdGhlIGVuZD8KCkdyZWV0aW5ncywKCkxpZXZlbgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
