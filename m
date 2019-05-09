From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH 0/2] ASoC: ak4458: fail on probe if codec is not present
Date: Thu, 9 May 2019 13:30:35 +0000
Message-ID: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Daniel Baluta <daniel.baluta@nxp.com>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

QUs0NDU4IGlzIHByb2JlZCBzdWNjZXNzZnVsbHkgZXZlbiBpZiBBSzQ0NTggaXMgbm90IHByZXNl
bnQgLSB0aGlzDQppcyBjYXVzZWQgYnkgcHJvYmUgZnVuY3Rpb24gcmV0dXJuaW5nIG5vIGVycm9y
IG9uIGkyYyBhY2Nlc3MgZmFpbHVyZS4NClRoZSBwYXRjaHNldCBmaXhlcyB0aGlzLg0KDQpWaW9y
ZWwgU3VtYW4gKDIpOg0KICBBU29DOiBhazQ0NTg6IHJzdG5fY29udHJvbCAtIHJldHVybiBhIG5v
bi16ZXJvIG9uIGVycm9yIG9ubHkNCiAgQVNvQzogYWs0NDU4OiBhZGQgcmV0dXJuIHZhbHVlIGZv
ciBhazQ0NThfcHJvYmUNCg0KIHNvdW5kL3NvYy9jb2RlY3MvYWs0NDU4LmMgfCAxNiArKysrKysr
KystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjcuNA0KDQo=
