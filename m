From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/5] ASoC: tlv320dac33: Update e-mail address
Date: Tue, 10 May 2011 09:01:06 +0300
Message-ID: <1305007270-6566-2-git-send-email-peter.ujfalusi@ti.com>
References: <1305007270-6566-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 403A210380F
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 08:01:16 +0200 (CEST)
In-Reply-To: <1305007270-6566-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/tlv320dac33-plat.h |    2 +-
 sound/soc/codecs/tlv320dac33.c   |    4 ++--
 sound/soc/codecs/tlv320dac33.h   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
index 6c66496..0b94192 100644
--- a/include/sound/tlv320dac33-plat.h
+++ b/include/sound/tlv320dac33-plat.h
@@ -1,7 +1,7 @@
 /*
  * Platform header for Texas Instruments TLV320DAC33 codec driver
  *
- * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 082e9d5..61220f8 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC Texas Instruments TLV320DAC33 codec driver
  *
- * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
@@ -1655,5 +1655,5 @@ module_exit(dac33_module_exit);
 
 
 MODULE_DESCRIPTION("ASoC TLV320DAC33 codec driver");
-MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@nokia.com>");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320dac33.h b/sound/soc/codecs/tlv320dac33.h
index 7c318b5..ed69670 100644
--- a/sound/soc/codecs/tlv320dac33.h
+++ b/sound/soc/codecs/tlv320dac33.h
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC Texas Instruments TLV320DAC33 codec driver
  *
- * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
-- 
1.7.5.rc3
