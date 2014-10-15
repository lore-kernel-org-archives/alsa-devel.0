From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5677: Revise the typo
Date: Wed, 15 Oct 2014 18:02:14 +0800
Message-ID: <1413367334-12615-2-git-send-email-oder_chiou@realtek.com>
References: <1413367334-12615-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 830DA26051C
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 12:02:37 +0200 (CEST)
In-Reply-To: <1413367334-12615-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Revise the typo.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677-spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677-spi.h b/sound/soc/codecs/rt5677-spi.h
index 7528bfd..ec41b2b 100644
--- a/sound/soc/codecs/rt5677-spi.h
+++ b/sound/soc/codecs/rt5677-spi.h
@@ -9,8 +9,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __RT5671_SPI_H__
-#define __RT5671_SPI_H__
+#ifndef __RT5677_SPI_H__
+#define __RT5677_SPI_H__
 
 #define RT5677_SPI_BUF_LEN 240
 #define RT5677_SPI_CMD_BURST_WRITE 0x05
-- 
1.8.1.1.439.g50a6b54
