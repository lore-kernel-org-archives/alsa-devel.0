From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: [PATCH] ALSA: emu10k1: fix device names for
	Live!/Audigy1/2/4/E-mu and coding style
Date: Wed, 22 Oct 2008 13:07:51 +0200
Message-ID: <fd3eb9bf0810220407y60864949ybce31fceb016b23f@mail.gmail.com>
References: <fd3eb9bf0810190533l75f8b20kd31a3dbb158d7c0f@mail.gmail.com>
	<s5h7i83rdvr.wl%tiwai@suse.de>
	<fd3eb9bf0810210200l45b33311o7ec5d674b53f5912@mail.gmail.com>
	<s5habcykl3o.wl%tiwai@suse.de>
	<fd3eb9bf0810211018r50a12e5bu6a3141e16762fe91@mail.gmail.com>
	<s5hprltj71z.wl%tiwai@suse.de> <1224671239.4001.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 339072453B
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 13:08:10 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so172489and.80
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 04:07:51 -0700 (PDT)
In-Reply-To: <1224671239.4001.19.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@vroon.org>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T0ssIGdyZWF0LiBXaWxsIGNoZWNrIHRoYXQgb25lLCBJIGhhdmUgb25lICJEZWxsIE9FTSIgU0Ig
TGl2ZSEgKGl0J3MKbm90IGZyb20gRGVsbCBhdCBhbGwsIHRoYXQncyB3aHkgSSBxdW90ZWQgdGhh
dCBwYXJ0KS4KCjIwMDgvMTAvMjIgVG9ueSBWcm9vbiA8dG9ueUB2cm9vbi5vcmc+Ogo+IFZlZHJh
biwKPgo+IFdpdGggcmVnYXJkIHRvIHRoZSBTQjAyMjggY29tbWVudCwganVzdCBtYWtlIHN1cmUg
eW91J3JlIHJlYWRpbmcgdGhlCj4gcHJvZHVjdCBJRCBmcm9tIHRoZSBjb3JyZWN0IGxvY2F0aW9u
LiBUaGUgc2lsay1zY3JlZW5lZCBudW1iZXIgb24gdGhlCj4gUENCIHdpbGwgYWx3YXlzIGVuZCBp
biAwLCBidXQgaWYgeW91IHJlYWQgdGhlIHNlcmlhbCBudW1iZXIgbGFiZWwgb24gdGhlCj4gYmFj
ayBvZiB0aGUgY2FyZCwgeW91J2xsIGZpbmQgdGhlIHJlYWwgcHJvZHVjdCBJRC4KPiBHZW5lcmFs
bHkgc29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcyBvZiBNMVNCMDIyOHh4eHh4eHh4eAo+IFNraXAg
dGhlIGZpcnN0IHR3byBjaGFyYWN0ZXJzLCByZWFkIHRoZSBuZXh0IDYuIFRoaXMgd29ya3Mgb24g
Q3JlYXRpdmUKPiBzb3VuZGNhcmRzIHRoYXQgYXJlIExpdmUhIG9yIG5ld2VyLCBiZWZvcmUgdGhl
biB0aGVpciBzZXJpYWwgbnVtYmVycwo+IGxvb2tlZCBkaWZmZXJlbnQuCj4KPiBUaGlzIG1heSBo
ZWxwIHlvdSBmaW5kIG1vcmUgc3BlY2lmaWMgcHJvZHVjdCBJRHMgZm9yIG90aGVyIE9FTSBMaXZl
ISAmCj4gQXVkaWd5IGJvYXJkcy4KPgo+IFJlZ2FyZHMsCj4gVG9ueSBWLgo+CgoKCi0tIApWZWRy
YW4gTWlsZXRpxIcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
