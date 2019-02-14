From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 13/13] ASoC: samsung: i2s: Convert to SPDX License
 Indentifier
Date: Thu, 14 Feb 2019 10:37:47 +0100
Message-ID: <20190214093747.2414-14-s.nawrocki@samsung.com>
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093858epcas2p10993b30cf39b6c12d3fe0a4dfd20f6e8@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

Replace GPL v2.0 license statements with SPDX license identifier.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4f13b514d9ce..304b3138b3ff 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1,13 +1,9 @@
-/*
- * ALSA SoC Audio Layer - Samsung I2S Controller driver
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassisinghbrar@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Audio Layer - Samsung I2S Controller driver
+//
+// Copyright (c) 2010 Samsung Electronics Co. Ltd.
+//	Jaswinder Singh <jassisinghbrar@gmail.com>
 
 #include <dt-bindings/sound/samsung-i2s.h>
 #include <linux/delay.h>
-- 
2.17.1
