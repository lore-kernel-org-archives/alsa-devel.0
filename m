From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Tue, 14 Oct 2008 18:22:42 +0200
Message-ID: <fd3eb9bf0810140922r5307b2ddua3a4ebcfb1213877@mail.gmail.com>
References: <20081012165353.a084d158.baz@irc.msk.ru>
	<s5h1vyk5vr3.wl%tiwai@suse.de> <s5hy70s4h0i.wl%tiwai@suse.de>
	<20081013232147.026f38c9.baz@irc.msk.ru>
	<s5hzll7oetb.wl%tiwai@suse.de> <48F463AC.1000307@gmail.com>
	<s5hhc7f4fec.wl%tiwai@suse.de> <s5hd4i34ewz.wl%tiwai@suse.de>
	<48F4A895.90801@gmail.com> <s5htzbf2nva.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 1C85C2457D
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 18:23:00 +0200 (CEST)
Received: by gxk10 with SMTP id 10so4608866gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 09:22:42 -0700 (PDT)
In-Reply-To: <s5htzbf2nva.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

TGV0J3MgY2xlYXIgdGhpcyB1cCByaWdodCBoZXJlOiBhcmUgb25seSBjYXJkcyB3aGljaCBjYW4g
d29yayBpbiBVQUEKKHNuZC1oZGEtaW50ZWwpIG1vZGUgb25lcyB0aGF0IGhhdmUgX3R3b18gY2hp
cHNldHMgb24gYm9hcmQsIHdoZXJlCnNlY29uZCBvbmUgaXMgQ0EwMTEyIG9yIENBMDExMD8gSXMg
dGhhdCBuZWVkZWQganVzdCBmb3IgMjBrMT8gRG8gMjBrMgptb2RlbHMgaGF2ZSB0aGF0IGZlYXR1
cmUgYnVpbHRpbj8KCjIwMDgvMTAvMTQgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjoKPiBB
dCBUdWUsIDE0IE9jdCAyMDA4IDE4OjExOjMzICswNDAwLAo+IFRoZSBTb3VyY2Ugd3JvdGU6Cj4+
Cj4+IFRha2FzaGkgSXdhaSDQv9C40YjQtdGCOgo+PiA+IEF0IFR1ZSwgMTQgT2N0IDIwMDggMTI6
NTI6NTkgKzAyMDAsCj4+ID4gSSB3cm90ZToKPj4gPgo+PiA+PiBBdCBUdWUsIDE0IE9jdCAyMDA4
IDEzOjE3OjMyICswNDAwLAo+PiA+PiBUaGUgU291cmNlIHdyb3RlOgo+PiA+Pgo+PiA+Pj4gT2ss
IGdvdCB0aGUgZG1lc2cgb3V0cHV0IHdpdGggZGVidWc9My4gSG9wZSB0aGF0IGhlbHBzLgo+PiA+
Pj4KPj4gPj4gVGhhbmtzLiAgSXMgaXQgdGhlIG91dHB1dCB3aXRoIHRoZSBzeXN0ZW0gdGltZXIg
KFhYWF9TWVNURU1fVElNRVIpPwo+PiA+Pgo+PiA+PiBJIHVwZGF0ZWQgdGhlIEdJVCBhbmQgc25h
cHNob3QgdGFyYmFsbCBhZ2Fpbi4gIEl0J3MganVzdCBzb21lIG1vcmUKPj4gPj4gYWRkaXRpb25z
IG9mIGRlYnVnIGxvZyBwb2ludHMgYW5kIHR5cG8gY29ycmVjdGlvbnMuICBBbnl3YXksIHRyeSB0
bwo+PiA+PiB1cGRhdGUuCj4+ID4+Cj4+ID4+IFJlZ2FyZGluZyB5b3VyIHNpbGVudCBvdXRwdXQ6
IGl0IHNlZW1zIHlvdXIgZGV2aWNlIGlzIGRldGVjdGVkIGFzCj4+ID4+IFNCMDU1eCwgYW5kIGl0
IGdvZXMgdG8gYSBzcGVjaWFsIERBQyBpbml0aWFsaXphdGlvbiB1bmxpa2Ugb3RoZXJzLgo+PiA+
PiBNYXliZSB0aGF0J3MgdGhlIGNhdXNlLgo+PiA+Pgo+PiA+PiBEb2VzIHRoZSBwYXRjaCBiZWxv
dyBoYXZlIGFueSBjaGFuZ2U/Cj4+ID4+Cj4+ID4KPj4gPiBBcmdoLCBhcHBhcmVudGx5IHRoaXMg
cGF0Y2ggd29uJ3QgY2hhbmdlIGFueXRoaW5nLiAgRm9yZ2V0IGl0Lgo+PiA+IEkgbWlzcmVhZCB0
aGUgbG9nLiAgU2VlbXMgeW91ciBoYXJkd2FyZSBpcyB0aGUgdHlwZSBPUklHLgo+PiA+Cj4+ID4K
Pj4gPiBUYWthc2hpCj4+ID4KPj4gPgo+PiBBIHNtYWxsIHF1ZXN0aW9uOiBjYW4gbXkgY2FyZCAo
UGxhdGludW0gRmF0YWxpdHkgQ2hhbXBpb24gU2VyaWVzKSB3b3JrCj4+IGluIGludGVsIGhkYSBt
b2RlPwo+Cj4gSSBndWVzcyBuby4KPgo+Cj4gVGFrYXNoaQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo+CgoKCi0tIApWZWRyYW4gTWlsZXRpxIcK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
