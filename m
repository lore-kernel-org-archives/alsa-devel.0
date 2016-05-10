From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Add myself as reviewer of
	FSL/NXP SoC sound drivers" to the asoc tree
Date: Tue, 10 May 2016 19:50:11 +0100
Message-ID: <E1b0CjT-0000Sw-Gu@debutante>
References: <1462662292-7957-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AAFB267530
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:50:21 +0200 (CEST)
In-Reply-To: <1462662292-7957-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Add myself as reviewer of FSL/NXP SoC sound drivers

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

>From aeea2fdd9b623fcd6991ac3617ef6a3b646c2899 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sat, 7 May 2016 20:04:52 -0300
Subject: [PATCH] MAINTAINERS: Add myself as reviewer of FSL/NXP SoC sound
 drivers

I would like to help reviewing FSL/NXP SoC sound drivers.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7c88eb..734bd0dfc49e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4661,6 +4661,7 @@ FREESCALE SOC SOUND DRIVERS
 M:	Timur Tabi <timur@tabi.org>
 M:	Nicolin Chen <nicoleotsuka@gmail.com>
 M:	Xiubo Li <Xiubo.Lee@gmail.com>
+R:	Fabio Estevam <fabio.estevam@nxp.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
-- 
2.8.1
