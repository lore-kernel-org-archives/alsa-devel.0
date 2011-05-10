From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] MFD: twl4030-codec: Update e-mail address
Date: Tue, 10 May 2011 08:59:23 +0300
Message-ID: <1305007163-5931-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello,

Instead of keeping the old Nokia mail address, just change it to my new
email address in the author line.

 drivers/mfd/twl4030-codec.c       |    4 ++--
 include/linux/mfd/twl4030-codec.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl4030-codec.c b/drivers/mfd/twl4030-codec.c
index c02fded..534cc2e 100644
--- a/drivers/mfd/twl4030-codec.c
+++ b/drivers/mfd/twl4030-codec.c
@@ -1,7 +1,7 @@
 /*
  * MFD driver for twl4030 codec submodule
  *
- * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
@@ -270,6 +270,6 @@ static void __devexit twl4030_codec_exit(void)
 }
 module_exit(twl4030_codec_exit);
 
-MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@nokia.com>");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_LICENSE("GPL");
 
diff --git a/include/linux/mfd/twl4030-codec.h b/include/linux/mfd/twl4030-codec.h
index 2ec317c..5cc16bb 100644
--- a/include/linux/mfd/twl4030-codec.h
+++ b/include/linux/mfd/twl4030-codec.h
@@ -1,7 +1,7 @@
 /*
  * MFD driver for twl4030 codec submodule
  *
- * Author:	Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * Copyright:   (C) 2009 Nokia Corporation
  *
-- 
1.7.5.rc3

