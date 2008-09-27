From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] Drop Vladimir Barinov's e-mail address
Date: Sat, 27 Sep 2008 13:36:36 +0200
Message-ID: <20080927133636.02a58b0a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BA6824597
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 13:36:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Every e-mail I've sent to Vladimir Barinov bounced back to me, so I
guess he no longer works at MontaVista.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 arch/arm/plat-omap/include/mach/mtd-xip.h |    2 +-
 drivers/usb/host/ehci-ixp4xx.c            |    2 +-
 sound/soc/codecs/tlv320aic3x.c            |    2 +-
 sound/soc/codecs/tlv320aic3x.h            |    2 +-
 sound/soc/davinci/davinci-evm.c           |    2 +-
 sound/soc/davinci/davinci-i2s.c           |    2 +-
 sound/soc/davinci/davinci-i2s.h           |    2 +-
 sound/soc/davinci/davinci-pcm.c           |    2 +-
 sound/soc/davinci/davinci-pcm.h           |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.27-rc7.orig/arch/arm/plat-omap/include/mach/mtd-xip.h	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/arch/arm/plat-omap/include/mach/mtd-xip.h	2008-09-27 12:56:40.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Do not include this file directly. It's included from linux/mtd/xip.h
  *
- * Author: Vladimir Barinov <vbarinov@ru.mvista.com>
+ * Author: Vladimir Barinov
  *
  * (c) 2005 MontaVista Software, Inc.  This file is licensed under the
  * terms of the GNU General Public License version 2.  This program is
--- linux-2.6.27-rc7.orig/drivers/usb/host/ehci-ixp4xx.c	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/drivers/usb/host/ehci-ixp4xx.c	2008-09-27 12:56:30.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * IXP4XX EHCI Host Controller Driver
  *
- * Author: Vladimir Barinov <vbarinov@ru.mvista.com>
+ * Author: Vladimir Barinov
  *
  * Based on "ehci-fsl.c" by Randy Vinson <rvinson@mvista.com>
  *
--- linux-2.6.27-rc7.orig/sound/soc/codecs/tlv320aic3x.c	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/codecs/tlv320aic3x.c	2008-09-27 12:56:23.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC TLV320AIC3X codec driver
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * Based on sound/soc/codecs/wm8753.c by Liam Girdwood
--- linux-2.6.27-rc7.orig/sound/soc/codecs/tlv320aic3x.h	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/codecs/tlv320aic3x.h	2008-09-27 12:56:19.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC TLV320AIC3X codec driver
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
--- linux-2.6.27-rc7.orig/sound/soc/davinci/davinci-evm.c	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/davinci/davinci-evm.c	2008-09-27 12:56:14.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ASoC driver for TI DAVINCI EVM platform
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
--- linux-2.6.27-rc7.orig/sound/soc/davinci/davinci-i2s.c	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/davinci/davinci-i2s.c	2008-09-27 12:56:11.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC I2S (McBSP) Audio Layer for TI DAVINCI processor
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
--- linux-2.6.27-rc7.orig/sound/soc/davinci/davinci-i2s.h	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/davinci/davinci-i2s.h	2008-09-27 12:56:07.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC I2S (McBSP) Audio Layer for TI DAVINCI processor
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
--- linux-2.6.27-rc7.orig/sound/soc/davinci/davinci-pcm.c	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/davinci/davinci-pcm.c	2008-09-27 12:56:03.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ALSA PCM interface for the TI DAVINCI processor
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
--- linux-2.6.27-rc7.orig/sound/soc/davinci/davinci-pcm.h	2008-09-27 12:53:06.000000000 +0200
+++ linux-2.6.27-rc7/sound/soc/davinci/davinci-pcm.h	2008-09-27 12:55:59.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * ALSA PCM interface for the TI DAVINCI processor
  *
- * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
+ * Author:      Vladimir Barinov
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify


-- 
Jean Delvare
