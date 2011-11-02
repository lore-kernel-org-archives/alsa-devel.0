From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Update git repository URL
Date: Wed,  2 Nov 2011 21:37:59 +0000
Message-ID: <1320269880-31328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B3EA0244F9
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 22:38:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Remove the -2.6 from the name.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bbf42cd..63b58dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6001,7 +6001,7 @@ F:	sound/
 SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
 M:	Liam Girdwood <lrg@ti.com>
 M:	Mark Brown <broonie@opensource.wolfsonmicro.com>
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://alsa-project.org/main/index.php/ASoC
 S:	Supported
-- 
1.7.7
