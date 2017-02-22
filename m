From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC
	for arm64
Date: Wed, 22 Feb 2017 03:29:24 +0100
Message-ID: <20170222022929.10540-5-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9DC26680A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 03:29:57 +0100 (CET)
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: info@andromedabox.org, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

U05EX01NUF9TT0Mgc2VsZWN0cyBTTkRfQVJNLCB3aGljaCBpcyBsaW1pdGVkIHRvIEFSTSwgYXMg
d2VsbCBhcwpNTVBfU1JBTSwgd2hpY2ggaXMgYSBub24tRFQgZHJpdmVyIGluIGFyY2gvYXJtL21h
Y2gtYXJtLy4KCkF2b2lkIEtjb25maWcgd2FybmluZ3MgYnkgbm90IG1ha2luZyB0aGlzIGRyaXZl
ciBhdmFpbGFibGUgb24gQVJNNjQuCgpXaGlsZSBhdCBpdCwgdGlkeSB0aGUgdGl0bGUgKFNvYyAt
PiBTb0MpLgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRl
PgotLS0KIHYyOiBuZXcKIAogc291bmQvc29jL3B4YS9LY29uZmlnIHwgNCArKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9weGEvS2NvbmZpZyBiL3NvdW5kL3NvYy9weGEvS2NvbmZpZwppbmRleCA4MjNiNWEy
Li5mOGUxYzA2IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvcHhhL0tjb25maWcKKysrIGIvc291bmQv
c29jL3B4YS9LY29uZmlnCkBAIC04LDggKzgsOCBAQCBjb25maWcgU05EX1BYQTJYWF9TT0MKIAkg
IHRvIHNlbGVjdCB0aGUgYXVkaW8gaW50ZXJmYWNlcyB0byBzdXBwb3J0IGJlbG93LgogCiBjb25m
aWcgU05EX01NUF9TT0MKLQlib29sICJTb2MgQXVkaW8gZm9yIE1hcnZlbGwgTU1QIGNoaXBzIgot
CWRlcGVuZHMgb24gQVJDSF9NTVAKKwlib29sICJTb0MgQXVkaW8gZm9yIE1hcnZlbGwgTU1QIGNo
aXBzIgorCWRlcGVuZHMgb24gQVJDSF9NTVAgJiYgQVJNCiAJc2VsZWN0IE1NUF9TUkFNCiAJc2Vs
ZWN0IFNORF9TT0NfR0VORVJJQ19ETUFFTkdJTkVfUENNCiAJc2VsZWN0IFNORF9BUk0KLS0gCjIu
MTAuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
