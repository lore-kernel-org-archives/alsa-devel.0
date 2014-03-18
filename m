From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH RFC] ALSA: oxygen: Xonar DG(X): fix Stereo
 Upmixing regression
Date: Tue, 18 Mar 2014 09:31:25 +0100
Message-ID: <5328045D.6030908@ladisch.de>
References: <53276556.20107@ladisch.de> <20140318113539.5340579f@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 80FA6261AED
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:31:26 +0100 (CET)
In-Reply-To: <20140318113539.5340579f@v1ron-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Um9tYW4gVm9sa292IHdyb3RlOgo+IENsZW1lbnMgTGFkaXNjaCA8Y2xlbWVuc0BsYWRpc2NoLmRl
PiDQv9C40YjQtdGCOgo+PiBUaGUgY29kZSBpbnRyb2R1Y2VkIGluIGNvbW1pdCAxZjkxZWNjMTRk
ZWUgKCJBTFNBOiBveHlnZW46IG1vZGlmeQo+PiBhZGp1c3RfZGdfZGFjX3JvdXRpbmcgZnVuY3Rp
b24iKSBhY2NpZGVudGFsbHkgZGlzcmVnYXJkZWQgdGhlIG9sZAo+PiB2YWx1ZSBvZiB0aGUgcGxh
eWJhY2sgcm91dGluZyByZWdpc3Rlciwgc28gaXQgYnJva2UgdGhlICJTdGVyZW8KPj4gVXBtaXhp
bmciIG1peGVyIGNvbnRyb2wuCj4+Cj4+IFRoZSB1bm11dGVkIHBhcnRzIG9mIHRoZSBjaGFubmVs
IHJvdXRpbmcgYXJlIHRoZSBzYW1lIGZvciBhbGwgc2V0dGluZ3MKPj4gb2YgdGhlIG91dHB1dCBk
ZXN0aW5hdGlvbiwgc28gaXQgc3VmZmljZXMgdG8gcmV2ZXJ0IHRoYXQgcGFydCBvZiB0aGUKPj4g
cGF0Y2guCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENsZW1lbnMgTGFkaXNjaCA8Y2xlbWVuc0BsYWRp
c2NoLmRlPgo+PiAtLS0KPj4gIHNvdW5kL3BjaS9veHlnZW4veG9uYXJfZGcuYyB8ICAgMzAgKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IEkgaGF2ZSBwcm9ibGVtcyB3aXRoIGFwcGx5aW5n
IHRoaXMgcGF0Y2ggb24gbXkgbG9jYWwgcmVwby4gQ291bGQgeW91Cj4gcGxlYXNlIHRlbGwgbWUg
d2hpY2ggZ2l0IHJlcG8gYXJlIHlvdSB1c2luZz8KCkl0J3MgYmFzZWQgb24gdGl3YWkvc291bmQu
Z2l0LCBidXQgTGludXMnIHRyZWUgc2hvdWxkIHdvcmsgdG9vLgoKClJlZ2FyZHMsCkNsZW1lbnMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
