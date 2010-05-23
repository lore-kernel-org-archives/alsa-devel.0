From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 103/199] Documentation/sound/oss/SoundPro: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:53 +0200
Message-ID: <1274644376-24176-11-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/SoundPro:77: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/SoundPro |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/sound/oss/SoundPro b/Documentation/sound/oss/SoundPro
index 9d4db1f..4c1a538 100644
--- a/Documentation/sound/oss/SoundPro
+++ b/Documentation/sound/oss/SoundPro
@@ -74,7 +74,7 @@ butting heads with another device.
 If you do not see the chipset version message, and none of the other
 messages present in the system log are helpful, try adding 'debug=1'
 to the ad1848 parameters, email me the syslog results and I'll do
-my best to help. 
+my best to help.
 
 Lastly, if you're using modules and want to set up automatic module
 loading with kmod, the kernel module loader, here is the section I
-- 
1.7.1.251.gf80a2

