From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
	pxa2xx-ac97
Date: Fri, 14 Aug 2009 01:34:22 +0200
Message-ID: <200908140134.22716.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907300255.01675.marek.vasut@gmail.com>
	<20090813204033.GA7519@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f205.google.com (mail-bw0-f205.google.com
	[209.85.218.205])
	by alsa0.perex.cz (Postfix) with ESMTP id C7A4A1038B5
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 01:34:44 +0200 (CEST)
Received: by bwz1 with SMTP id 1so993941bwz.46
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 16:34:43 -0700 (PDT)
In-Reply-To: <20090813204033.GA7519@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, dwmw2@infradead.org, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

RG5lIMSMdCAxMy4gc3JwbmEgMjAwOSAyMjo0MDozNCBNYXJrIEJyb3duIG5hcHNhbChhKToKPiBP
biBUaHUsIEp1bCAzMCwgMjAwOSBhdCAwMjo1NTowMUFNICswMjAwLCBNYXJlayBWYXN1dCB3cm90
ZToKPiA+IEZyb20gMjA3ZDU0MjQ0NzY4ZTk0Y2UwMTQ0Y2JhNTVhY2Y0YWUwNjVlNmNlMCBNb24g
U2VwIDE3IDAwOjAwOjAwIDIwMDEKPiA+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBn
bWFpbC5jb20+Cj4gPiBEYXRlOiBUdWUsIDIxIEp1bCAyMDA5IDE2OjIyOjI5ICswMjAwCj4gPiBT
dWJqZWN0OiBbUEFUQ0hdIEFsbG93IHBhc3NpbmcgcGxhdGZvcm1fZGF0YSBmb3IgcHhhMnh4LWFj
OTcKPiA+Cj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcGFzc2luZyBwbGF0Zm9ybSBk
YXRhIHRvIGFjOTcgYnVzIGRldmljZXMKPiA+IGZyb20gUFhBMnh4LUFDOTcgZHJpdmVyLi4KPgo+
IEkndmUgYXBwbGllZCB0aGlzIG9uZSB0b28gc2luY2UgaXQncyBBTFNBIG9ubHkgYW5kIGl0J2xs
IGVhc2UgbWVyZ2UKPiBpc3N1ZXMgbmV4dCBtZXJnZSB3aW5kb3cgLSB3ZSBjYW4gcmV2aXNpdCBp
ZiBhbnkgb2YgdGhlIG90aGVyIHBhdGNoZXMKPiBnZXQgYXBwbGllZCBiZWZvcmUuCgpIaSwKCnRo
YW5rcywgSSB0aGluayB5b3UgY2FuIGFwcGx5IHRoZSAzLzQgYW5kIDQvNCBhcyB3ZWxsLiBCdXQg
eW91IHNob3VsZCBwcm9iYWJseSAKdGFsayB0byBBbnRvbiBhYm91dCB0aGUgMy80IGlmIGhlIHdh
bnRzIHRvIG1lcmdlIGl0IHRocm91Z2ggeW91ciB0cmVlIG9yIGhpcyAKb3Igd2hhdGV2ZXIuIEhl
IGFja2VkIGl0IHByZXZpb3VzbHksIGl0J3MgaW4gdGhhdCBodWdlIHRocmVhZCBmcm9tIGp1bHku
IFRoZSAKbWFpbCdzIHN1YmplY3QgaXMgIltQQVRDSCAyLzRdIEFsbG93IHBhc3NpbmcgcGxhdGZv
cm1fZGF0YSBmb3IgcHhhMnh4LWFjOTciIAphbmQgaXQncyBmcm9tIDIyLzA3LzIwMDkuCgpDaGVl
cnMhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
