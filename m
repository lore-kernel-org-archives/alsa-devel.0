From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Update email address for Vinod" to the
	asoc tree
Date: Thu, 26 Apr 2018 12:50:07 +0100
Message-ID: <E1fBfPb-0007H0-Uo@debutante>
References: <1524725090-20317-1-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1299071523545824675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF8D7267837
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:50:11 +0200 (CEST)
In-Reply-To: <1524725090-20317-1-git-send-email-vkoul@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============1299071523545824675==
Content-Type: text/plain

The patch

   ASoC: Update email address for Vinod

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 483abace7bdd31c527d821d3c28cb2879c84b1c8 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vkoul@kernel.org>
Date: Thu, 26 Apr 2018 12:14:50 +0530
Subject: [PATCH] ASoC: Update email address for Vinod

Update the email address for compressed audio maintainer
Also update .mailmap.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .mailmap    | 3 +++
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index e18cab73e209..4cb8bf0a8402 100644
--- a/.mailmap
+++ b/.mailmap
@@ -181,6 +181,9 @@ Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
+Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
+Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
+Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
 Viresh Kumar <vireshk@kernel.org> <viresh.kumar@st.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.linux@gmail.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.kumar2@arm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 98d14aee828a..2b62e6cf6b1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12925,7 +12925,7 @@ F:	include/uapi/sound/
 F:	sound/
 
 SOUND - COMPRESSED AUDIO
-M:	Vinod Koul <vinod.koul@intel.com>
+M:	Vinod Koul <vkoul@kernel.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Supported
-- 
2.17.0


--===============1299071523545824675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1299071523545824675==--
