From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Wed, 6 Jun 2012 02:28:39 +0200
Message-ID: <CAPXgP10VE2huY4gGpeFPe=YKYM+nDBfoMgpHnGmQwn0jdPxhbw@mail.gmail.com>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
 <20120605151754.a794ac7c.akpm@linux-foundation.org>
 <1338936572.5780.29.camel@joe2Laptop>
 <20120605162910.caccb0d4.akpm@linux-foundation.org>
 <1338939316.11962.3.camel@joe2Laptop>
 <CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
 <1338939792.11962.4.camel@joe2Laptop>
 <CAPXgP10DEsqtz9xbPUQ3xCwdFGTTYyTGSd7yEcU2vUr3SJ83Sw@mail.gmail.com>
 <1338940345.11962.9.camel@joe2Laptop>
 <20120605165808.cd255b93.akpm@linux-foundation.org>
 <1338941247.11962.16.camel@joe2Laptop>
 <CAPXgP12OFnh6FZO4zFGCw=Ea4U6Ne5OoCg_9BPxRX62x0EVnng@mail.gmail.com>
 <1338941971.11962.20.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1338941971.11962.20.camel@joe2Laptop>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Joe Perches <joe@perches.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdW4gNiwgMjAxMiBhdCAyOjE5IEFNLCBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMu
Y29tPiB3cm90ZToKPiBPbiBXZWQsIDIwMTItMDYtMDYgYXQgMDI6MTMgKzAyMDAsIEtheSBTaWV2
ZXJzIHdyb3RlOgo+PiBUaGUgcXVlc3Rpb24gaXMgd2hhdCBoYXBwZW5zIGlmIHlvdSBpbmplY3Qg
eW91ciBuZXcgYmluYXJ5IHR3by1ieXRlCj4+IHByZWZpeCwgbGlrZToKPj4gwqAgZWNobyAtZSAi
XHgwMVx4MDJIZWxsbyIgPiAvZGV2L2ttc2cKPgo+IEl0J3Mgbm90IGEgMiBieXRlIGJpbmFyeS4K
PiBJdCdzIGEgbGVhZGluZyBhc2NpaSBTT0ggYW5kIGEgc3RhbmRhcmQgYXNjaWkgY2hhcgo+ICcw
JyAuLi4gJzcnIG9yICdkJy4KPgo+ICNkZWZpbmUgS0VSTl9FTUVSRyDCoCDCoCDCoEtFUk5fU09I
ICIwIiDCoCDCoC8qIHN5c3RlbSBpcyB1bnVzYWJsZSAqLwo+ICNkZWZpbmUgS0VSTl9BTEVSVCDC
oCDCoCDCoEtFUk5fU09IICIxIiDCoCDCoC8qIGFjdGlvbiBtdXN0IGJlIHRha2VuIGltbWVkaWF0
ZWx5ICovCj4gZXRjLi4uCgpPay4KCj4+IEFuZCBpZiB0aGF0IGNoYW5nZXMgdGhlIGxvZy1sZXZl
bCB0byAiMiIgaW5zdGVhZCBvZiB0aGUgZGVmYXVsdCAiNCI/Cj4KPiBObyBpdCBkb2Vzbid0LgoK
U286CiAgIGVjaG8gLWUgIlx4MDEySGVsbG8iID4gL2Rldi9rbXNnCmlzIHN0aWxsIGxldmVsIDQ/
IFNvdW5kcyBhbGwgZmluZSB0aGVuLgoKPiBJdCdzIG5vdCB0cmlnZ2VyaW5nIHRoYXQgYmVjYXVz
ZSBkZXZrbXNnX3dyaXRldiBkb2VzCj4gcHJlZml4IHBhcnNpbmcgb25seSBvbiB0aGUgb2xkICI8
bj4iIGZvcm0uCgpZZWFoLCBidXQgcHJpbnRrX2VtaXQoKSB3aWxsIG5vdCB0cnkgdG8gcGFyc2Ug
aXQ/IEkgZGlkIG5vdCBjaGVjaywgYnV0CndpdGggeW91ciBjaGFuZ2UsIHRoZSBwcmVmaXggcGFy
c2luZyBpbiBwcmludGtfZW1pdCgpIGlzIHN0aWxsIHNraXBwZWQKaWYgYSBsZXZlbCBpcyBnaXZl
biBhcyBhIHBhcmFtZXRlciB0byBwcmludGtfZW1pdCgpLCByaWdodD8KCktheQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QK
ZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVy
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kZXZlbAo=
