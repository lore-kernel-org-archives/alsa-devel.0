From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [sound-unstable:topic/hda-spdif-fix 99/124] ERROR:
 "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
Date: Mon, 22 Oct 2012 17:17:38 +0800
Message-ID: <20121022091738.GA8902@localhost>
References: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
 <50850D7D.8050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 198DC2651B0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 11:17:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50850D7D.8050402@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBPY3QgMjIsIDIwMTIgYXQgMTE6MTA6MjFBTSArMDIwMCwgUMOpdGVyIFVqZmFsdXNp
IHdyb3RlOgo+IEhpLAo+IAo+IE9uIDEwLzIxLzIwMTIgMDU6NTkgQU0sIEZlbmdndWFuZyBXdSB3
cm90ZToKPiA+IEhpIFBldGVyLAo+ID4gCj4gPiBGWUksIGtlcm5lbCBidWlsZCBmYWlsZWQgb24K
PiA+IAo+ID4gdHJlZTogICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdGl3YWkvc291bmQtdW5zdGFibGUuZ2l0IHRvcGljL2hkYS1zcGRpZi1maXgKPiA+IGhl
YWQ6ICAgYWZjNTFlNDkyYjM2YmQ2MWI0NmY0ZDcwZGQ2NDY2NzhkOTZmNWY5Nwo+ID4gY29tbWl0
OiBlNzczNmNkZWEyMjNmM2E1Yjg2N2MzNTlmYjM1Y2YwODI1MGRkNzcxIFs5OS8xMjRdIGRtYWVu
Z2luZTogQWRkIGZsYWdzIHBhcmFtZXRlciB0byBkbWFlbmdpbmVfcHJlcF9kbWFfY3ljbGljKCkK
PiA+IGNvbmZpZzogYXJtLW9tYXAycGx1c19kZWZjb25maWcgIyBtYWtlIEFSQ0g9YXJtIG9tYXAy
cGx1c19kZWZjb25maWcKPiA+IAo+ID4gQWxsIGVycm9yL3dhcm5pbmdzOgo+ID4gCj4gPiBFUlJP
UjogInNuZF9od3BhcmFtc190b19kbWFfc2xhdmVfY29uZmlnIiBbc291bmQvc29jL29tYXAvc25k
LXNvYy1vbWFwLmtvXSB1bmRlZmluZWQhCj4gPiBFUlJPUjogInNuZF9kbWFlbmdpbmVfcGNtX3Bv
aW50ZXIiIFtzb3VuZC9zb2Mvb21hcC9zbmQtc29jLW9tYXAua29dIHVuZGVmaW5lZCEKPiA+IEVS
Uk9SOiAic25kX2RtYWVuZ2luZV9wY21fb3BlbiIgW3NvdW5kL3NvYy9vbWFwL3NuZC1zb2Mtb21h
cC5rb10gdW5kZWZpbmVkIQo+ID4gRVJST1I6ICJzbmRfZG1hZW5naW5lX3BjbV9jbG9zZSIgW3Nv
dW5kL3NvYy9vbWFwL3NuZC1zb2Mtb21hcC5rb10gdW5kZWZpbmVkIQo+ID4gRVJST1I6ICJzbmRf
ZG1hZW5naW5lX3BjbV9nZXRfY2hhbiIgW3NvdW5kL3NvYy9vbWFwL3NuZC1zb2Mtb21hcC5rb10g
dW5kZWZpbmVkIQo+ID4gRVJST1I6ICJzbmRfZG1hZW5naW5lX3BjbV90cmlnZ2VyIiBbc291bmQv
c29jL29tYXAvc25kLXNvYy1vbWFwLmtvXSB1bmRlZmluZWQhCj4gCj4gVGhpcyBoYXMgYmVlbiBm
aXhlZCBieSB0aGUgZm9sbG93aW5nIGNvbW1pdCAoYWxyZWFkeSBpbiBtYWlubGluZSk6Cj4gOTYx
YTdhZSBBU29DOiBkbWFlbmdpbmU6IENvcnJlY3QgTWFrZWZpbGUgd2hlbiBzb3VuZCBpcyBidWls
dCBhcyBtb2R1bGUKClNvcnJ5IGFib3V0IHRoYXQhIEkndmUgZml4ZWQgdGhlIHNjcmlwdCB0byB0
ZXN0IHRoYXQgY2FzZSBhbmQgYXZvaWQKcmVwb3J0aW5nIGZpeGVkIGVycm9ycyBpbiB1cHN0cmVh
bS4KClRoYW5rcywKRmVuZ2d1YW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
