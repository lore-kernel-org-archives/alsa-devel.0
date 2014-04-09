From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: move alc892 to patch_alc882
Date: Wed, 9 Apr 2014 15:24:19 +0800
Message-ID: <CAN8cciZ_Ju7CVXngsapZUZd8TQzfdvViEx-xmRT0ZAS8cCd60Q@mail.gmail.com>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw>
 <CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com>
 <s5hsipqdh4n.wl%tiwai@suse.de>
 <5C8998C298284925B0366DDAC8B6717F@realtek.com.tw>
 <s5hmwfxmt5o.wl%tiwai@suse.de>
 <A1BA38FF1354405FAD7D43DEC4C1DEC8@realtek.com.tw>
 <CAN8cciZDRX5ocMsQY2HEps5kBHyYytzku5KMRi2qJE7Ok0L5Bg@mail.gmail.com>
 <CD6BB756DB7E4CE5BE9458B1523DBC82@realtek.com.tw>
 <CAN8cciaUMQgc_gq7Pm8HfU41PcQUDjMDwAhMQ5DfWXPO0Hkb4g@mail.gmail.com>
 <98B9BF421F8C483CA0DB8980D79BE86E@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
 [209.85.216.48])
 by alsa0.perex.cz (Postfix) with ESMTP id E960C261606
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 09:24:20 +0200 (CEST)
Received: by mail-qa0-f48.google.com with SMTP id s7so1557259qap.35
 for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2014 00:24:19 -0700 (PDT)
In-Reply-To: <98B9BF421F8C483CA0DB8980D79BE86E@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

MjAxNC00LTkg5LiL5Y2IMjozMCDmlrwgIkthaWxhbmciIDxrYWlsYW5nQHJlYWx0ZWsuY29tPiDl
r6vpgZPvvJoKPgo+IEhpIFJheW1vbmQsCj4KPiBZb3VyIG11bHRpLXN0cmVhbWluZyBtZWFucyBt
dXRpIGNoYW5uZWwgb3V0IG9yIHNlcGFyYXRlIG91dHB1dCBhdCB0aGUKc2FtZSB0aW1lLgoKU2Vl
bSBtb3N0IDYgY2hhbm5lbHMgY29kZWNzIGRvZXMgbm90IHN1cHBvcnQgbXVsdGlzdGVhbWluZyBw
bGF5YmFjawoKVGhlIEFMQzg5MiBwcm92aWRlcyB0ZW4gREFDIGNoYW5uZWxzIHRoYXQgc2ltdWx0
YW5lb3VzbHkgc3VwcG9ydCA3LjEKY2hhbm5lbCBzb3VuZCBwbGF5YmFjaywgcGx1cyAyIGNoYW5u
ZWxzIG9mIGluZGVwZW5kZW50IHN0ZXJlbyBzb3VuZCBvdXRwdXQKKG11bHRpcGxlIHN0cmVhbWlu
ZykgdGhyb3VnaCB0aGUgZnJvbnQgcGFuZWwgc3RlcmVvIG91dHB1dHMKClRoZSBBTEMyMzEgaXMg
YSBIaWdoIERlZmluaXRpb24gQXVkaW8gQ29kZWMgdGhhdCBpbnRlZ3JhdGVzIGEgNC1jaGFubmVs
CkRBQywgNC1jaGFubmVsIEFEQywgYW5kIGEgbW9ubyBhbmQgZmlsdGVyLWxlc3MgQ2xhc3MtRCBT
cGVha2VyIEFtcGxpZmllcgp3aXRoIDJXYXR0IChybXMpIG91dHB1dCBwb3dlci4KClRoZSA0LWNo
YW5uZWwgREFDIGFuZCA0LWNoYW5uZWwgQURDIHN1cHBvcnQgdHdvIGluZGVwZW5kZW50IHN0ZXJl
byBzb3VuZApvdXRwdXRzIGFuZCB0d28gaW5kZXBlbmRlbnQgc3RlcmVvIGlucHV0cyBzaW11bHRh
bmVvdXNseTsgYWxsb3dpbmcgbXVsdGlwbGUKc3RyZWFtaW5nIHBsYXliYWNrIGFuZCBvdXRwdXQg
Zm9yIG11bHRpbWVkaWEgYXBwbGljYXRpb25zIGFuZCB2b2ljZQpjb21tdW5pY2F0aW9uLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
