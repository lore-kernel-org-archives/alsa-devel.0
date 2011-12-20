From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Tue, 20 Dec 2011 08:45:39 +0200
Message-ID: <CALq1K=K6j-ZXd5E7_CL9D_YZRgb9StvZtaGTPrKi9fsSvUcDpw@mail.gmail.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF176BE92B19@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C8341038F9
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 07:46:02 +0100 (CET)
Received: by vcbf13 with SMTP id f13so3775892vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:46:01 -0800 (PST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF176BE92B19@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBEZWMgMTksIDIwMTEgYXQgMjM6MDAsIFN0ZXBoZW4gV2FycmVuIDxzd2FycmVuQG52
aWRpYS5jb20+IHdyb3RlOgo+IExlb24gUm9tYW5vdnNreSB3cm90ZSBhdCBNb25kYXksIERlY2Vt
YmVyIDE5LCAyMDExIDEyOjUyIFBNOgo+PiBBdCB0aGlzIHN0YWdlIG9ubHkgVG9zaGliYSBBQzEw
MC9EeW5hYm9vayBzdXBwb3J0ZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExlb24gUm9tYW5vdnNr
eSA8bGVvbkBsZW9uLm51Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgRGFuaW4gPGRhbmluZHJl
eUBtYWlsLnJ1Pgo+Cj4gQWNrZWQtYnk6IFN0ZXBoZW4gV2FycmVuIDxzd2FycmVuQG52aWRpYS5j
b20+Cj4KPiBJIGFsc28gYXR0ZW1wdGVkIHRvIHRlc3QgdGhpcywgYnV0IGNvdWxkbid0IHBlcnN1
YWRlIGFueSBhdWRpbyB0byBjb21lCj4gb3V0LiBXaGF0IG1vcmUgZG8gSSBuZWVkIHRvIHRlc3Qg
dGhpcywgYmV5b25kIHRoZSBvYnZpb3VzIGFkZGl0aW9uIG9mCj4gcGxhdGZvcm0gZGV2aWNlIHJl
Z2lzdHJhdGlvbiBhbmQgY2xvY2tzIHRvIGJvYXJkLXBhejAwLmM/IFRoYW5rcy4KSSBiZWxpZXZl
IHRoZSBOVkVDIHlvdSB1c2VkIChmcm9tIHN0YWdpbmcgdHJlZSkgaXMgbm90IHRoZSBsYXRlc3QK
dmVyc2lvbiBJIGhhdmUuIElmIEkgZm9yZ2V0IHNvbWV0aGluZywgdGhlIHdvcmtpbmcgc291bmQg
aXMgYXZhaWxhYmxlCmF0IGh0dHBzOi8vZ2l0b3Jpb3VzLm9yZy9+bGVvbnJvL2FjMTAwL2xlb25y
by1tYXJ2aW4yNHMta2VybmVsCgpCZWZvcmUsIEknbSBnb2luZyB0byBzdGFydCBwdXNoaW5nIG90
aGVyIHBhcnRzIG9mIHRoZSBhdWRpbywgaG93IGRvIEkKbmVlZCB0byBoYW5kbGUgY3Jvc3MtdHJl
ZSBwYXRjaGVzID8gRm9yIGV4YW1wbGUgSSdsbCBuZWVkIHRvIHVwZGF0ZQpOVkVDIChzdGFnaW5n
IHRyZWUpIGFuZCBwbGF0Zm9ybV9kZXZpY2UgKHRlZ3JhIGFuZCBBU29DKQpPbiB3aGljaCB0cmVl
IGRvIEkgYmFzZSBteSBwYXRjaGVzPwoKCj4KPiAtLQo+IG52cHVibGljCj4KCgoKLS0gCkxlb24g
Um9tYW5vdnNreSB8IEluZGVwZW5kZW50IExpbnV4IENvbnN1bHRhbnQKwqAgwqAgwqAgwqDCoHd3
dy5sZW9uLm51wqB8IGxlb25AbGVvbi5udQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
