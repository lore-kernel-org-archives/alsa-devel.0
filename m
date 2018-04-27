From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v2 2/2] ASoC: mt6351 switch to SPDX license tag
Date: Fri, 27 Apr 2018 09:54:45 +0800
Message-ID: <20180427015445.4334-3-kaichieh.chuang@mediatek.com>
References: <20180427015445.4334-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 48F08267860
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 03:54:53 +0200 (CEST)
In-Reply-To: <20180427015445.4334-1-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: garlic.tseng@mediatek.com, broonie@kernel.org, ryder.lee@mediatek.com
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/codecs/mt6351.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index 06fd4706ae20..e739f078fec5 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * mt6351.c  --  mt6351 ALSA SoC audio codec driver
- *
- * Copyright (c) 2018 MediaTek Inc.
- * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
- */
+//
+// mt6351.c  --  mt6351 ALSA SoC audio codec driver
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
 
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-- 
2.12.5
