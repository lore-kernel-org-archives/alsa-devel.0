From: zengzm.kernel@gmail.com
Subject: [PATCH 2/2] ASoC: sgtl5000: update author email address
Date: Mon, 16 Jan 2012 15:18:11 +0800
Message-ID: <1326698291-26194-1-git-send-email-zengzm.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AF91244CF
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 08:18:19 +0100 (CET)
Received: by iakk32 with SMTP id k32so2460481iak.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2012 23:18:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, zengzm.kernel@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Zeng Zhaoming <zengzm.kernel@gmail.com>

Update MODULE_AUTHOR email address.

Signed-off-by: Zeng Zhaoming <zengzm.kernel@gmail.com>
---
 sound/soc/codecs/sgtl5000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 71df1fe..a87e9ee 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1464,5 +1464,5 @@ static void __exit sgtl5000_exit(void)
 module_exit(sgtl5000_exit);
 
 MODULE_DESCRIPTION("Freescale SGTL5000 ALSA SoC Codec Driver");
-MODULE_AUTHOR("Zeng Zhaoming <zhaoming.zeng@freescale.com>");
+MODULE_AUTHOR("Zeng Zhaoming <zengzm.kernel@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
1.7.6.1.385.gb7fcd0
