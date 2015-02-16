From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH] .gitignore: add test-driver
Date: Mon, 16 Feb 2015 21:47:58 +0200
Message-ID: <1424116078-26772-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A5089260692
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 20:48:02 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 05a2459..e1cc163 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@ Makefile
 libtool
 depcomp
 ltmain.sh
+test-driver
 version
 Makefile.in
 aclocal.m4
-- 
1.9.3
