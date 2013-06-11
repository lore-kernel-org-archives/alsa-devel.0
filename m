From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH] ASoC: dwc: Folder path correction in file
	header.
Date: Tue, 11 Jun 2013 09:29:08 +0530
Message-ID: <1370923148-19398-2-git-send-email-rajeev-dlh.kumar@st.com>
References: <1370923148-19398-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog124.obsmtp.com (eu1sys200aog124.obsmtp.com
 [207.126.144.157])
 by alsa0.perex.cz (Postfix) with ESMTP id F354E261A1D
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 05:59:13 +0200 (CEST)
In-Reply-To: <1370923148-19398-1-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, Rajeev Kumar <rajeevk-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

From: Rajeev Kumar <rajeevk-dlh.kumar@st.com>

Folder path correction in file header.

Signed-off-by: Rajeev Kumar <rajeevk-dlh.kumar@st.com>
---
 sound/soc/dwc/designware_i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index deb975e..6ce92bc 100644
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
1.6.0.2
