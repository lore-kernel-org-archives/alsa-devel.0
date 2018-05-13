From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ALSA: hda: Add Lenovo C50 All in one to
 the power_save blacklist
Date: Sun, 13 May 2018 14:39:35 +0100
Message-ID: <59da0f50-270b-3a92-48ca-55e6d78856dc@redhat.com>
References: <20180508072746.10798-1-hdegoede@redhat.com>
 <s5htvrc8219.wl-tiwai@suse.de>
 <867f071a-2616-b0e6-baed-b7eff69a76c9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F8E6267677
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:39:39 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id j5-v6so10556871wme.5
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 06:39:39 -0700 (PDT)
In-Reply-To: <867f071a-2616-b0e6-baed-b7eff69a76c9@redhat.com>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAwNS8xMy8yMDE4IDA4OjIwIEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+IEhpIFRh
a2FzaGksCj4gCj4gT24gMDUvMTMvMjAxOCAwOTowOSBBTSwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+
PiBPbiBUdWUsIDA4IE1heSAyMDE4IDA5OjI3OjQ2ICswMjAwLAo+PiBIYW5zIGRlIEdvZWRlIHdy
b3RlOgo+Pj4KPj4+IFBvd2VyLXNhdmluZyBpcyBjYXVzaW5nIGxvdWQgcGxvcHMgb24gdGhlIExl
bm92byBDNTAgQWxsIGluIG9uZSwgYWRkIGl0Cj4+PiB0byB0aGUgYmxhY2tsaXN0Lgo+Pj4KPj4+
IEJ1Z0xpbms6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTU3
Mjk3NQo+Pj4gU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNv
bT4KPj4KPj4gQmVmb3JlIGFkZGluZyB0byBibGFja2xpc3QsIGNvdWxkIHlvdSB0cnkgc29tZSB1
c3VhbCBzdXNwZWN0cz8KPj4gRm9yIExlbm92bywgeW91IGNhbiB0cnkgYXQgZmlyc3QgdG8gcGFz
cwo+PiDCoMKgIG1vZGVsPSx0cHQ0NDAKPj4gdG8gc25kLWhkYS1pbnRlbCBtb2R1bGUuCj4+Cj4+
ICh0aGUgZmlyc3QgY29tbWEgaXMgbm8gdHlwbyBidXQgdG8gcGFzcyB0aGUgbW9kZWwgbmFtZSB0
byB0aGUgc2Vjb25kCj4+IMKgIGNvbnRyb2xsZXIgZm9yIFJlYWx0ZWsuKQo+Pgo+PiBUaGUgYWJv
dmUgd2lsbCBhZGQgc29tZSBib2d1cyBkb2NrIGphY2tzLCBzbyBpdCdzIG5vIHNvbHV0aW9uIGJ1
dCB0bwo+PiBqdXN0IHRvIHRlc3Qgd2hldGhlciBpdCBhdm9pZHMgdGhlIGNsaWNraW5nIG5vaXNl
Lgo+IAo+IFN1cmUsIG5vdGUgSSdtIGp1c3QgZm9yd2FyZGluZyB0aGVzZSBidWdzIGZyb20gRmVk
b3JhIHJlcG9ydGVycywKPiBtb3JlIG9mdGVuIHRoZW4gbm90IEkgZG9uJ3QgaGF2ZSBhY2Nlc3Mg
dG8gdGhlIGhhcmR3YXJlIG15c2VsZi4KPiAKPiBJIGFsd2F5cyBhZGQgYSBCdWdMaW5rIHRhZyB0
byB0aGUgYnVnLCBzbyBwZXJoYXBzIG5leHQgdGltZSB5b3UKPiBjYW4gcmVhY2ggb3V0IHRvIHRo
ZSByZXBvcnRlciBkaXJlY3RseSA/IEkndmUgZm9yd2FyZGVkIHlvdXIKPiByZXF1ZXN0IHRoaXMg
dGltZS4KPiAKPiBJIGFsc28gYWx3YXlzIGFzayBmb3IgYWxzYS1pbmZvLnNoIG91dHB1dCwgc28g
Zm9sbG93aW5nIHRoZSBCdWdMaW5rCj4gd2lsbCBhbHNvIGdpdmUgeW91IGFjY2VzcyB0byB0aGF0
LgoKU28gdGhlIHVzZXIganVzdCByZXBsaWVkOgoKIlN0aWxsIGhlYXIgbG91ZCBwb3BzIHdpdGgg
NC4xNi43LTMwMC5mYzI4Lng4Nl82NCB1c2luZwpzbmRfaGRhX2ludGVsLm1vZGVsPSx0cHQ0NDAg
KGNvbmZpcm1lZCBlbmFibGVkIGluIHN5c2ZzKS4KCkkgdGhpbmsgaW4gc29tZSBzZW5zZSB0aGlz
IGlzIGp1c3QgJ3BvcHB5JyBoYXJkd2FyZSAtLSBpdCdzIGFsd2F5cyBlbWl0dGVkIGEKcG9wICh0
aG91Z2ggbm90IGFzIGxvdWQgYXMgdGhlc2UpIHdoZW4gdGhlIHNvdW5kIGNhcmQgaXMgaW5pdGlh
bGlzZWQsIGV2ZW4KdW5kZXIgV2luZG93cy4iCgpSZWdhcmRzLAoKSGFucwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
