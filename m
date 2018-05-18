From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: sound: latency and synchronization measurements
Date: Fri, 18 May 2018 19:53:46 +0530
Message-ID: <CAHhAz+gm80xM700urQqxR1k16sAvgOT2sPOQGpnzw4NaOwhA7g@mail.gmail.com>
References: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
 <20180518131259.GB10497@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F40267046
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 16:23:47 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id n1-v6so9289417otf.7
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 07:23:47 -0700 (PDT)
In-Reply-To: <20180518131259.GB10497@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <greg@kroah.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBNYXkgMTgsIDIwMTggYXQgNjo0MiBQTSwgR3JlZyBLSCA8Z3JlZ0Brcm9haC5jb20+
IHdyb3RlOgo+IE9uIEZyaSwgTWF5IDE4LCAyMDE4IGF0IDA2OjA3OjI5UE0gKzA1MzAsIE11bmkg
U2VraGFyIHdyb3RlOgo+PiBbIFBsZWFzZSBrZWVwIG1lIGluIENDIGFzIEknbSBub3Qgc3Vic2Ny
aWJlZCB0byB0aGUgbGlzdF0KPj4KPj4gSGkgQWxsLAo+Pgo+PiBJIGFtIHRyeWluZyB0byBjaGFy
YWN0ZXJpemUgdGhlIGF1ZGlvIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuIHR3bwo+PiBzeXN0ZW1z
LiBUaGVyZSBpcyBhIG1lY2hhbmlzbSB0byByb3V0ZSBhdWRpbyBiZXR3ZWVuIHR3byBzeXN0ZW1z
LCB3ZQo+PiBydW4g4oCYYXBsYXnigJkgYXQgb25lIHN5c3RlbSBhbmQg4oCYYXJlY29yZOKAmSBp
biBvdGhlciBzeXN0ZW0uCj4+Cj4+IFdlIG5lZWQgdG8gbWVhc3VyZSB0aGUgdGltZSBkaWZmZXJl
bmNlIHdoZW4gYXVkaW8gc2FtcGxlIGlzIG91dCBhdCBvbmUKPj4gcG9ydCBhbmQgYXJyaXZpbmcg
YXQgYW5vdGhlciBwb3J0IGluIGRpZmZlcmVudCBzeXN0ZW0uCj4+Cj4+IEkgcGxhbiB0byBhZGQg
cHJpbnRr4oCZcyBpbiDigJxzdHJ1Y3Qgc25kX3BjbV9vcHPigJ0gY2FsbCBiYWNrcywgYnV0IGRv
ZXMKPj4gdGhlc2UgY2FsbCBiYWNrcyB0ZWxscyB3aGVuIGl0IHJlY2VpdmVkIGZpcnN0IGFuZCBs
YXN0IGF1ZGlvCj4+IGZyYW1lc1xzYW1wbGVzPwo+Pgo+PiBPciBlbHNlIHBsZWFzZSBzdWdnZXN0
IGFueSBvdGhlciBiZXN0IG1ldGhvZC4KPgo+IEZpcnN0IG9mZiB5b3UgbmVlZCBhICJzaGFyZWQg
dGltZXIvY2xvY2siIGJldHdlZW4gdGhlIHR3byBzeXN0ZW1zIGluCj4gb3JkZXIgdG8gaGF2ZSBh
IGNoYW5jZSB0byBkZXRlcm1pbmUgd2hhdCBhY3R1YWxseSBoYXBwZW5zIGhlcmUuICBHb29kCj4g
bHVjayB3aXRoIHRoYXQhICA6KQpZZXMsIHdlIGRvIGhhdmUgdGhlIHNoYXJlZCBjbG9jay4KCj4K
PiBBbHNvLCB0aGVyZSdzIGJlZW4gdG9ucyBvZiByZXNlYXJjaCBpbiB0aGlzIGFyZWEgb3ZlciB0
aGUgeWVhcnMsIHBsZWFzZQo+IGxvb2sgaW50byB0aGF0LCBvZGRzIGFyZSB0aGVzZSBwcm9ibGVt
cyBoYXZlIGJlZW4gc29sdmVkIGFscmVhZHkuICBJCj4ga25vdyBvZiBzZXZlcmFsIGNvbW1lcmNp
YWwgZGV2aWNlcyB0aGF0IGFscmVhZHkgaGFuZGxlIHRoaXMganVzdCBmaW5lLgo+CkNhbiB5b3Ug
cG9pbnQgbWUgc29tZSBpbmZvcm1hdGlvbiBvbiB0aGlzLgoKCj4gYmVzdCBvZiBsdWNrIQo+Cj4g
Z3JlZyBrLWgKCgoKLS0gClRoYW5rcywKU2VraGFyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
