From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 09/20] ASoC: imx-spdif: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:59 +0300
Message-ID: <20190405115010.28838-10-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-spdif.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 797d66e43d49..4f7f210beb18 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -1,13 +1,6 @@
-/*
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/of_platform.h>
-- 
2.11.0
