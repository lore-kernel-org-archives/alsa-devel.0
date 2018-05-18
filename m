From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: sound: latency and synchronization measurements
Date: Fri, 18 May 2018 19:41:06 +0530
Message-ID: <CAHhAz+gPGEt_e+Arz-DgyFP+Be5T9bvnvsDKc0ghKZa7JvwCYQ@mail.gmail.com>
References: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
 <CA+wdrgkeeCKpJgyA6bOOap+cqKgo4UrfukQyqQ+WuhDXsnBL0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f176.google.com (mail-ot0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id EBEA5267046
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 16:11:08 +0200 (CEST)
Received: by mail-ot0-f176.google.com with SMTP id 77-v6so9255426otd.4
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 07:11:08 -0700 (PDT)
In-Reply-To: <CA+wdrgkeeCKpJgyA6bOOap+cqKgo4UrfukQyqQ+WuhDXsnBL0g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aris Aris <father.aris@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXkgMTgsIDIwMTggYXQgNjo1MyBQTSwgQXJpcyBBcmlzIDxmYXRoZXIuYXJpc0Bn
bWFpbC5jb20+IHdyb3RlOgo+IEhpLAo+Cj4gWW91IGNvdWxkIHRyeSBiaXRiYW5naW5nIGFueSBh
dmFpbGlhYmxlIHBlcmlwaGVyYWwoaS5lIGdwaW8pIGZyb20gZWFjaAo+IHN5c3RlbSBhdCB0aGUg
Y2FsbGJhY2tzIGFuZCBoYXZlIGEgbG9naWMgYW5hbHl6ZXIgbWVhc3VyaW5nIGFuZCByZXBvcnRp
bmcKPiB0aW1lIGRlbGF5LgpUaGFuayB5b3UgdmVyeSBtdWNoIEFyaXMgZm9yIHRoaXMgaW5mb3Jt
YXRpb24uCkkgYW0gZmFpcmx5IG5ldyB0byBzb3VuZCBzdWIgc3lzdGVtLCBJ4oCZbSBnbGFkIGlm
IHlvdSBjYW4gcG9pbnQgbWUgb24KdGhlIGNhbGxiYWNrcy4KCkRvZXMgdGhlIHNvdW5kIGRyaXZl
ciB3aWxsIGJlIG5vdGlmaWVkIGFwbGF5XGFyZWNvcmQgb3BlbiB2aWEK4oCcc25kX3h4eF9vcGVu
KHN0cnVjdCBzbmRfcGNtX3N1YnN0ZWFtICpzdWJzdHJlYW0p4oCdIGNhbGxiYWNrPwpXaGljaCBj
YWxsYmFja3Mgb2Ygc291bmQgZHJpdmVyIHdpbGwgdGVsbCB3aGVuIGl0IHJlY2VpdmVkIGZpcnN0
IGFuZApsYXN0IGF1ZGlvIGZyYW1lc1xzYW1wbGVzPwoKCj4KPiBCZXN0IHJlZ2FyZHMsCj4KPiBB
cmlzCj4KPiBPbiBGcmksIE1heSAxOCwgMjAxOCBhdCAzOjM3IFBNLCBNdW5pIFNla2hhciA8bXVu
aXNla2hhcnJtc0BnbWFpbC5jb20+Cj4gd3JvdGU6Cj4+Cj4+IFsgUGxlYXNlIGtlZXAgbWUgaW4g
Q0MgYXMgSSdtIG5vdCBzdWJzY3JpYmVkIHRvIHRoZSBsaXN0XQo+Pgo+PiBIaSBBbGwsCj4+Cj4+
IEkgYW0gdHJ5aW5nIHRvIGNoYXJhY3Rlcml6ZSB0aGUgYXVkaW8gc3luY2hyb25pemF0aW9uIGJl
dHdlZW4gdHdvCj4+IHN5c3RlbXMuIFRoZXJlIGlzIGEgbWVjaGFuaXNtIHRvIHJvdXRlIGF1ZGlv
IGJldHdlZW4gdHdvIHN5c3RlbXMsIHdlCj4+IHJ1biDigJhhcGxheeKAmSBhdCBvbmUgc3lzdGVt
IGFuZCDigJhhcmVjb3Jk4oCZIGluIG90aGVyIHN5c3RlbS4KPj4KPj4gV2UgbmVlZCB0byBtZWFz
dXJlIHRoZSB0aW1lIGRpZmZlcmVuY2Ugd2hlbiBhdWRpbyBzYW1wbGUgaXMgb3V0IGF0IG9uZQo+
PiBwb3J0IGFuZCBhcnJpdmluZyBhdCBhbm90aGVyIHBvcnQgaW4gZGlmZmVyZW50IHN5c3RlbS4K
Pj4KPj4gSSBwbGFuIHRvIGFkZCBwcmludGvigJlzIGluIOKAnHN0cnVjdCBzbmRfcGNtX29wc+KA
nSBjYWxsIGJhY2tzLCBidXQgZG9lcwo+PiB0aGVzZSBjYWxsIGJhY2tzIHRlbGxzIHdoZW4gaXQg
cmVjZWl2ZWQgZmlyc3QgYW5kIGxhc3QgYXVkaW8KPj4gZnJhbWVzXHNhbXBsZXM/Cj4+Cj4+IE9y
IGVsc2UgcGxlYXNlIHN1Z2dlc3QgYW55IG90aGVyIGJlc3QgbWV0aG9kLgo+Pgo+Pgo+PiAtLQo+
PiBUaGFua3MsCj4+IFNla2hhcgo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+PiBLZXJuZWxuZXdiaWVzIG1haWxpbmcgbGlzdAo+PiBLZXJuZWxu
ZXdiaWVzQGtlcm5lbG5ld2JpZXMub3JnCj4+IGh0dHBzOi8vbGlzdHMua2VybmVsbmV3Ymllcy5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXJuZWxuZXdiaWVzCj4KPgoKCgotLSAKVGhhbmtzLApTZWto
YXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
