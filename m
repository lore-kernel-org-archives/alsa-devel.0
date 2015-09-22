From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCS0L7Qu9C60L7Qsg==?=
 <a.volkov@rusbitech.ru>
Subject: Re: [PATCH - alsa-utils 1/1] arecord: Remove only
 regular files
Date: Tue, 22 Sep 2015 17:07:21 +0300
Message-ID: <56016099.30606@rusbitech.ru>
References: <1442840757-5403-1-git-send-email-a.volkov@rusbitech.ru>
 <CACuU-+gX-QnsE_KHwX_55zCZRcKw=V=JvQkuKwvkfNoCDTmL5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.rusbitech.ru (mx.rusbitech.ru [109.74.130.130])
 by alsa0.perex.cz (Postfix) with ESMTP id AFACE262626
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 16:10:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx.rusbitech.ru (Postfix) with ESMTP id 2027E18022E
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 17:10:53 +0300 (MSK)
Received: from mx.rusbitech.ru ([127.0.0.1])
 by localhost (larix.rusbitech.ru [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eTyNwcs53QHE for <alsa-devel@alsa-project.org>;
 Tue, 22 Sep 2015 17:10:52 +0300 (MSK)
In-Reply-To: <CACuU-+gX-QnsE_KHwX_55zCZRcKw=V=JvQkuKwvkfNoCDTmL5g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun@accosted.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MjIuMDkuMjAxNSAxNjoyNCwgQXJ1biBSYWdoYXZhbiDQv9C40YjQtdGCOgo+IE9uIDIxIFNlcHRl
bWJlciAyMDE1IGF0IDE4OjM1LCBBbGV4YW5kZXIgVm9sa292IDxhLnZvbGtvdkBydXNiaXRlY2gu
cnU+IHdyb3RlOgo+PiBhcmVjb3JkIHJlbW92ZXMgYSBmaWxlIGJlZm9yZSB3cml0aW5nIGludG8g
aXQuIEl0J3Mgbm90Cj4+IGFwcHJvcHJpYXRlIGluIHNvbWUgY2FzZXMuIEZvciBleGFtcGxlLCBp
ZiB5b3UgYSBwYXNzCj4+IGEgc3ltbGluayB0byBhIGZpbGUsIHRoZW4gdGhlIHN5bWxpbmsgd2ls
bCBiZSByZW1vdmVkCj4+IHdoaWxlIHRoZSB1c2VyIGV4cGVjdHMgdG8gcmVjb3JkIGludG8gdGhl
IHN5bWxpbmsncyB0YXJnZXQuCj4+IEFub3RoZXIgY2FzZSBpcyByZWNvcmRpbmcgaW50byB0aGUg
ZGV2aWNlIGZpbGUuIFNvbWUKPj4gbW9kZW1zIHByb3ZpZGUgYSB0dHkgZGV2aWNlIGZpbGUgYXMg
YSB2b2ljZSBkZXZpY2UuCj4+IEFuZCBpdCdzIG5vdCBwb3NzaWJsZSB0byB3cml0ZSBpbnRvIGl0
IHVuZGVyIHJvb3Qgd2l0aAo+PiBhcmVjb3JkLCBiZWNhdXNlIGl0IHJlbW92ZXMgdGhlIGRldmlj
ZSBmaWxlLgo+Pgo+PiBTbyBjaGVjayB0aGUgdHlwZSBvZiBhIGZpbGUgYmVmb3JlIHdyaXRpbmcg
aW50byBpdCBhbmQKPj4gcmVtb3ZlIG9ubHkgcmVndWxhciBmaWxlcy4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZGVyIFZvbGtvdiA8YS52b2xrb3ZAcnVzYml0ZWNoLnJ1Pgo+Pgo+PiBkaWZm
IC0tZ2l0IGEvYXBsYXkvYXBsYXkuYyBiL2FwbGF5L2FwbGF5LmMKPj4gaW5kZXggNDU5ZjdkZC4u
MWIyY2RmYyAxMDA2NDQKPj4gLS0tIGEvYXBsYXkvYXBsYXkuYwo+PiArKysgYi9hcGxheS9hcGxh
eS5jCj4+IEBAIC0yOTI5LDYgKzI5MjksNyBAQCBzdGF0aWMgdm9pZCBjYXB0dXJlKGNoYXIgKm9y
aWdfbmFtZSkKPj4gICAgICAgICAgY2hhciAqbmFtZSA9IG9yaWdfbmFtZTsgLyogY3VycmVudCBm
aWxlbmFtZSAqLwo+PiAgICAgICAgICBjaGFyIG5hbWVidWZbUEFUSF9NQVgrMV07Cj4+ICAgICAg
ICAgIG9mZjY0X3QgY291bnQsIHJlc3Q7ICAgICAgICAgICAgLyogbnVtYmVyIG9mIGJ5dGVzIHRv
IGNhcHR1cmUgKi8KPj4gKyAgICAgICBzdHJ1Y3Qgc3RhdCBzdGF0YnVmOwo+Pgo+PiAgICAgICAg
ICAvKiBnZXQgbnVtYmVyIG9mIGJ5dGVzIHRvIGNhcHR1cmUgKi8KPj4gICAgICAgICAgY291bnQg
PSBjYWxjX2NvdW50KCk7Cj4+IEBAIC0yOTczLDcgKzI5NzQsMTAgQEAgc3RhdGljIHZvaWQgY2Fw
dHVyZShjaGFyICpvcmlnX25hbWUpCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4+Cj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBvcGVuIGEgbmV3IGZpbGUgKi8KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgcmVtb3ZlKG5hbWUpOwo+PiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIWxzdGF0KG5hbWUsICZzdGF0YnVmKSkgewo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChTX0lTUkVHKHN0YXRidWYuc3RfbW9kZSkpCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZW1vdmUobmFtZSk7Cj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIH0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGZkID0gc2FmZV9vcGVuKG5h
bWUpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZkIDwgMCkgewo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwZXJyb3IobmFtZSk7Cj4gV291bGQgaXQgd29yayB0
byBqdXN0IG9wZW4gd2l0aCBPX1RSVU5DPwo+Cj4gLS0gQXJ1bgpJIGd1ZXNzIHRoYXQgInJlbW92
ZSIgaXMgdXNlZCBoZXJlIHRvIGV4Y2x1ZGUgbXV0dWFsIGFjY2VzcyB0byB0aGUgZmlsZS4KV2Ug
Y2FuIHJlY29yZCB0byB0aGUgY3JlYXRlZCBmaWxlIHdoaWxlIHNvbWUgcHJvZ3JhbSBtYXkgcmVh
ZCB0aGUgCnJlbW92ZWQgZmlsZS4KVXNpbmcgT19UUlVOQyB3aWxsIGJyZWFrIHRoaXMgdXNlIGNh
c2UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
