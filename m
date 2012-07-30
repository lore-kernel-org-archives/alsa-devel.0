From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500
	Device Tree
Date: Mon, 30 Jul 2012 15:26:58 +0100
Message-ID: <501699B2.7030002@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
 <20120729205001.GK4384@opensource.wolfsonmicro.com>
 <5016389B.4020003@linaro.org>
 <20120730134054.GC4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D43D92652FA
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 16:26:59 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1053971eek.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 07:27:02 -0700 (PDT)
In-Reply-To: <20120730134054.GC4468@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMzAvMDcvMTIgMTQ6NDAsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMzAsIDIw
MTIgYXQgMDg6MzI6NDNBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBPbiAyOS8wNy8xMiAy
MTo1MCwgTWFyayBCcm93biB3cm90ZToKPj4+IE9uIEZyaSwgSnVsIDI3LCAyMDEyIGF0IDAxOjQ1
OjU3UE0gKzAxMDAsIExlZSBKb25lcyB3cm90ZToKPgo+Pj4+ICsJCXBjbTogdXg1MDAtcGNtIHsK
Pj4+PiArCQkJY29tcGF0aWJsZSA9ICJzdGVyaWNzc29uLHV4NTAwLXBjbSI7Cj4+Pj4gKwkJfTsK
Pj4+PiArCj4KPj4+IE9uZSBvZiB0d28gdGhpbmdzIGlzIHdyb25nIGhlcmUuICBFaXRoZXIgeW91
J3ZlIG5vdCBwcm92aWRlZCBhbnkKPj4+IGluZm9ybWF0aW9uIGFib3V0IHRoZSBoYXJkd2FyZSBz
byB0aGUgZHJpdmVyIHdvbid0IGJlIGFibGUgdG8gd29yayBvdXQKPj4+IHdoYXQgdG8gdGFsayB0
byBvciB5b3UndmUgbm90IHByb3ZpZGVkIGFueSBkYXRhIHNvIHlvdSdyZSByZWdpc3RlcmluZyBh
Cj4+PiBwdXJlbHkgdmlydHVhbCBMaW51eC1pbnRlcm5hbCBkZXZpY2UgdmlhIHRoZSBkZXZpY2Ug
dHJlZS4KPgo+Pj4gT25jZSBtb3JlLCB0aGUgaWRlYSBoZXJlIGlzIHRvIGRlc2NyaWJlIHRoZSBo
YXJkd2FyZSBub3QgdG8gZHVtcCBMaW51eCdzCj4+PiBpbnRlcm5hbCBkYXRhIHN0cnVjdHVyZXMg
aW50byB0aGUgZGV2aWNlIHRyZWUuCj4KPj4gV2UgdXNlIGl0IHJlZ2lzdGVyIHRoZSBkcml2ZXIg
Zm9yIHByb2JlKClpbmcuIEluIHRoZSBzYW1lIHdheSB3ZSBkbwo+PiBmb3IgdGhlIFBNVSBhbmQg
UmVndWxhdG9ycy4gQWxsIHRocmVlIG9mIHdoaWNoIGFjdHVhbGx5IGJlbG9uZyB0byBhCj4+IGRp
ZmZlcmVudCBoYXJkd2FyZSBibG9jay4gRG8geW91IGtub3cgb2YgYSBiZXR0ZXIgd2F5IHRvIHJl
Z2lzdGVyCj4+IHRob3NlIGRldmljZXM/Cj4KPiBZb3UndmUgbm90IGlkZW50aWZpZWQgd2hpY2gg
b2YgdGhlIHR3byBjYXNlcyBhYm92ZSB3ZSdyZSBpbi4uLiAgYXNzdW1pbmcKPiBpdCdzIGEgdmly
dGFsIGRldmljZSBsb29rIGF0IGhvdyB0aGUgRFQgYmluZGluZ3MgZm9yIHRoZSBvdGhlciBwbGF0
Zm9ybXMKPiBhcmUgZG9pbmcgdGhpbmdzLgoKSSB0aG91Z2h0IGl0IHdvdWxkIGhhdmUgYmVlbiBv
YnZpb3VzIGJ5IG15IHJlc3BvbnNlLiBUaGUgUE1VIHNlZW1zIHRvIGJlIAphIHZpcnR1YWwgZGV2
aWNlIHdpdGggbm8gcmVnaXN0ZXJzIG9yIElSUXMuCgpJJ3ZlIGZvdW5kIGEgRFQgd2hpY2ggc2Vl
bXMgdG8gZG8gaXQgaW4gdGhlIHNhbWUgd2F5IGFzIEkgZG8gCidhcmNoL3Bvd2VycGMvYm9vdC9k
dHMvcDEwMjJkcy5kdHMnLCBidXQgc29tZSBvdGhlcnMgY2FsbCBQQ00gCnJlZ2lzdHJhdGlvbiBm
cm9tIHRoZSBDUFUtc2lkZSBEQUkgcHJvYmUoKS4gV291bGQgdGhhdCBiZSB5b3VyIHByZWZlcmVu
Y2U/CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApM
aW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExp
bmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
