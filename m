From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC: MAINTAINERS: Add maintainer for TI
	LM49453 Audio codec driver
Date: Mon, 2 Apr 2012 20:02:31 +0530
Message-ID: <1333377151-26872-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 23FC42433A
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 16:31:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

From: M R Swami Reddy <mr.swami.reddy@ti.com>

I will be supporting the TI LM49453 audio driver and also a few new TI codec
drivers, that are currently in development and will be upstreamed shortly.

Signed-off-by: M R Swami Reddy <mr.swami.reddy@ti.com>
---

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eecf344..cc9e035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6664,6 +6664,12 @@ 
 
+TI LM49xxx FAMILY ASoC CODEC DRIVERS
+M:	M R Swami Reddy <mr.swami.reddy@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/codecs/lm49453*
+
 TI TWL4030 SERIES SOC CODEC DRIVER
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
