From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Cannot combine audio devices with more than 64
	channels
Date: Sat, 28 Jan 2017 08:14:52 +0900
Message-ID: <f36e82bb-76a0-007d-f77c-faadf282864c@sakamocchi.jp>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
 <CAKw=HF1H6BCrvgm_8eL3f-L0yoKrqTqBib0kE4z0o73yzGqPKg@mail.gmail.com>
 <s5hd1f8hcc7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 12AEF267B7C
 for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2017 00:14:58 +0100 (CET)
In-Reply-To: <s5hd1f8hcc7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, =?UTF-8?B?SsO2cmcgTcO8bGxlcg==?= <joerg.mueller7744@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

T24gSmFuIDI3IDIwMTcgMjI6MTYsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBGcmksIDI3IEph
biAyMDE3IDE0OjAzOjE2ICswMTAwLAo+IErDtnJnIE3DvGxsZXIgd3JvdGU6Cj4+Cj4+IFRoYW5r
cyBmb3IgdGhlIHBhdGNoLCB0aGF0IHdhcyBmYXN0IQo+Pgo+PiBTbyBJIHdhbnQgdG8gYXBwbHkg
dGhhdCBwYXRjaCB0byBteSBzeXN0ZW0gKFVidW50dSBTdHVkaW8gMTQuMDQpLiBIb3cKPj4gZG8g
SSBwcm9jZWVkPyBJIGd1ZXNzLCB0aGUgcGF0Y2ggd29udCBiZSBhdmFpbGFibGUgdmlhIGFwdC1n
ZXQgc29vbiwKPj4gcmlnaHQ/Cj4KPiBJIGhhdmUgbm8gaWRlYSBhYm91dCBVYnVudHUuICBBc2sg
VWJ1bnR1IHBlb3BsZS4KClVidW50dSAxNC4wNCBpcyBvbmUgb2YgTFRTcywgd2hpbGUgZGV2ZWxv
cG1lbnQgZm9yIHRoaXMgcmVsZWFzZSBhbHJlYWR5IApmaW5pc2hlZCB0aHJlZSB5ZWFycyBhZ28u
IEJhc2ljYWxseSwgcGFja2FnZXMgZm9yIHRoZSByZWxlYXNlIGFyZSBub3QgCnVwZGF0ZWQgdW5s
ZXNzIHNvbWUgZXhjZXB0aW9ucy4KCkluIHlvdXIgY2FzZSwgeW91IGNhbiBnZW5lcmF0ZSBhbHNh
LWxpYiByZWxhdGVkIHBhY2thZ2VzIHdpdGggdGhlIHBhdGNoIApieSB5b3VyIG93bi4gQnV0IG5v
IG9uZSBjYW4gY2FyZSBvZiB5b3VyIHBhY2thZ2VzIGFuZCB5b3UgbmVlZCB0byBkbyAKZXZlcnl0
aGluZyB0byBiZSByZXF1aXJlZC47IGUuZy4gZXZlbiBpZiB5b3UgZW5jb3VudGVyIGlzc3VlcyBm
cm9tIHRoZSAKZ2VuZXJhdGVkIHBhY2thZ2VzLCBubyBvbmUgY2FuIGhlbHAgeW91LgoKJCBzdWRv
IGFwdC1nZXQgaW5zdGFsbCBidWlsZC1lc3NlbnRpYWxzIGRldnNjcmlwdHMKJCBzdWRvIGFwdC1n
ZXQgYnVpbGQtZGVwIGFsc2EtbGliCiQgY2QgL3RtcAokIGFwdC1nZXQgc291cmNlIGFsc2EtbGli
CiQgY2QgYWxzYS1saWItKgooYXBwbHkgdGhlIHBhdGNoKQokIGRwa2ctYnVpbGRwYWNrYWdlIC1y
ZmFrZXJvb3QgLXVjIC1iCihwYWNrYWdlcyBhcmUgZ2VuZXJhdGVkIGluIGhpZ2hlciBkaXJlY3Rv
cnkgYnkgb25lIGxldmVsKQoKUGVyaGFwcywgdGhlIGFib3ZlIGNvbW1hbmQgbGluZXMgYXJlIG5v
dCBlbm91Z2guIFNvbWUgcGFja2FnZXMgYXJlIHN0aWxsIAptaXNzaW5nIGZvciBwYWNrYWdpbmcu
CgoKUmVnYXJkcwoKVGFrYXNoaSBTYWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
