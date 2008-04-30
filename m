From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] soc - ln2440sbc_alc650 - Fix checkpatch
	warnings
Date: Wed, 30 Apr 2008 10:10:17 +0100
Message-ID: <1209546619-14389-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209546619-14389-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0AF7103874
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 11:10:21 +0200 (CEST)
In-Reply-To: <1209546619-14389-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/ln2440sbc_alc650.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index 9ed8f2e..4eab2c1 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -1,10 +1,10 @@
 /*
  * SoC audio for ln2440sbc
- * 
+ *
  * Copyright 2007 KonekTel, a.s.
  * Author: Ivan Kuten
  *         ivan.kuten@promwad.com
- * 
+ *
  * Heavily based on smdk2443_wm9710.c
  * Copyright 2007 Wolfson Microelectronics PLC.
  * Author: Graeme Gregory
-- 
1.5.5.1
