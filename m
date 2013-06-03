From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH] ASoC: dwc: Folder path correction in file
	header.
Date: Mon, 3 Jun 2013 10:23:49 +0530
Message-ID: <1370235229-10631-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
 [207.126.144.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B000261651
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 06:53:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: Rajeev Kumar <rajeevk-dlh.kumar@st.com>, alsa-devel@alsa-project.org, spear-devel@list.st.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Rajeev Kumar <rajeevk-dlh.kumar@st.com>

Folder path correction in file header.

Signed-off-by: Rajeev Kumar <rajeevk-dlh.kumar@st.com>
---
 sound/soc/dwc/designware_i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index deb30d5..a11050c 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -1,7 +1,7 @@
 /*
  * ALSA SoC Synopsys I2S Audio Layer
  *
- * sound/soc/spear/designware_i2s.c
+ * sound/soc/dwc/designware_i2s.c
  *
  * Copyright (C) 2010 ST Microelectronics
  * Rajeev Kumar <rajeev-dlh.kumar@st.com>
-- 
1.7.6.5
