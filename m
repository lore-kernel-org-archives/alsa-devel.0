From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Fri, 3 Dec 2010 19:23:27 +0900
Message-ID: <AANLkTikrmOWOS=K4XaBigw1X7hSJZixV2JjctB1=mtOL@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<AANLkTi=V_S=ivPv8f1uRC+8ArmX_dhHWGpbqaSqEzJ_g@mail.gmail.com>
	<AANLkTimqqS70vow58nOqSK7DhWD_NBNpU9ujX08es8SM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C9C642441F
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 11:23:28 +0100 (CET)
Received: by bwz8 with SMTP id 8so8458030bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 02:23:28 -0800 (PST)
In-Reply-To: <AANLkTimqqS70vow58nOqSK7DhWD_NBNpU9ujX08es8SM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBEZWMgMywgMjAxMCBhdCA3OjE3IFBNLCBTZXVuZ3doYW4gWW91biA8Y2xhdWRlLnlv
dW5AZ21haWwuY29tPiB3cm90ZToKPj4+IC0gwqAgwqAgwqAgc21ka19zbmRfc3BkaWZfZGV2aWNl
ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJzb2MtYXVkaW8iLCAtMSk7Cj4+PiArIMKgIMKgIMKg
IHNtZGtfc25kX3NwZGlmX2RldmljZSA9IHBsYXRmb3JtX2RldmljZV9hbGxvYygic29jLWF1ZGlv
IiwgMCk7Cj4+Cj4+IEkgdGhpbmsgdGhpcyBpcyBub3QgYXBwcm9wcmlhdGUuCj4+Cj4+IE1heWJl
IHlvdSBzaG91bGQgZG8gOi0KPj4gwqBzY2xrX2F1ZGlvMCA9IGNsa19nZXQoTlVMTCwgInNjbGtf
YXVkaW8iKTsKPgo+IFllcywgSSB0aGluayBzbywgYnV0IHdpdGhvdXQgaWQsIHRoZXJlIGlzIG5v
IHdheSB0byBmaW5kIHNjbGtfYXVkaW8wCj4gaW4gY3VycmVudCBzYW1zdW5nIHM1cC4gQmVjYXVz
ZSwgY3VycmVudCBzY2xrX2F1ZGlvMCwxLDIgaXMgb25seSB0bwo+IGRpc3Rpbmd1aXNoZWQgYnkg
aWQgbm90IGJ5IG5hbWUsIGFuZCBhbHNvIGFsbCBzY2xrX2F1ZGlvMCdzIGlkIGZvciBzNXAKPiBp
cyAnMCcgZm9yIG5vdy4gU28sIEkgdGhpbmsgdGhhdCB0aGlzIG1vZGlmaWNhdGlvbiBpcyBtb3Jl
IGJhdHRlciB0bwo+IG1vZGlmeSBhbGwgczVwJ3Mgc2Nsa19hdWRpbyBjbG9jayBpZCB0byAnLTEn
LgoKdGhlIHBsYXRmb3JtX2RldmljZSBzb2MtYXVkaW8gaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBh
IHBhcnRpY3VsYXIKYXVkaW8gY29udHJvbGxlciwgc28gSSBkb24ndCBmYXZvciBhc3NvY2lhdGlu
ZyB3aXRoIGEgY29udHJvbGxlci4KR29vZCBmb3IgdXMsIFNQRElGIG5lZWRzIHNjbGtfYXVkaW8w
IHdoaWNoIGlzIHRoZSBmaXJzdCBpbnN0YW5jZQp0aGF0IGNsa19nZXQgd2lsbCBjb21lIGFjcm9z
cyBhbmQgaGVuY2Ugd2UgY2FuIHN0aWxsIGdldCB0aGUgY2xvY2suCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
