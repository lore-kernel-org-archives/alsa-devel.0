From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/3] snd-usb-caiaq: bump version number
Date: Wed, 18 Mar 2009 11:03:55 +0100
Message-ID: <1237370635-27728-4-git-send-email-daniel@caiaq.de>
References: <1237370635-27728-1-git-send-email-daniel@caiaq.de>
	<1237370635-27728-2-git-send-email-daniel@caiaq.de>
	<1237370635-27728-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BE011038DC
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 11:04:08 +0100 (CET)
In-Reply-To: <1237370635-27728-3-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/caiaq-device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 8af47c2..cf573a9 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.12");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.13");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
-- 
1.6.2
