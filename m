From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Bump ASoC core version number
Date: Tue, 20 Nov 2007 09:25:35 +0000
Message-ID: <1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD740249EA
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:45:01 +0100 (CET)
In-Reply-To: <1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e32fa2f..1c22931 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -22,7 +22,7 @@
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
 
-#define SND_SOC_VERSION "0.13.1"
+#define SND_SOC_VERSION "0.13.2"
 
 /*
  * Convenience kcontrol builders
-- 
1.5.3.5
