From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for
	max98090 codec
Date: Thu, 16 Jul 2015 19:22:17 +0800
Message-ID: <55A793E9.3050707@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl> <20150716110032.GU11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C030260561
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 13:28:24 +0200 (CEST)
In-Reply-To: <20150716110032.GU11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, heiko@sntech.de, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, dgreid@chromium.org, sonnyrao@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjAxNeW5tDA35pyIMTbml6UgMTk6MDAsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVGh1LCBK
dWwgMTYsIDIwMTUgYXQgMTA6MDU6NDRBTSArMDIwMCwgUGF1bCBCb2xsZSB3cm90ZToKPgo+Pj4g
K3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNuZF9ya19tY19kcml2ZXIgPSB7Cj4+PiAr
CS5wcm9iZSA9IHNuZF9ya19tY19wcm9iZSwKPj4+ICsJLnJlbW92ZSA9IHNuZF9ya19tY19yZW1v
dmUsCj4+PiArCS5kcml2ZXIgPSB7Cj4+PiArCQkubmFtZSA9IERSVl9OQU1FLAo+Pj4gK01PRFVM
RV9BTElBUygicGxhdGZvcm06IiBEUlZfTkFNRSk7Cj4+IFRoaXMgc2VlbXMgb25seSB1c2VmdWwg
aWYgdGhlcmUncyBhIGNvcnJlc3BvbmRpbmcgc3RydWN0Cj4+IHBsYXRmb3JtX2RldmljZS4gSWUs
IGEgcGxhdGZvcm1fZGV2aWNlIHdpdGggYSAicm9ja2NoaXAtc25kLW1heDk4MDkwIgo+PiAubmFt
ZSwgd2hpY2ggd2lsbCB0cmlnZ2VyIGEgIk1PREFMSUFTPXBsYXRmb3JtOnJvY2tjaGlwLXNuZC1t
YXg5ODA5MCIKPj4gdWV2ZW50IHdoZW4gaXQncyBjcmVhdGVkLiBCdXQgSSBjb3VsZG4ndCBmaW5k
IHdoZXJlIHN1Y2ggYQo+PiBwbGF0Zm9ybV9kZXZpY2UgaXMgY3JlYXRlZC4KPj4gRGlkIEkgbWlz
cyBzb21ldGhpbmc/IE9yIGlzIHRoZXJlIGFub3RoZXIgd2F5IHRoaXMgYWxpYXMgaXMgdXNlZnVs
IGhlcmU/Cj4gWW91J3ZlIGdvdCBwbGF0Zm9ybV9kZXZpY2UgYW5kIHBsYXRmb3JtX2RyaXZlciBj
b25mdXNlZCBJIHRoaW5rLgpNYXJrLCBUaGFuayB5b3UuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
