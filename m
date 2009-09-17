From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/5] ASoC: fix typos in Blackfin headers
Date: Wed, 16 Sep 2009 20:25:10 -0400
Message-ID: <1253147112-5801-3-git-send-email-vapier@gentoo.org>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DC80103903
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 02:25:16 +0200 (CEST)
In-Reply-To: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ac97.h |    2 +-
 sound/soc/blackfin/bf5xx-i2s.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
index 3f2a911..a1f97dd 100644
--- a/sound/soc/blackfin/bf5xx-ac97.h
+++ b/sound/soc/blackfin/bf5xx-ac97.h
@@ -1,5 +1,5 @@
 /*
- * linux/sound/arm/bf5xx-ac97.h
+ * sound/soc/blackfin/bf5xx-ac97.h
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/sound/soc/blackfin/bf5xx-i2s.h b/sound/soc/blackfin/bf5xx-i2s.h
index 7107d1a..264ecdc 100644
--- a/sound/soc/blackfin/bf5xx-i2s.h
+++ b/sound/soc/blackfin/bf5xx-i2s.h
@@ -1,5 +1,5 @@
 /*
- * linux/sound/arm/bf5xx-i2s.h
+ * sound/soc/blackfin/bf5xx-i2s.h
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.6.5.rc1
