From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Update links for Wolfson MAINTAINERS
	entry
Date: Wed,  6 Oct 2010 09:25:00 -0700
Message-ID: <1286382300-3236-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1286382300-3236-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD531103986
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 18:24:51 +0200 (CEST)
In-Reply-To: <1286382300-3236-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We also have a separate git for audio, and a generic page for all of our
drivers not just the PMICs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 MAINTAINERS |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c1180f..31306ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6412,8 +6412,9 @@ WOLFSON MICROELECTRONICS DRIVERS
 M:	Mark Brown <broonie@opensource.wolfsonmicro.com>
 M:	Ian Lartey <ian@opensource.wolfsonmicro.com>
 M:	Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
+T:	git git://opensource.wolfsonmicro.com/linux-2.6-asoc
 T:	git git://opensource.wolfsonmicro.com/linux-2.6-audioplus
-W:	http://opensource.wolfsonmicro.com/node/8
+W:	http://opensource.wolfsonmicro.com/content/linux-drivers-wolfson-devices
 S:	Supported
 F:	Documentation/hwmon/wm83??
 F:	drivers/leds/leds-wm83*.c
-- 
1.7.1
