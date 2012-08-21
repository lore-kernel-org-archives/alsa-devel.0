From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] ASoC: codecs: Enable AB8500 CODEC for
	Device Tree
Date: Tue, 21 Aug 2012 12:51:24 +0100
Message-ID: <20120821115123.GE26899@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
 <s5h628lu0q9.wl%tiwai@suse.de> <20120820113427.GN8450@gmail.com>
 <20120820143653.GE26991@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 61109265B49
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 13:51:27 +0200 (CEST)
Received: by eaa13 with SMTP id 13so1813478eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 04:51:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120820143653.GE26991@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBBdWcgMjAsIDIwMTIgYXQgMDM6MzY6NTNQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBNb24sIEF1ZyAyMCwgMjAxMiBhdCAxMjozNDozMVBNICswMTAwLCBMZWUgSm9uZXMg
d3JvdGU6Cj4gPiBGcm9tOiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4gRGF0
ZTogRnJpLCAyNyBKdWwgMjAxMiAwODo1MDowNSArMDEwMAo+ID4gU3ViamVjdDogW1BBVENIIDEv
MV0gQVNvQzogY29kZWNzOiBFbmFibGUgQUI4NTAwIENPREVDIGZvciBEZXZpY2UgVHJlZQo+ID4g
Cj4gPiBXZSBjb250aW51ZSB0byBhbGxvdyB0aGUgQUI4NTAwIENPREVDIHRvIGJlIHJlZ2lzdGVy
ZWQgdmlhIHRoZSBBQjg1MDAKPiA+IE11bHRpIEZ1bmN0aW9uYWwgRGV2aWNlIEFQSSwgb25seSB0
aGlzIHRpbWUgd2UgZXh0cmFjdCBpdHMgY29uZmlndXJhdGlvbgo+ID4gZnJvbSB0aGUgRGV2aWNl
IFRyZWUgYmluYXJ5Lgo+IAo+IFBsZWFzZSByZXNlbmQgdGhpcyBzZXJpZXMgd2l0aCBhbGwgdGhl
IGFja3MgeW91J3ZlIGdvdCByYXRoZXIgdGhhbgo+IG1peGluZyBpbmNyZW1lbnRhbCB1cGRhdGVz
IGluIGxpa2UgdGhpcy4KCkknbSB3YWl0aW5nIHVudGlsIEkgaGF2ZSBhIGZldyBtb3JlIEFja3Mg
YmVmb3JlIEkgcmVzZW5kIHRoZSBlbnRpcmUKcGF0Y2gtc2V0IGFnYWluLiBBY3R1YWxseSBpdCdz
IHlvdSBhbmQgb25lIG90aGVyIHRoYXQgSSdtIHdhaXRpbmcgZm9yCnRvIHJldmlldyAoYW5kIEFj
ayBhcyBuZWNlc3NhcnkpIHRoZSBvbmVzIHJlcXVlc3RlZCBieSBMaW51cywgdGhlbiAKcmVzZW5k
IHdpdGggdGhlIGNvcnJlY3Rpb25zLgoKPiBQbGVhc2UgYWxzbyBzZW5kIHBhdGNoZXMgaW4KPiB0
aGUgZm9ybWF0IGRvY3VtZW50ZWQgaW4gU3VibWl0dGluZ1BhdGNoZXMuCgpUaGF0J3MgYSBiaWcg
ZG9jdW1lbnQsIG1vc3Qgb2Ygd2hpY2ggSSBndWVzcyBJJ20gYWRoZXJpbmcgdG8uIENhcmUgdG8K
YmUgYSBsaXR0bGUgbW9yZSBzcGVjaWZpYz8KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNULUVyaWNz
c29uIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
