From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/4] README: fix trailing spaces
Date: Tue, 13 Nov 2018 20:26:27 +0530
Message-ID: <20181113145628.21026-3-vkoul@kernel.org>
References: <20181113145628.21026-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id DDEEB267AA8
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

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 31b1e8b4f8c7..16c4aaf9fcf4 100644
--- a/README
+++ b/README
@@ -9,7 +9,7 @@ compressed APIs introduced in Linux 3.3
 This library provides the APIs to open a ALSA compressed device and read/write
 compressed data like MP3 etc to it.
 
-	This also includes a utility command line player (cplay) which demonstrates 
+	This also includes a utility command line player (cplay) which demonstrates
 the usage of this API. Currently this contains support for playing the mp3 format
 
 2. WHERE
@@ -29,5 +29,5 @@ alsa-devel@alsa-project.org OR send a PULL-REQUEST using github
 
 5. CREDITS
 - Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> for library design
-- Navjot Singh <navjot.singh@intel.com> for writing the mp3 parser code 
+- Navjot Singh <navjot.singh@intel.com> for writing the mp3 parser code
 
-- 
2.14.5
