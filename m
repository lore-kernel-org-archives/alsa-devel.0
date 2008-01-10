From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/17] Update MAINTAINERS for ALSA SoC
Date: Thu, 10 Jan 2008 13:16:59 +0000
Message-ID: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id E5C1E24464
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:17 +0100 (CET)
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

Add myself as a point of contact for the ALSA SoC subsystem and add a
reference to the development GIT tree.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 MAINTAINERS |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4f611c..10c3af3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3514,6 +3514,9 @@ S:	Maintained
 SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT
 P:	Liam Girdwood
 M:	liam.girdwood@wolfsonmicro.com
+P:	Mark Brown
+M:	broonie@opensource.wolfsonmicro.com
+T:	git opensource.wolfsonmicro.com/linux-2.6-asoc
 L:	alsa-devel@alsa-project.org (subscribers-only)
 S:	Supported
 
-- 
1.5.3.8
