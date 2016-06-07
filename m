From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for
	MAX98357A/RT5514/DA7219
Date: Tue, 07 Jun 2016 21:48:42 +0800
Message-ID: <5756D0BA.7060702@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk> <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk> <5756B22F.9000105@rock-chips.com>
 <20160607120647.GV7510@sirena.org.uk> <5756C245.7010001@rock-chips.com>
 <20160607133247.GY7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ACAA2605B8
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:49:09 +0200 (CEST)
In-Reply-To: <20160607133247.GY7510@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCk9uIDIwMTblubQwNuaciDA35pelIDIxOjMyLCBNYXJrIEJyb3duIHdyb3RlOgo+
IE9uIFR1ZSwgSnVuIDA3LCAyMDE2IGF0IDA4OjQ3OjAxUE0gKzA4MDAsIFhpbmcgWmhlbmcgd3Jv
dGU6Cj4+IE9uIDIwMTblubQwNuaciDA35pelIDIwOjA2LCBNYXJrIEJyb3duIHdyb3RlOgo+Pj4g
T0ssIHRoZW4gdGhlIG9yaWdpbmFsIG5hbWUgcHJvYmFibHkgbWFrZXMgc29tZSBzZW5zZSB0aG91
Z2ggcmVhbGx5Cj4+PiB0aGF0J3Mgc3VjaCBhbiB1bnVzdWFsIGRlc2lnbiB0aGF0IGp1c3QgbmFt
aW5nIGl0IGFmdGVyIHRoZSBzcGVjaWZpYwo+Pj4gYm9hcmQgbWlnaHQgYmUgYmV0dGVyLCBpdCdz
IG5vdCBsaWtlbHkgdG8gc2VlIGFueSByZXVzZSBJJ2QgZ3Vlc3MuCj4+IFRoZXJlIGFyZSBub3Qg
b25seSBvbmUgdHlwZSBvZiBib2FyZCB3aXRoIHRoaXMgYXVkaW8gY29ubmVjdGlvbiwgc28gSSB0
aGluawo+PiB3ZSBkb24ndCBuZWVkIHRvIGFkZCBzcGVjaWZpYyBib2FyZCBuYW1lLgo+IEkgaW1h
Z2luZSB0aGV5J3JlIGFsbCB2YXJpYW50cyBvbiBhIHNpbmdsZSByZWZlcmVuY2UgZGVzaWduIHRo
b3VnaD8gIFRoZQo+IG5hbWUgaXMgdW53ZWlsZHkuClllcywgdGhleSBhcmUgYmFzZWQgb24gYSBz
aW5nbGUgcmVmZXJlbmNlIGRlc2lnbiB3aGljaCBpcyBjYWxsZWQgZ3J1LCBzbyAKY291bGQgSSB1
c2UgdGhlIG5hbWUgInJrMzM5OS1ncnUtc291bmQiPwoKVGhhbmtzLgoKLS0gCi0gWGluZyBaaGVu
ZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
