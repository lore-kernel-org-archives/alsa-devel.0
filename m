From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: Samsung: Fix a trivial typo in audss
	documentation
Date: Thu, 11 Jul 2013 17:02:08 +0530
Message-ID: <1373542328-28428-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B4D42657CC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 13:47:57 +0200 (CEST)
Received: by mail-pb0-f42.google.com with SMTP id un1so7847759pbc.1
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 04:47:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, sbkim73@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Fixed a trivial typo.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/clock/clk-exynos-audss.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
index a120180..75e2e19 100644
--- a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
+++ b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
@@ -2,7 +2,7 @@
 
 The Samsung Audio Subsystem clock controller generates and supplies clocks
 to Audio Subsystem block available in the S5PV210 and Exynos SoCs. The clock
-binding described here is applicable to all SoC's in Exynos family.
+binding described here is applicable to all SoCs in Exynos family.
 
 Required Properties:
 
-- 
1.7.9.5
