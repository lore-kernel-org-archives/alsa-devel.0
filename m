From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 16/20] ASoC: p1022_ds: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:06 +0300
Message-ID: <20190405115010.28838-17-andradanciu1997@gmail.com>
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
 sound/soc/fsl/p1022_ds.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 41c623c55c16..80384f70878d 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -1,14 +1,10 @@
-/**
- * Freescale P1022DS ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022DS ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.11.0
