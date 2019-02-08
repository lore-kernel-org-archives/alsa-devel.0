From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/2] ASoC: msm8916-wcd-digital: convert license header to SPDX
Date: Fri,  8 Feb 2019 16:16:56 +0100
Message-ID: <20190208151656.26735-3-johan@kernel.org>
References: <20190208151656.26735-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208151656.26735-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

Convert the GPLv2-only license header to SPDX.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 3063dedd21cf..3e7409c85dd2 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1,14 +1,5 @@
-/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2016, The Linux Foundation. All rights reserved.
 
 #include <linux/module.h>
 #include <linux/err.h>
-- 
2.20.1
