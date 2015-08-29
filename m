From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/25 v2] ALSA: support AMDTP variants
Date: Sat, 29 Aug 2015 15:00:16 +0900
Message-ID: <55E14A70.8000903@sakamocchi.jp>
References: <1440235181-18181-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h4mjqtoq8.wl-tiwai@suse.de> <55D9DFA4.6000601@sakamocchi.jp>
 <s5htwrprykv.wl-tiwai@suse.de> <s5hoahw3pqf.wl-tiwai@suse.de>
 <55DC55CB.1020207@sakamocchi.jp> <s5hr3mrmv7m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BE632605F2
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 08:00:27 +0200 (CEST)
In-Reply-To: <s5hr3mrmv7m.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

T24gMjAxNcOlwrnCtDA4w6bCnMKIMjXDpsKXwqUgMjE6MDMsIFRha2FzaGkgSXdhaSB3cm90ZToK
Pj4gRm9yIGFsbCB0aGF0LCB0aGUgbGFzdCBwYXJ0IG9mIHRoaXMgcGF0Y2hzZXQgaXMgYSBib3Qg
d29yc2UuIEkgY29uY2lkZSAKPj4gaXQsIHNvcnJ5LiBNSURJIGZ1bmN0aW9uYWxpdHkgb2YgVEFT
Q0FNIEZpcmVXaXJlIHNlcmllcyBpcyBlbm91Z2ggCj4+IGNvbXBsaWNhdGVkIHRvIG1lIGFuZCBJ
IGFsd2F5cyBoYXZlIGEgaGVhZGFjaGUgYXQgY29uc2lkZXJpbmcgYWJvdXQgaXMgCj4+ICh0aGVu
IG1ha2Ugc29tZSBlYXN5IG1pc3Rha2VzKS4KPj4KPj4+IEFsc28sIEkgc2VlIHF1aXRlIGEgZmV3
IGNvZGUgZHVwbGljYXRpb25zIGluIHRoZSBzZXJpZXMuICBGb3IgZXhhbXBsZSwKPj4+IFBDTSBy
ZWFkL3dyaXRlL3NpbGVuY2UgbG9vcCBpcyBhbG1vc3QgaWRlbnRpY2FsIGV4Y2VwdCBmb3IgYSBm
ZXcgbGluZXMKPj4+IG9mIGRpZmZlcmVuY2VzIGluc2lkZSB0aGUgbG9vcC4gIERpdHRvIGZvciBN
SURJIGFjY2Vzc29ycy4gIENhbiB0aGV5Cj4+PiBiZSBzaGFyZWQgc29tZWhvdyBiZXR0ZXI/Cj4+
Cj4+IEkgdGhpbmsgeW91IG1lbnRpb24gYWJvdXQgdGhlIGNvZGVzIGluIGRhdGEgYmxvY2sgcHJv
Y2Vzc2luZywgc3VjaCBhcyAKPj4gcmVhZF9wY21fczMyKCkgaW4gc291bmQvZmlyZXdpcmUvYW1k
dHAtYW04MjQuYyAob3JpZ2luYWxseSBpbiBhbWR0cC5jKS4gCj4+IFRoZXNlIGZ1bmN0aW9ucyBh
cmUgY2FsbGVkIGFzIGZyZXF1ZW50bHkgYXMgOCwwMDAgdGltZXMgcGVyIHNlY29uZCwgdGh1cyAK
Pj4gaXQncyBwcmVmZXJyYWJsZSB0byBrZWVwIHRoZSBzaXplIGFzIHNtYWxsIGFzIHBvc3NpYmxl
IGZvciBDUFUgdXNhZ2UuCj4+Cj4+IFdoaWxlLCBlYWNoIGRhdGEgYmxvY2sgcHJvY2Vzc2luZyBp
bmNsdWRlcyBxdWl0ZSBzaW1pbGFyIGNvZGVzLiBJbiB0aGlzIAo+PiBtZWFuaW5nLCB5b3VyIGlk
ZWEgaXMgdmFsaWQsIGluZGVlZC4gQnV0IGN1cnJlbnRseSwgSSBhZGhlcmUgdG8gdGhlIHdheSAK
Pj4gdG8gaW1wbGVtZW50IGRpZmZlcmVudCBkYXRhIGJsb2NrIHByb2Nlc3NpbmcgYXMgd2hhdCB0
aGUgc2hhcGUgaXMuIAo+PiBUaGVyZSdzIG5vIHB1YmxpYyBzcGVjaWZpY2F0aW9uIGFib3V0IGl0
IGFuZCBJIHByZWZlciB0byBrZWVwIHRoZSBjb2RlcyAKPj4gYXMgZWFzeSB0byByZWFkIGFzIHBv
c3NpYmxlLgo+IAo+IFdlbGwsIGlmIHlvdSBwcm92aWRlIHNpbXBsZSBvcHMgbGlrZSB3cml0ZV9z
MzIoKSwgcmVhZF9zMzIoKSwKPiBzaWxlbmNlX3MzMigpLCBldGMsIGFsbCBjb2RlcyBjYW4gYmUg
c2FtZS4gIFRoZSBpbm5lciBsb29wIGNhbGxzIG9uZQo+IG9mIHRoaXMgb3BzLCB3aGljaCByZXR1
cm5zIGEgQkUzMiB2YWx1ZSBvciBjb252ZXJ0IHRvIGEgbmF0aXZlIHZhbHVlLAo+IGV0Yy4gVGhl
IHBlcmZvcm1hbmNlIGNvc3QgYnkgc3VjaCBhIGZ1bmN0aW9uIGNhbGwgaXNuJ3QgdG9vIHRyYWdp
Yy4KCkkgZG9uJ3QgbGlrZSB0byBkaXNjdXNzIHdpdGhvdXQgYWN0dWFsIHBhdGNoZXMsIGZvciB0
aGlzIGtpbmQgb2YgaXNzdWVzLgoKClJlZ2FyZHMKClRha2FzaGkgU2FrYW1vdG8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
