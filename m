From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit
	definitions
Date: Wed, 10 Mar 2010 22:03:28 +0900
Message-ID: <1b68c6791003100503r212cc88fq998140531a35d34@mail.gmail.com>
References: <1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<20100310110020.GH24422@rakim.wolfsonmicro.main>
	<1b68c6791003100424l56812e3fy69890846736acb6d@mail.gmail.com>
	<20100310123811.GQ24422@rakim.wolfsonmicro.main>
	<1b68c6791003100449m13934b66hce1cd0e8a14c42f3@mail.gmail.com>
	<20100310125622.GS24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id DFA4D10393E
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 14:03:29 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so477358qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 05:03:29 -0800 (PST)
In-Reply-To: <20100310125622.GS24422@rakim.wolfsonmicro.main>
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

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgOTo1NiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTWFyIDEwLCAyMDEwIGF0
IDA5OjQ5OjAzUE0gKzA5MDAsIGphc3NpIGJyYXIgd3JvdGU6Cj4+IE9uIFdlZCwgTWFyIDEwLCAy
MDEwIGF0IDk6MzggUE0sIE1hcmsgQnJvd24KPgo+PiA+IEkgYWdyZWUgdGhhdCB0aGlzIGlzIHRo
ZSBvbmx5IHJlYWxseSBjb250cm92ZXJzaWFsIGNoYW5nZSwgYnV0IGl0IHNlZW1lZAo+PiA+IGxp
a2UgcHJldHR5IG11Y2ggYWxsIHRoZSBjaGFuZ2VzIHRoYXQgYWRkZWQgc3R1ZmYgdG8gdGhlIGhl
YWRlcnMgb3IgdXNlZAo+PiA+IHRoZW0gY291bGQndmUgYmVlbiBkb25lIHByZS1tb3ZlIHNvIHRo
YXQgdGhleSBkaWRuJ3QgZGVwZW5kIG9uIGl0Lgo+Cj4+IE5vdCBzdXJlIHdoaWNoIHBhdGNoIHlv
dSBwb2ludCwgYnV0IGl0IHdhcyBkZWNpc2lvbiBvZiBsb2dpY2FsCj4+IGJ1aWxkLXVwIGFuZCBz
dWNjZXNzZnVsCj4+IGNvbXBpbGF0aW9uIGFmdGVyIGVhY2ggcGF0Y2ggdGhhdCBtYWRlIHRoZSBw
YXRjaCBzZXJpZXMgYXMgaXQgaXMgbm93Lgo+Cj4gUHJldHR5IG11Y2ggYWxsIG9mIHRoZW0gLSBm
b3IgZXhhbXBsZSwgcGF0Y2ggMTEgYWRkcyBhIGJ1bmNoIG9mIG5ldwo+IGJpdGZpZWxkIGRlZmlu
aXRpb25zIHRvIHRoZSBoZWFkZXIuIMKgVGhpcyBjaGFuZ2UgZGlkbid0IHJlYWxseSBuZWVkIHRo
ZQo+IGhlYWRlciB0byBoYXZlIGJlZW4gbW92ZWQgYmVmb3JlIGl0IHdhcyBtYWRlLCBpdCBjb3Vs
ZCBoYXZlIGJlZW4gZG9uZQo+IHByZS1tb3ZlLgpEZWFyIHRoYXQgd3VkIGhhdmUgZGVmZWF0ZWQg
dGhlIHZlcnkgcHVycG9zZSBvZiBoZWFkZXIgbW92aW5nIC0tIGRvbid0IHdhbm5hCmRlcGVuZCBv
biBjaGFuZ2VzIHN1cmZhY2luZyB2aWEgQVJDSCB0cmVlIGFmdGVyIHRvbyBsb25nLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
