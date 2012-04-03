From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] MAINTAINERS: Add missing ASoC OMAP
	co-maintainer
Date: Tue,  3 Apr 2012 09:45:43 +0300
Message-ID: <1333435543-21045-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ACFD24511
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 08:46:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Peter Ujfalusi has been co-maintaining sound/soc/omap/ for years but
was missing from this MAINTAINERS entry.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eecf344..85c599b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4807,6 +4807,7 @@ F:	arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
 F:	arch/arm/mach-omap2/clockdomain44xx.c
 
 OMAP AUDIO SUPPORT
+M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
 M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
 L:	alsa-devel@alsa-project.org (subscribers-only)
 L:	linux-omap@vger.kernel.org
-- 
1.7.9.1
