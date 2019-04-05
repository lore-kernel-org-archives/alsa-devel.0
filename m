From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 20/20] ASoC: wm1133-ev1: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:10 +0300
Message-ID: <20190405115010.28838-21-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
List-Id: alsa-devel@alsa-project.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/wm1133-ev1.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index 2f80b21b2921..aad24ccbef90 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -1,16 +1,11 @@
-/*
- *  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
- *
- *  Copyright (c) 2010 Wolfson Microelectronics plc
- *  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
- *
- *  Based on an earlier driver for the same hardware by Liam Girdwood.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+//  wm1133-ev1.c - Audio for WM1133-EV1 on i.MX31ADS
+//
+//  Copyright (c) 2010 Wolfson Microelectronics plc
+//  Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+//
+//  Based on an earlier driver for the same hardware by Liam Girdwood.
 
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-- 
2.11.0
