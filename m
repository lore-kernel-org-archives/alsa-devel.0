From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Fri, 1 Dec 2017 12:17:46 +0900
Message-ID: <c2027de8-745b-2bf1-2c42-40b9535aacda@sakamocchi.jp>
References: <87o9nj42g9.wl%kuninori.morimoto.gx@renesas.com>
 <17d4c4a7-b75e-a745-b982-6f9c63ae9863@sakamocchi.jp>
 <87lgin4079.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 2BA32267B70
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 04:17:48 +0100 (CET)
In-Reply-To: <87lgin4079.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "(Renesas) Yokoyama" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

T24gMjAxN+W5tDEy5pyIMDHml6UgMTI6MTQsIEt1bmlub3JpIE1vcmltb3RvIHdyb3RlOgo+PiBB
ZGRpdGlvbmFsbHksIGl0J3MgYmV0dGVyIHRvIGFkZCBjb2RlIGNvbW1lbnQgYWJvdXQgeW91ciBz
dHJhdGVneSB0bwo+PiB3YWl0IGZvciB0aGUgNSBwaGFzZSBvZiB3b3JkIHNlbGVjdCBjbG9jay4K
PiAKPiBJIHRoaW5rIEkgYWRkZWQgaXQgb24gYWs0NjEzX2RhaV90cmlnZ2VyKCkgPwoKSXQgZG9l
c24ndCBtYXR0ZXIgYXMgbG9uZyBhcyB5b3UgcHV0IGl0IGludG8gdGhlIGNvZGUsIGluIG15IG9w
aW5pb24uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
