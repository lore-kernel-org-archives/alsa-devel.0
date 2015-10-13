From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: 'BATCH flag for USB' and 'ALSA Core Challenges'
Date: Tue, 13 Oct 2015 19:44:39 +0500
Message-ID: <561D18D7.1040906@gmail.com>
References: <1444657786.2528.78.camel@loki> <561D10AD.7010800@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 542BE261A76
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:38:43 +0200 (CEST)
Received: by lbcao8 with SMTP id ao8so22793009lbc.3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 07:38:42 -0700 (PDT)
In-Reply-To: <561D10AD.7010800@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

MTMuMTAuMjAxNSAxOTowOSwgVGFrYXNoaSBTYWthbW90byB3cm90ZToKPiBIaSwKPgo+IChJZiBJ
IHdlcmUgaW4gwrEwMjAw44CBSSB3b3VsZCBoYXZlIGpvaW5lZCBpbiB0aGUgbWVldGluZy4uLikK
Pgo+IFRoZXJlJ3JlIHNvbWUgaW50ZXJlc3RpbmcgaXNzdWVzIGluIHRoZSBtaW51dGVzLiBXb3Vs
ZCBJIHJlcXVlc3Qgc29tZW9uZQo+IG1vcmUgZXhwbGFpbmF0aW9uIGFib3V0IGl0Pwo+Cj4+IEJB
VENIIGZsYWcgZm9yIFVTQjogQXJ1bi4KPj4gPT09PT09PT09PT09PT09PT09PT09PT09PQo+PiAg
IC0gRmxhZyBkb2VzIG5vdCByZXNwb25kIHRvIHJlYWxpdHksIGxldHMgZGVwcmVjYXRlIGl0LiBu
byB1c2Vycy4KPj4gICAtIER5bGFuOiBuZWVkIHRvIGtub3cgdHJhbnNmZXIgc2l6ZSBmb3IgQ1JB
UyAodXNlcyBleHRyYSBzYW1wbGVzIGZvcgo+PiBidWZmZXJpbmcpLgo+PiAgIC0gQkFUQ0ggZmxh
ZyBtZWFucyBwZXJpb2Qgc2l6ZSB0cmFuc2ZlcnMsIGFwcGxpY2F0aW9ucyB0aGF0IHVzZSBuZXcK
Pj4gZ3JhbnVsYXJpdHkgQVBJIGNhbiBpZ25vcmUgYmF0Y2ggZmxhZy4gUGllcnJlOiB0byBpbXBs
ZW1lbnQuCj4gVGhlIGZpcnN0IGl0ZW0gc2FpZCAnQkFUQ0ggZmxhZyBzaG91bGQgYmUgZGVwcmVj
YXRlZCcsIHdoaWxlCj4gQkxPQ0tfVFJBTlNGRVIgZmxhZyBpcyBub3QgbWVudGlvbmVkLiBBcmUg
dGhlcmUgc29tZSBkaXNjdXNzaW9ucyBhYm91dAo+IHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRo
ZXNlIHR3byBmbGFncz8KClRoZXJlIGlzIG5vIGNvbnNwaXJhY3kgaGVyZSwganVzdCBpbmFjY3Vy
YXRlbHktd3JpdHRlbiBtaW51dGVzLiBUaGUgCnByb3Bvc2FsIHRvIGRlcHJlY2F0ZSB3YXMgYWJv
dXQgdGhlIEJMT0NLX1RSQU5TRkVSIGZsYWcgKGJlY2F1c2UgCmN1cnJlbnRseSBpdCBtZWFucyBh
YnNvbHV0ZWx5IG90aGluZyBhbmQgaGFzIG5vIHVzZXJzKSwgYWx0aG91Z2ggSSAKc3VwcG9ydCBk
ZXByZWNhdGlvbiBvZiB0aGUgQkFUQ0ggZmxhZyB0b28uIFBsZWFzZSBzZWUgdGhpcyBlbWFpbCB0
aGF0IApleHBsYWlucyB0aGUgaW50ZW5kZWQgbWVhbmluZyBvZiB0aGUgZmxhZ3M6CgpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIwMTUtSnVuZS8w
OTM3NTAuaHRtbAoKPgo+IEkgdGhpbmsgdGhlIEFQSXMgc3VwcG9zZSB0aGF0IHRoZSBudW1iZXIg
b2YgUENNIGZyYW1lcyBpbiBvbmUKPiB0cmFuc2ZlcnJpbmcgaXMgdGhlIHNhbWUgYXMgdGhlIG51
bWJlciBvZiBQQ00gZnJhbWVzIGluIG9uZSBwZXJpb2Qgb2YKPiBidWZmZXIuIFBDTSBkZXZpY2Ug
ZHJpdmVyIGRldmVsb3BlcnMgbXVzdCBhbHdheXMgc2F0aXNmeSB0aGlzIHByaW5jaXBsZT8KPiBP
ciB0aGUgQVBJcyBhbGxvdyB0aGVtIHRvIGltcGxlbWVudCBzdWNoIGRpZmZlcmVuY2VzIGFuZCBw
cmVzZW50IHByb3Blcgo+IHZhbHVlIHRvIHVzZXJzcGFjZT8KClRoZSBpbnRlbnRpb24gaXMgdG8g
cHJvdmlkZSBkcml2ZXIgZGV2ZWxvcGVycyB0aGUgbWVhbnMgdG8gZXhwcmVzcyB0aGUgCnNpdHVh
dGlvbiB3aXRoIHRoZSB0cmFuc2ZlciBzaXplIGFuZCBwb2ludGVyIGdyYW51bGFyaXR5IGluIGEg
dXNlZnVsIAptYW5uZXIsIGFuZCB0d28gYm9vbGVhbiBmbGFncyBqdXN0IGRvbid0IGN1dCBpdC4g
U28gc29tZSBuZXcgQVBJIGlzIG5lZWRlZC4KCi0tIApBbGV4YW5kZXIgRS4gUGF0cmFrb3YKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
