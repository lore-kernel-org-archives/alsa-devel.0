From: David Lin <CTLIN0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8822: convert to SPDX identifiers
Date: Thu, 15 Nov 2018 17:49:13 +0800
Message-ID: <20181115094912.656-1-CTLIN0@nuvoton.com>
References: <20181115091446.32764-1-CTLIN0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server-codec (60-250-207-217.hinet-ip.hinet.net
 [60.250.207.217])
 by alsa0.perex.cz (Postfix) with ESMTP id DB785267AFB
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 10:50:39 +0100 (CET)
In-Reply-To: <20181115091446.32764-1-CTLIN0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, wtli@nuvoton.com, kchsu0@nuvoton.com, lgirdwood@gmail.com, yhchuang@nuvoton.com, David Lin <CTLIN0@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes typo in the comment.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
---
 sound/soc/codecs/nau8822.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8822.h b/sound/soc/codecs/nau8822.h
index d15afd782815..9c552983a293 100644
--- a/sound/soc/codecs/nau8822.h
+++ b/sound/soc/codecs/nau8822.h
@@ -5,7 +5,7 @@
  * Copyright 2017 Nuvoton Technology Crop.
  *
  * Author: David Lin <ctlin0@nuvoton.com>
- * Co-author: John Hsu <kchsu@nuvoton.com>
+ * Co-author: John Hsu <kchsu0@nuvoton.com>
  * Co-author: Seven Li <wtli@nuvoton.com>
  */
 
-- 
2.18.0
