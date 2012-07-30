From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/18] ARM: ux500: Add all encompassing
 Sound node to DB8500 Device Tree
Date: Mon, 30 Jul 2012 15:30:15 +0100
Message-ID: <50169A77.3050402@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
 <20120729205227.GL4384@opensource.wolfsonmicro.com>
 <50163936.1050901@linaro.org>
 <20120730134220.GD4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F25265322
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 16:30:16 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so838194eaa.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 07:30:18 -0700 (PDT)
In-Reply-To: <20120730134220.GD4468@opensource.wolfsonmicro.com>
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

T24gMzAvMDcvMTIgMTQ6NDIsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMzAsIDIw
MTIgYXQgMDg6MzU6MThBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBPbiAyOS8wNy8xMiAy
MTo1MiwgTWFyayBCcm93biB3cm90ZToKPgo+Pj4gLi4udGhpcyBpcyBjbGVhcmx5IHRoZSBib2Fy
ZC1zcGVjaWZpYyBzZXR1cCBmb3IgdGhlIHN5c3RlbSwgc2hvd2luZyBob3cKPj4+IHRoZSBDUFUg
YW5kIENPREVDIGFyZSBob29rZWQgdXAuICBUaGlzIHNob3VsZCB0aGVyZWZvcmUgYmUgaW4gdGhl
IERUIGZvcgo+Pj4gd2hhdGV2ZXIgYm9hcmQgdGhpcyBpcyB5b3UncmUgd29ya2luZyBvbi4KPgo+
PiBJIGRvbid0IHRoaW5rIGl0J3MgYm9hcmQgc3BlY2lmaWMuIEkgYmVsaWV2ZSB0aGlzIGlzIHRo
ZSBzZXR1cCBvbgo+PiBhbGwgZGI4NTAwIHBsYXRmb3Jtcy4gSSdtIGhhcHB5IHRvIGJlIHRvbGQg
SSdtIHdyb25nIGhlcmUsIGluIHdoaWNoCj4+IGNhc2UgSSBjYW4gbW92ZSBpdCB0byB0aGUgYm9h
cmQgc3BlY2lmaWMgZmlsZXMuCj4KPiBJIHRoaW5rIHRoYXQncyBtb3JlIGEgc2lnbiB0aGF0IGFs
bCB0aGUgcGxhdGZvcm1zIHlvdSd2ZSBzZWVuIGFyZSBqdXN0Cj4gY3V0J24ncGFzdGVkIGZyb20g
dGhlIHJlZmVyZW5jZSBkZXNpZ24gdGhhbiBhbnl0aGluZyBlbHNlLiAgSWYgdGhlIHRoaW5nCj4g
eW91J3JlIGRlc2NyaWJpbmcgaXMgb24gdGhlIFBDQiBpdCdzIGdlbmVyYWxseSBib2FyZCBzcGVj
aWZpYy4uLgoKSSdsbCBzcGxpdCBpdCBvdXQgaW50byB0aGUgYm9hcmQgZmlsZShzKSBpZiBpdCBt
YWtlcyB5b3UgaGFwcHkuIEknZCAKcmF0aGVyIGp1c3QgZ2V0IGl0IGluIGFuZCBtb3ZlIG9uIHRv
IHNvbWV0aGluZyBtb3JlIHByb2R1Y3RpdmUuIFdlIGNhbiAKY2hhbmdlIGl0IHJldHJvc3BlY3Rp
dmVseSBpZiBJJ20gdG9sZCBieSBzb21lb25lIG1vcmUga25vd2xlZGdlYWJsZSB0aGF0IAppdCdz
IDEwMCUgY29tbW9uIGFjcm9zcyBhbGwgcGxhdGZvcm1zLgoKLS0gCkxlZSBKb25lcwpMaW5hcm8g
U1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ug
c29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8
IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
