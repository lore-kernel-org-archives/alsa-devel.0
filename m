From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: NULL pointer dereference in ALSA triggered	through
 saa7134-alsa
Date: Mon, 10 Aug 2009 21:28:35 +0300
Message-ID: <4A8066D3.7050107@pardus.org.tr>
References: <4A8025BF.7030404@pardus.org.tr>
	<s5hab27n501.wl%tiwai@suse.de>	<4A803FDC.8070005@pardus.org.tr>
	<s5hocqnllcg.wl%tiwai@suse.de>	<4A804585.9060908@pardus.org.tr>
	<s5hljlrlkcf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B6FE424859
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 20:28:37 +0200 (CEST)
In-Reply-To: <s5hljlrlkcf.wl%tiwai@suse.de>
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

VGFrYXNoaSBJd2FpIHdyb3RlOgo+IEF0IE1vbiwgMTAgQXVnIDIwMDkgMTk6MDY6MjkgKzAzMDAs
Cj4gT3phbiDDh2HEn2xheWFuIHdyb3RlOgo+ICAgCj4+IFRha2FzaGkgSXdhaSB3cm90ZToKPj4g
ICAgIAo+Pj4gQnV0IC91c3IvaW5jbHVkZS9zb3VuZCBpc24ndCB1c2VkIGZvciBidWlsZGluZyBr
ZXJuZWwgbW9kdWxlcyBub3JtYWxseS4KPj4+IFVubGVzcyBhbnkgaGFjayBpcyBhZGRlZCwgdGhl
c2UgZmlsZXMgaGF2ZSB0byBiZSBpbnN0YWxsZWQgdG8gdGhlCj4+PiBrZXJuZWwgaGVhZGVyIGRp
cmVjdG9yeS4KPj4+ICAgCj4+PiAgICAgICAKPj4gQWggeW91J3JlIHJpZ2h0LCBJIHRvdGFsbHkg
bWlzc2VkIHRoYXQgb25lLiBUaGFua3MsIHdpbGwgdHJ5IHRvCj4+IHdvcmthcm91bmQgdGhhdC4K
Pj4gICAgIAo+Cj4gV2VsbCwgdGhlIGJlc3Qgd291bGQgYmUgdG8gbWFrZSBhbHNhLWRyaXZlciBi
YWNrd2FyZCBjb21wYXRpYmxlLgo+IEJhc2ljYWxseSB3ZSBuZWVkIHRvIHBhdGNoIGhlYWRlcnMg
aW4gYWxzYS1rZXJuZWwgdHJlZSB0byBiZQo+IGJpbmFyeS1jb21wYXRpYmxlIHdpdGggb2xkZXIg
dmVyc2lvbnMsIGkuZS4gYWRqdXN0aW5nIHRoZSBmaWVsZHMKPiBpbiBzdHJ1Y3Qgc25kX3BjbSBv
ciBzbywgYW5kIHN1cHBseSB0aGUgY29tcGF0aWJsZSBmdW5jdGlvbiwKPiBzbmRfY2FyZF9uZXco
KSBpbiBhZGRpdGlvbi4KPiAgIApUaGUgZGlmZiBiZXR3ZWVuIDIuNi4zMC40IHNvdW5kIGhlYWRl
cnMgYW5kIGN1cnJlbnQgc25hcHNob3Qgd2FzCnJlbGF0aXZlbHkgc21hbGwgKDcwMH4gbGluZXMp
LCBzbmRfY2FyZF9uZXcoKSBpcyByZW1vdmVkLCBhIGxvdCBvZiBTb0MKc3R1ZmYgd2FzIG1vZGlm
aWVkLCBldGMuIEkgcGF0Y2hlZCB0aG9zZSBpbnRvIG15IGtlcm5lbCBoZWFkZXJzIGFuZCB0aGVu
CmJ1aWx0IHRoZSBkcml2ZXJzIGJ1dCBzdGlsbCB0aGUgc2FtZSBpc3N1ZS4gSSdtIG5vdyBjb21w
aWxpbmcgMi42LjMwLjQKd2l0aCBBTFNBIGFuZCBWNEwgZHJpdmVycyB0byBzZWUgaWYgSSBoYXZl
IHRoYXQgT29wcyB3aXRoIHZhbmlsbGEgbW9kdWxlcy4KClJlZ2FyZHMsCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
