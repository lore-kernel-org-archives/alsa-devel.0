From: Anish Kumar <yesanishhere@gmail.com>
Subject: [PATCH] MAINTAINERS: Add maintainer for maxim codecs
Date: Mon,  2 Mar 2015 15:16:10 -0800
Message-ID: <1425338170-30924-1-git-send-email-yesanishhere@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, nitin.mittal@maximintegrated.com, Anish Kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds maintainer for maxim audio codecs.
Signed-off-by: Anish Kumar <yesanishhere@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bdd7a7..2128586 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7387,6 +7387,13 @@ S:	Supported
 F:	sound/soc/
 F:	include/sound/soc*
 
+MAXIM INTEGRATED SOC CODEC DRIVER
+M:	Anish Kumar <yesanishhere@gmail.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/codecs/max*
+F:	include/sound/max*
+
 SPARC + UltraSPARC (sparc/sparc64)
 M:	"David S. Miller" <davem@davemloft.net>
 L:	sparclinux@vger.kernel.org
-- 
1.9.3
