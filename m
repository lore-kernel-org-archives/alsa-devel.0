From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 106/199] Documentation/sound/oss/WaveArtist: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:55 +0200
Message-ID: <1274644376-24176-13-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/WaveArtist:101: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/WaveArtist |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/oss/WaveArtist b/Documentation/sound/oss/WaveArtist
index f4f3407..b368045 100644
--- a/Documentation/sound/oss/WaveArtist
+++ b/Documentation/sound/oss/WaveArtist
@@ -1,4 +1,3 @@
-
  (the following is from the armlinux CVS)
 
  WaveArtist mixer and volume levels can be accessed via these commands:
@@ -98,7 +97,7 @@
        *------->mute>--> Gain >--> X >-->AMP>--*
        |       +----+  +------+  |   |  +-^-+  |
        |                         |   |    |    |
-       |       +----+  +------+  |   |  r2b1-3 |  
+       |       +----+  +------+  |   |  r2b1-3 |
        | /----->mute>--> Gain >--> E |         |
        | |     +----+  +------+  |   |         |
        | |                       |   |         |
-- 
1.7.1.251.gf80a2

