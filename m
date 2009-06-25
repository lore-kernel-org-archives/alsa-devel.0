From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] MAINTAINERS: Add entry for twl4030 series
	soc codec driver
Date: Thu, 25 Jun 2009 13:26:09 +0300
Message-ID: <1245925569-23641-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1245925569-23641-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 5998E103877
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:26:36 +0200 (CEST)
In-Reply-To: <1245925569-23641-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, steve@sakoman.com
List-Id: alsa-devel@alsa-project.org

New MAINTAINERS entry for twl4030 series soc codec driver
with Peter Ujfalusi as maintainer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ae5a81..031a70d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5523,6 +5523,13 @@ M:	dsaxena@plexity.net
 S:	Maintained
 F:	drivers/char/hw_random/omap-rng.c
 
+TI TWL4030 SERIES SOC CODEC DRIVER
+P:	Peter Ujfalusi
+M:	peter.ujfalusi@nokia.com
+L:	alsa-devel@alsa-project.org
+S:	Maintained
+F:	sound/soc/codecs/twl4030*
+
 TIPC NETWORK LAYER
 P:	Per Liden
 M:	per.liden@ericsson.com
-- 
1.6.3.3
