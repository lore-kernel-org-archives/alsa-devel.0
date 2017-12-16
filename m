From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v5 2/6] MAINTAINERS: add entry for NXP TDA1997x driver
Date: Sat, 16 Dec 2017 10:00:26 -0800
Message-ID: <1513447230-30948-3-git-send-email-tharvey@gateworks.com>
References: <1513447230-30948-1-git-send-email-tharvey@gateworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513447230-30948-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, Steve Longerbeam <slongerbeam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52f..502bc97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13244,6 +13244,14 @@ T:	git git://linuxtv.org/mkrufky/tuners.git
 S:	Maintained
 F:	drivers/media/tuners/tda18271*
 
+TDA1997x MEDIA DRIVER
+M:	Tim Harvey <tharvey@gateworks.com>
+L:	linux-media@vger.kernel.org
+W:	https://linuxtv.org
+Q:	http://patchwork.linuxtv.org/project/linux-media/list/
+S:	Maintained
+F:	drivers/media/i2c/tda1997x.*
+
 TDA827x MEDIA DRIVER
 M:	Michael Krufky <mkrufky@linuxtv.org>
 L:	linux-media@vger.kernel.org
-- 
2.7.4
