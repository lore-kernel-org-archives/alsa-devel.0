From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Fix copyright statements on Simtec
	files
Date: Mon,  2 Mar 2009 17:18:58 +0000
Message-ID: <1236014341-25837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF446103806
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 18:19:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ben Dooks <ben@simtec.co.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Ben Dooks <ben@simtec.co.uk>

Fix the copyright statements in two of the S3C24XX ASoC files
that have (c) when we require the full word.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    2 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 6f4d439..1c2b054 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -4,7 +4,7 @@
  * (c) 2006 Wolfson Microelectronics PLC.
  * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
  *
- * (c) 2004-2005 Simtec Electronics
+ * Copyright 2004-2005 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 7c64d31..ba1ae09 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -4,7 +4,7 @@
  * (c) 2006 Wolfson Microelectronics PLC.
  * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
  *
- * (c) 2004-2005 Simtec Electronics
+ * Copyright 2004-2005 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
-- 
1.6.1.3
