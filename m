From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 104/199] Documentation/sound/oss/Tropez+: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:54 +0200
Message-ID: <1274644376-24176-12-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/Tropez+:16: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/Tropez+ |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/sound/oss/Tropez+ b/Documentation/sound/oss/Tropez+
index b93a6b7..1fe82b3 100644
--- a/Documentation/sound/oss/Tropez+
+++ b/Documentation/sound/oss/Tropez+
@@ -13,7 +13,7 @@ driver:
   options cs4232 synthirq=9 synthio=0x200 io=0x530 irq=5 dma=1 dma2=0
   options opl3 io=0x388
 
-Things to note: 
+Things to note:
 
        the wavefront options "io" and "irq" ***MUST*** match the "synthio"
        and "synthirq" cs4232 options.
-- 
1.7.1.251.gf80a2

