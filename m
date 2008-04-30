From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] soc - neo1973_wm8753.c change maintainer
	contact info
Date: Wed, 30 Apr 2008 15:19:04 +0100
Message-ID: <1209565146-32393-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209565146-32393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 62580245F7
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 16:19:09 +0200 (CEST)
In-Reply-To: <1209565146-32393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.org>

I have moved workplaces since I originally wrote this driver so update
the contact info for new employers.

Signed-off-by: Graeme Gregory <graeme@openmoko.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index e2339b9..c8caddf 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -667,6 +667,6 @@ module_init(neo1973_init);
 module_exit(neo1973_exit);
 
 /* Module information */
-MODULE_AUTHOR("Graeme Gregory, graeme.gregory@wolfsonmicro.com, www.wolfsonmicro.com");
+MODULE_AUTHOR("Graeme Gregory, graeme@openmoko.org, www.openmoko.org");
 MODULE_DESCRIPTION("ALSA SoC WM8753 Neo1973");
 MODULE_LICENSE("GPL");
-- 
1.5.5.1
