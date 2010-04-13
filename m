From: "=?utf-8?q?R=C3=A9mi?= Denis-Courmont" <remi@remlab.net>
Subject: Re: [PATCH] Use thread-safe locale functions
Date: Tue, 13 Apr 2010 18:25:42 +0300
Message-ID: <201004131825.42726.remi@remlab.net>
References: <1271170217-10904-1-git-send-email-remi@remlab.net>
	<4BC48B96.7040002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id CB9E410382F
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:25:44 +0200 (CEST)
In-Reply-To: <4BC48B96.7040002@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TGUgbWFyZGkgMTMgYXZyaWwgMjAxMCAxODoxOTo1MCBDbGVtZW5zIExhZGlzY2gsIHZvdXMgYXZl
eiDDqWNyaXQgOgo+IFLDqW1pIERlbmlzLUNvdXJtb250IHdyb3RlOgo+ID4gc2V0bG9jYWxlKCkg
aXMgbm90IHRocmVhZC1zYWZlLiBJdCBjYW4gYWN0dWFsbHkgdHJpZ2dlciBhIGNyYXNoIGlmCj4g
PiBhbm90aGVyIHRocmVhZCB1c2VzIGxvY2FsZSBpbmZvcm1hdGlvbnMgYXQgdGhlIHNhbWUgdGlt
ZSBpbiB0aGUgcHJvY2Vzcy4KPiA+IExpYnJhcnkgY29kZSBzaG91bGQgdXNlIFBPU0lYIG5ld2xv
Y2FsZS9kdXBsb2NhbGUvdXNlbG9jYWxlL2ZyZWVsb2NhbGUKPiA+IGluc3RlYWQuCj4gCj4gSSBk
b24ndCB0aGluayB0aGVzZSBmdW5jdGlvbnMgYXJlIGF2YWlsYWJsZSBpbiBzbWFsbCBlbWJlZGRl
ZCBDCj4gbGlicmFyaWVzIGxpa2UgZGlldGxpYmMuCgpBbmQgeW91J3JlIHN1Z2dlc3Rpbmcgd2hh
dD8gVGhhdCB3ZSBjb250aW51ZSB0byBsZXQgYWxzYS1saWIgY3Jhc2ggcHJvZ3JhbXMgCnRoYXQg
dXNlIGl0PwoKLS0gClLDqW1pIERlbmlzLUNvdXJtb250Cmh0dHA6Ly93d3cucmVtbGFiLm5ldC8K
aHR0cDovL2ZpLmxpbmtlZGluLmNvbS9pbi9yZW1pZGVuaXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
