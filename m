From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Update email address for patches
	to Wolfson parts" to the asoc tree
Date: Wed, 24 May 2017 18:42:10 +0100
Message-ID: <E1dDaIU-0002uJ-5f@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 29698266CE7
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:42:17 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Update email address for patches to Wolfson parts

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3a1672bb0186e940fc8521d19069f57690e850c2 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 24 May 2017 11:01:32 +0100
Subject: [PATCH] MAINTAINERS: Update email address for patches to Wolfson
 parts

A somewhat overdue update of the address for sending patches on Wolfson
parts to since our acquision a couple of years ago by Cirrus Logic.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..517829e3bd1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13858,7 +13858,7 @@ S:	Odd fixes
 F:	drivers/net/wireless/wl3501*
 
 WOLFSON MICROELECTRONICS DRIVERS
-L:	patches@opensource.wolfsonmicro.com
+L:	patches@opensource.cirrus.com
 T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
-- 
2.11.0
