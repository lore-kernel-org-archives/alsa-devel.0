From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: [RFC v2 00/11] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Tue, 12 Dec 2017 19:51:10 +0100
Message-ID: <CA+Owze5OGMweOMcZhk0CTbMVt+VH+ioTq04m4o_A=cTFR0Rfmg@mail.gmail.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hbmj5mrts.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD2978@BGSMSX104.gar.corp.intel.com>
 <s5hinddl28l.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD2F48@BGSMSX104.gar.corp.intel.com>
 <s5hefo1aymr.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD52D3@BGSMSX104.gar.corp.intel.com>
 <CA+Owze6H7O1YQkvwu+rv+snpsxX3Dg9RgMGcFwTPtRL9sHn20g@mail.gmail.com>
 <85DFEED57DC57344B2483EF7BF8CB60579AD5494@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5E22671B1
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 19:51:12 +0100 (CET)
Received: by mail-io0-f196.google.com with SMTP id u42so58240ioi.9
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 10:51:12 -0800 (PST)
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60579AD5494@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

SGksCkkgYW0gcHJldHR5IHN1cmUgaXQgY29udGFpbnMgdGhpcyBpbnRlZ3JhdGVkIGNpcmN1aXQ6
IE1BWDk4MzU3QkVXTApJdCBpcyBhIERTUC4gV2h5IGlzIGEgbmVlZCBmb3IgZmlybXdhcmU/CgpJ
dCBpcyBhIEludGVsIENvcmUgaTUtNjM2MFUKCmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MTk1NjcxCgpCZXN0cywKSm/Dq2wKCk9uIFR1ZSwgRGVjIDEyLCAyMDE3
IGF0IDc6NDAgUE0sIFVnaHJlamEsIFJha2VzaCBBCjxyYWtlc2guYS51Z2hyZWphQGludGVsLmNv
bT4gd3JvdGU6Cj4KPgo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+RnJvbTogYWxzYS1k
ZXZlbC1ib3VuY2VzQGFsc2EtcHJvamVjdC5vcmcgW21haWx0bzphbHNhLWRldmVsLWJvdW5jZXNA
YWxzYS0KPj5wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIEpvw6tsIEtyw6RoZW1hbm4KPj5TZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAxMiwgMjAxNyAxMTo1MiBQTQo+PlRvOiBVZ2hyZWphLCBSYWtl
c2ggQSA8cmFrZXNoLmEudWdocmVqYUBpbnRlbC5jb20+Cj4+Q2M6IGFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZzsgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjsgcGllcnJlLQo+PmxvdWlz
LmJvc3NhcnRAbGludXguaW50ZWwuY29tOyBQYXRjaGVzIEF1ZGlvIDxwYXRjaGVzLmF1ZGlvQGlu
dGVsLmNvbT47Cj4+bGlhbS5yLmdpcmR3b29kQGxpbnV4LmludGVsLmNvbTsgS291bCwgVmlub2Qg
PHZpbm9kLmtvdWxAaW50ZWwuY29tPjsKPj5icm9vbmllQGtlcm5lbC5vcmcKPj5TdWJqZWN0OiBS
ZTogW2Fsc2EtZGV2ZWxdIFtSRkMgdjIgMDAvMTFdIEVuYWJsZSBIREEgQ29kZWMgc3VwcG9ydCBv
biBJbnRlbAo+PlBsYXRmb3JtcyAoU2VyaWVzMikKPj4KPj5IaSwKPj5XaGVyZSBpcyB5b3VyIGNv
ZGUgbG9jYXRlZD8gU2luY2UgSSBoYXZlIGdvdCBhIG1hY2Jvb2sgcHJvIDIwMTYgYW5kIEkKPj5i
ZWxpZXZlIHRoaXMgZmVhdHVyZSBpcyBhIHByZXJlcXVpc2l0ZSB0byBnZXQgYW55IHNvdW5kIHdv
cmtpbmcuCj4+SSB3b3VsZCBsb3ZlIHRvIHRlc3QgaXQgd2l0aCBteSBjaXJydXMgbG9naWMgODQw
OSBIREEgc291bmRjYXJkLgo+Cj4gTXkgbGFzdCBzZXJpZXMgd2FzIHJlYmFzZWQgb24gdG9wIG9m
IE1hcmsncyBmb3ItbmV4dCB0cmVlLiBZb3Ugd291bGQgbmVlZAo+IFRvcG9sb2d5IGZpbGUsIHdo
aWNoIEkgY2FuIHNlbmQgdmlhIGVtYWlsLiBCdXQgYmVmb3JlIEkgZG8gdGhhdCBJIHdhbnQgdG8g
Y29uZmlybQo+IGlmIHlvdSBoYXZlIHRoZSByaWdodCB0aGluZ3MgZW5hYmxlZC4KPgo+IERvIHlv
dSBrbm93IGlmIGl0IGlzIGJhc2VkIG9uIDZ0aCBHZW5lcmF0aW9uIChTS0wpIG9yIDd0aCBHZW5l
cmF0aW9uKEtCTCkgb2YgSW50ZWwgY29yZSA/Cj4gWW91IHdpbGwgbmVlZCB0byBkb3dubG9hZCB0
aGUgRFNQIEZpcm13YXJlIGJpbmFyeSBmaWxlIGJhc2VkIG9uIHRoaXMuCj4gQWxzbyBJIGFtIG5v
dCBzdXJlIGlmIHRoZSBEU1AgZnVuY3Rpb25hbGl0eSBpcyBlbmFibGVkIG9uIHRoZSBNQUMgc3lz
dGVtcy4gSWYgeW91IGNvbXBpbGUKPiBzbmQtaGRhLWNvcmUua28gaW4gZGVidWcgbW9kZSwgaXQg
cHJpbnRzIHRoZSBjYXBhYmlsaXRpZXMuIEkgY2FuIGNoZWNrIHRoYXQgZnJvbSB0aGUgbG9ncy4K
Pgo+IFJlZ2FyZHMsCj4gUmFrZXNoCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
