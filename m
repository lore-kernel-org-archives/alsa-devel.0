From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 102/199] Documentation/sound/oss/README.ymfsb: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:52 +0200
Message-ID: <1274644376-24176-10-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/README.ymfsb:72: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/README.ymfsb |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/sound/oss/README.ymfsb b/Documentation/sound/oss/README.ymfsb
index af8a7d3..138f553 100644
--- a/Documentation/sound/oss/README.ymfsb
+++ b/Documentation/sound/oss/README.ymfsb
@@ -69,7 +69,7 @@ SPDIF OUT
 
   With installing modules with option 'spdif_out=1', you can enjoy your
  sounds from SPDIF-out of your card (if it had).
- Its Fs is fixed to 48kHz (It never means the sample frequency become 
+ Its Fs is fixed to 48kHz (It never means the sample frequency become
  up to 48kHz. All sounds via SPDIF-out also 22kHz samples). So your
  digital-in capable components has to be able to handle 48kHz Fs.
 
-- 
1.7.1.251.gf80a2

