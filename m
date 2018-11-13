From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/4] README: Update project github location
Date: Tue, 13 Nov 2018 20:26:26 +0530
Message-ID: <20181113145628.21026-2-vkoul@kernel.org>
References: <20181113145628.21026-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id DCEE1267AA7
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 16:32:34 +0100 (CET)
In-Reply-To: <20181113145628.21026-1-vkoul@kernel.org>
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
Cc: Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

alsa userspace is now moved to github, so update it in README

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 README | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 8ea6c26f5381..31b1e8b4f8c7 100644
--- a/README
+++ b/README
@@ -17,9 +17,11 @@ the usage of this API. Currently this contains support for playing the mp3 forma
 Git: git clone git://git.alsa-project.org/tinycompress.git
 Http: http://git.alsa-project.org/?p=tinycompress.git
 
+Github: https://github.com/alsa-project/tinycompress
+
 3. PATCHES
 	Please send any enhancements/fixes to alsa developer mailing list at:
-alsa-devel@alsa-project.org. 
+alsa-devel@alsa-project.org OR send a PULL-REQUEST using github
 
 4. LICENSE
 	tinycompress is provided under a dual BSD/LGPLv2.1 license.  When using or
-- 
2.14.5
