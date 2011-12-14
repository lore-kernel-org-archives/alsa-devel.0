From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/10] ASoC: sdp4430: Correct author e-mail address
Date: Wed, 14 Dec 2011 11:46:54 +0200
Message-ID: <1323856022-24053-2-git-send-email-peter.ujfalusi@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 2735fa0..3186e0a 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -1,7 +1,7 @@
 /*
  * sdp4430.c  --  SoC audio for TI OMAP4430 SDP
  *
- * Author: Misael Lopez Cruz <x0052729@ti.com>
+ * Author: Misael Lopez Cruz <misael.lopez@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -272,7 +272,7 @@ static void __exit sdp4430_soc_exit(void)
 }
 module_exit(sdp4430_soc_exit);
 
-MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC SDP4430");
 MODULE_LICENSE("GPL");
 
-- 
1.7.8

