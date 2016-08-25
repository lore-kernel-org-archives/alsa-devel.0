From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: tegra_rt5640: Correct a copy and paste
	typo in the comments
Date: Wed, 24 Aug 2016 17:26:15 -0700
Message-ID: <1472084775-7655-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D0DD266633
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 02:26:20 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id g202so2131003pfb.1
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 17:26:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

This patch corrects a copy and paste typo.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/tegra/tegra_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.c
index 773daec..e5ef4e9 100644
--- a/sound/soc/tegra/tegra_rt5640.c
+++ b/sound/soc/tegra/tegra_rt5640.c
@@ -1,5 +1,5 @@
 /*
-* tegra_rt5640.c - Tegra machine ASoC driver for boards using WM8903 codec.
+* tegra_rt5640.c - Tegra machine ASoC driver for boards using RT5640 codec.
  *
  * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
  *
-- 
2.1.4
