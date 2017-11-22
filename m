From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 7/8] MAINTAINERS: add entries for UniPhier ASoC sound drivers
Date: Wed, 22 Nov 2017 20:43:20 +0900
Message-ID: <20171122114321.29196-8-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b05bc2c5e85c..0959fd951f80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12579,6 +12579,12 @@ F:	include/media/soc*
 F:	drivers/media/i2c/soc_camera/
 F:	drivers/media/platform/soc_camera/
 
+SOCIONEXT UNIPHIER SOUND DRIVER
+M:	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/uniphier/
+
 SOEKRIS NET48XX LED SUPPORT
 M:	Chris Boot <bootc@bootc.net>
 S:	Maintained
-- 
2.15.0
