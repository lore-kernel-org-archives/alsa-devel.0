From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Fri, 1 Dec 2017 12:03:13 +0900
Message-ID: <17d4c4a7-b75e-a745-b982-6f9c63ae9863@sakamocchi.jp>
References: <87o9nj42g9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 91019267B70
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 04:03:16 +0100 (CET)
In-Reply-To: <87o9nj42g9.wl%kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, "(Renesas) Yokoyama" <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAxN+W5tDEy5pyIMDHml6UgMTE6MjUsIEt1bmlub3JpIE1vcmltb3RvIHdyb3RlOgo+IFRo
aXMgcGF0Y2ggdXNlcyBkZWxheWVkX3dvcmsgd2l0aCAwIGRlbGF5LCB0aHVzLCBjYWxsLWJhY2sg
ZnVuY3Rpb24KPiB3aWxsIGJlIGNhbGxlZCBpbW1pbmVudGx5Lgo+IFRoZXJlIHdhcyAwIGppZmZp
ZXMgZGVsYXkgYmV0d2VlbiB0cmlnZ2VyIDwtPiBjYWxsYmFjayBpbiBteSB0ZXN0LgoKSnVzdCB1
c2Ugd29ya3F1ZXVlLgoKQWRkaXRpb25hbGx5LCBpdCdzIGJldHRlciB0byBhZGQgY29kZSBjb21t
ZW50IGFib3V0IHlvdXIgc3RyYXRlZ3kgdG8gCndhaXQgZm9yIHRoZSA1IHBoYXNlIG9mIHdvcmQg
c2VsZWN0IGNsb2NrLgoKClJlZ2FyZHMKClRha2FzaGkgU2FrYW1vdG8KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
