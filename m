From: "A. C. Censi" <accensi@gmail.com>
Subject: Re: AD1988B: ALSA doesn't use dmix automatically
Date: Mon, 17 Mar 2008 11:08:48 -0300
Message-ID: <643ea2b10803170708i13b5e6dfia0db71499e3d2712@mail.gmail.com>
References: <20080315234852.25288ff8@tux.abusar.org.br>
	<s5hzlsxpoa7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ECCA10386E
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 15:08:50 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so1034068gvd.24
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 07:08:49 -0700 (PDT)
In-Reply-To: <s5hzlsxpoa7.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBNYXIgMTcsIDIwMDggYXQgODo0NSBBTSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPiB3cm90ZToKPiBBdCBTYXQsIDE1IE1hciAyMDA4IDIzOjQ4OjUyIC0wMzAwLAo+Cj4gRMOi
bmllbCBGcmFnYSB3cm90ZToKPiA+Cj4gPiBBTFNBIDEuMC4xNQo+ID4KPiA+IGh0dHA6Ly9hbHNh
Lm9wZW5zcmMub3JnL2luZGV4LnBocC9EbWl4Cj4gPgo+ID4gTk9URTogRm9yIEFMU0EgMS4wLjly
YzIgYW5kIGhpZ2hlciB5b3UgZG9uJ3QgbmVlZCB0byBzZXR1cCBkbWl4LiBEbWl4Cj4gPiBpcyBl
bmFibGVkIGFzIGRlZmF1bHQgZm9yIHNvdW5kY2FyZHMgd2hpY2ggZG9uJ3Qgc3VwcG9ydCBodyBt
aXhpbmcuCj4gPgo+ID4gICAgICAgU28gd2h5IGlmIEkgdHJ5IHRvIHBsYXkgMiBzb3VuZHMgYXQg
dGhlIHNhbWUgdGltZSwgdGhlIHNlY29uZAo+ID4gb25lIGNvbXBsYWlucyB0aGUgInJlc291cmNl
IGlzIGJ1c3kiPyBTaG91bGRuJ3QgaXQgZGV0ZWN0IHRoYXQgQUQxOTg4Qgo+ID4gY2FuJ3QgZG8g
aGFyZHdhcmUgbWl4aW5nIGFuZCB1c2UgZG1peCBhdXRvbWF0aWNhbGx5Pwo+Cj4gSXQgZG9lcyBh
cyBsb25nIGFzIHRoZSBhcHAgdXNlcyB0aGUgImRlZmF1bHQiIFBDTS4gIFRoZSBkbWl4IGlzbid0
Cj4gZm9yY2VkIHRvIGJlIGFwcGxpZWQuICBUaGUgZXhjbHVzaXZlIGhhcmR3YXJlIGFjY2VzcyBp
cyBzdGlsbAo+IGF2YWlsYWJsZSBieSBvcGVuaW5nIHRoZSBQQ00gYXMgImh3IiwgInBsdWdodyIg
YW5kIGV0Yy4gIFNvLCBpZiBhbnkKPiBhcHBzIGFjY2VzcyBleGNsdXNpdmVseSwgb3RoZXJzIHdp
bGwgc3VmZmVyLgo+CgpBcHBsaWNhdGlvbnMgbm9ybWFsbHkgb2ZmZXIgdGhlIHJlYWwgZGV2aWNl
cyBhcyBmaXJzdCBjaG9pY2VzIGFuZCBub3QKdGhlICJkZWZhdWx0IiBQQ00uIFBlcmhhcHMgdGhp
cyBzaG91bGQgYmUgZXhwbGFpbmVkIGJldHRlciBpbiB0aGUKZG9jdW1lbnRhdGlvbiBvciB0aGUg
d2lraSwgbm90IG9ubHkgZm9yIHRoZSBlbmQgdXNlcnMsIGJ1dCBhbHNvIGZvcgphcHBsaWNhdGlv
biBkZXZlbG9wZXJzLgoKLS0gCkEuIEMuIENlbnNpCmFjY2Vuc2kgW2VtXSBnbWFpbCBbcG9udG9d
IGNvbQphY2NlbnNpIFtlbV0gbW9udHJlYWwgW3BvbnRvXSBjb20gW3BvbnRvXSBicgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
