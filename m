From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 5/5] ALSA: snd_usb_caiaq: bump version number
Date: Sat, 30 May 2009 22:25:23 +0200
Message-ID: <1243715123-16414-5-git-send-email-daniel@caiaq.de>
References: <y> <1243715123-16414-1-git-send-email-daniel@caiaq.de>
	<1243715123-16414-2-git-send-email-daniel@caiaq.de>
	<1243715123-16414-3-git-send-email-daniel@caiaq.de>
	<1243715123-16414-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D7DCE2433E
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 22:25:39 +0200 (CEST)
In-Reply-To: <1243715123-16414-4-git-send-email-daniel@caiaq.de>
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
 sound/usb/caiaq/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index e920855..24355f5 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.14");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.15");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
-- 
1.6.3.1
