From: =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 0/2] ASoC: fix sound on mx31moboard
Date: Tue,  1 Oct 2013 14:36:09 +0200
Message-ID: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 27003264EBF
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 14:36:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, s.hauer@pengutronix.de, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8KClRoZXNlcyB0d28gcGF0Y2hlcyBhcmUgbmVjZXNzYXJ5IHRvIGdldCBiYWNrIHRoZSBz
b3VuZCB3b3JraW5nIG9uIApteDMxbW9ib2FyZHMuIApUaGUgZmlyc3Qgb25lIGZpeCBpbXgtc3Np
IHRvIHdvcmsgZXZlbiBpZiBvbmx5IHRoZSBkbWEgaXMgYXZhaWxhYmxlLgpUaGUgc2Vjb25kIG9u
ZSBmaXggdGhlIGF1ZG11eCBzZXR0aW5ncyBvbiBteDMxbW9ib2FyZCBib2FyZHMuCgpUaGFua3Ms
CgpQaGlsaXBwZQoKUGhpbGlwcGUgUsOpdG9ybmF6ICgyKToKICBBU29DOiBmc2w6IGlteC1zc2k6
IGZpeCBwcm9iZSBvbiBpbXgzMQogIEFTb0M6IGZzbDogRml4IHNvdW5kIG9uIG14MzFtb2JvYXJk
Cgogc291bmQvc29jL2ZzbC9pbXgtbWMxMzc4My5jIHwgICAgMiArLQogc291bmQvc29jL2ZzbC9p
bXgtc3NpLmMgICAgIHwgICAyMyArKysrKysrKysrKystLS0tLS0tLS0tLQogc291bmQvc29jL2Zz
bC9pbXgtc3NpLmggICAgIHwgICAgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkKCi0tIAoxLjcuOS41CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
