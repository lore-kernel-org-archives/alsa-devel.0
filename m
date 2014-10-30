From: dE <de.techno@gmail.com>
Subject: Re: Selecting correct input device port.
Date: Thu, 30 Oct 2014 15:01:54 +0530
Message-ID: <5452058A.6080505@gmail.com>
References: <544F1B26.2070502@gmail.com>	<s5h38a7e39x.wl-tiwai@suse.de>	<5451C09C.80606@gmail.com>
 <CAN8cciY1aRUoRYoDP5ticMz+ij9c4e=mq53q9TZ_V=Jqi=19rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 58C052605E3
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 10:32:23 +0100 (CET)
Received: by mail-pd0-f178.google.com with SMTP id fp1so4847905pdb.9
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 02:32:21 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.69.53])
 by mx.google.com with ESMTPSA id km5sm6588771pdb.18.2014.10.30.02.32.18
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 30 Oct 2014 02:32:20 -0700 (PDT)
In-Reply-To: <CAN8cciY1aRUoRYoDP5ticMz+ij9c4e=mq53q9TZ_V=Jqi=19rw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMTAvMzAvMTQgMTE6MTIsIFJheW1vbmQgWWF1IHdyb3RlOgo+Cj4KPiAyMDE0LTEwLTMwIOS4
i+WNiDEyOjM4IOaWvCAiZEUiIDxkZS50ZWNobm9AZ21haWwuY29tIAo+IDxtYWlsdG86ZGUudGVj
aG5vQGdtYWlsLmNvbT4+IOWvq+mBk++8mgo+ID4KPiA+IE9uIDEwLzI5LzE0IDEzOjA2LCBUYWth
c2hpIEl3YWkgd3JvdGU6Cj4gPj4KPiA+PiBBdCBUdWUsIDI4IE9jdCAyMDE0IDA5OjU3OjE4ICsw
NTMwLAo+ID4+IGRFIHdyb3RlOgo+ID4+Pgo+ID4+Pgo+ID4+PiBBcyBJIGxlYXJuJ3QgaW4gdGhp
cyBtYWlsbmcgbGlzdCwgYSBkZXZpY2UgY2FuIHR5cGljYWxseSBoYW5kbGUgCj4gb25seSBvbmUK
PiA+Pj4gc3RyZWFtIGF0IGEgdGltZSB1bmxlc3MgaXQgc3VwcG9ydHMgaGFyZHdhcmUgbWl4aW5n
IHdoaWNoJ3MgCj4gZXhwb3NlZCB2aWEKPiA+Pj4gc3ViZGV2aWNlcyBpbiBBTFNBCj4gPj4+Cj4g
Pj4+IFdoYXQgZG9lcyBzdWJkZXZpY2UgbWVhbiBmb3IgaW5wdXQgZGV2aWNlPwo+ID4+Cj4gPj4K
PiA+PiBXaGVuIGEgZGV2aWNlIGNhbiBkbyBtdWx0aXBsZXhpbmcsIHRoZSBkcml2ZXIgY2FuIGdp
dmUgbXVsdGlwbGUKPiA+PiBzdWJzdHJlYW1zICg9IHN1YmRldmljZXMpLgo+ID4+Cj4gPj4+IERv
IHRoZXkgbWFyayBwaHlzaWNhbCBwb3J0cwo+ID4+PiBmb3IgaW5wdXQ/IElmIG5vdCBob3cgZG8g
SSByZWNvcmQgZnJvbSBhIHNwZWNpZmljIGlucHV0IHBvcnQ/Cj4gPj4KPiA+Pgo+ID4+IFlvdSBj
YW4gcGFzcyB0aGUgc3ViZGV2aWNlIG51bWJlciBleHBsaWNpdHkuICBJdCdzIC0xIGFzIGRlZmF1
bHQsCj4gPj4gd2hpY2ggbWVhbnMgdG8gc2VsZWN0IHRoZSBuZXh0IGZyZWUgb25lLgo+ID4+Cj4g
Pj4+IElzIGl0Cj4gPj4+IGF1dG9tYXRpY2FsbHkgc2VsZWN0ZWQgYnkgdGhlIGNhcmQ/Cj4gPj4+
Cj4gPj4+IEFuZCB3aGF0J3MgJ2lucHV0IHNvdXJjZScgaW4gQUxTQSBtaXhlcj8KPiA+Pgo+ID4+
Cj4gPj4gSXQncyB1c3VhbGx5IGEgTVVYIHRvIHNlbGVjdCB0aGUgaW5wdXQgc291cmNlLCBlLmcu
IGxpbmUgaW4gb3IgbWljLgo+ID4+Cj4gPj4KPiA+Cj4gPiBJbnB1dCBzb3VyY2UgZm9yIHNpbmds
ZSBzdWJkZXZpY2UgcmlnaHQ/IEkndmUgMyBzdWIgZGV2aWNlLCBkb2VzIGl0IAo+IGhhdmUgdG8g
ZG8gYW55dGhpbmcgd2l0aCB0aGUgZmFjdCB0aGF0IEkndmUgMyBpbnB1dCBzb3VyY2UgaW4gCj4g
YWxzYW1peGVyPyBEbyB0aGUgMyBpbnB1dCBzb3VyY2UgbWFyayAzIGRpZmZlcmVudCBzdWJkZXZp
Y2VzPwo+Cj4gU28gZmFyLCBvbmx5IHRob3NlIDEwIGNoYW5uZWwgaGRhIGNvZGVjcyBoYXZlIHRo
cmVlIEFEQwo+Cj4gRHVlIHRvIHJlY2VudCBjaGFuZ2UgaW4gc25kLWhkYS1pbnRlbCwgaWYgeW91
ciBkZXNrdG9wIHByZXZpb3VzbHkgaGFkIAo+IHRocmVlIHN1YmRldmljZXMsIHRoZSBuZXcgZHJp
dmVyIGNyZWF0ZSBhbmFsb2cgY2FwdHVyZSBkZXZpY2Ugd2l0aCBvbmUgCj4gc3ViZGV2aWNlIGFu
ZCBhbHQgYW5hbG9nIGNhcHR1cmUgd2l0aCB0d28gc3ViZGV2aWNlcwo+CgpUaGFua3MgZm9yIGNs
YXJpZnlpbmcgZXZlcnlvbmUhCgpMb29rcyBsaWtlIG15IG1vYm8gaXMgYmFkLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
