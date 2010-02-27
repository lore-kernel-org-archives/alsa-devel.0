From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 38/66] sound/oss/coproc.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:19 +0100
Message-ID: <1267289508-31031-39-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sound/oss/coproc.h:7: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 sound/oss/coproc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/oss/coproc.h b/sound/oss/coproc.h
index 7306346..7bec21b 100644
--- a/sound/oss/coproc.h
+++ b/sound/oss/coproc.h
@@ -4,7 +4,7 @@
  */
 
 /*
- * Coprocessor access types 
+ * Coprocessor access types
  */
 #define COPR_CUSTOM		0x0001	/* Custom applications */
 #define COPR_MIDI		0x0002	/* MIDI (MPU-401) emulation */
-- 
1.7.0.90.g251a4
