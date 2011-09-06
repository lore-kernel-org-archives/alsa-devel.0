From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/4] intel_sst: fix comment typo
Date: Tue, 06 Sep 2011 15:21:29 +0800
Message-ID: <20110906072129.7310.6960.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 30DBE10385F
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 09:19:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/staging/intel_sst/intel_sst_dsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/intel_sst/intel_sst_dsp.c b/drivers/staging/intel_sst/intel_sst_dsp.c
index a89e1ad..426d2b9 100644
--- a/drivers/staging/intel_sst/intel_sst_dsp.c
+++ b/drivers/staging/intel_sst/intel_sst_dsp.c
@@ -104,7 +104,7 @@ static int sst_start_mrst(void)
 /**
  * sst_start_medfield - Start the SST DSP processor
  *
- * This starts the DSP in MRST platfroms
+ * This starts the DSP in Medfield platfroms
  */
 static int sst_start_medfield(void)
 {
