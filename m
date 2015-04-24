From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH V2 4/4] MAINTAINERS: Add entry for tas571x ASoC codec driver
Date: Fri, 24 Apr 2015 15:36:48 -0700
Message-ID: <1429915008-22015-5-git-send-email-cernekee@chromium.org>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add self as maintainer for the new driver.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea0001760035..15153fc37cc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9878,6 +9878,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ti/netcp*
 
+TI TAS571X FAMILY ASoC CODEC DRIVER
+M:	Kevin Cernekee <cernekee@chromium.org>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Odd Fixes
+F:	sound/soc/codecs/tas571x*
+
 TI TWL4030 SERIES SOC CODEC DRIVER
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.2.0.rc0.207.ga3a616c
