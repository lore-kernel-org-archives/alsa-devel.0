From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 4/4] snd-usb-caiaq: Bump version number to
	1.3.20
Date: Fri, 25 Sep 2009 16:22:18 +0100
Message-ID: <1253892138-10827-4-git-send-email-mark@pogo.org.uk>
References: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
	<1253892138-10827-1-git-send-email-mark@pogo.org.uk>
	<1253892138-10827-2-git-send-email-mark@pogo.org.uk>
	<1253892138-10827-3-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 14F2310380A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 17:22:19 +0200 (CEST)
In-Reply-To: <1253892138-10827-3-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

---
 sound/usb/caiaq/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 83e6c13..a3f02dd 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.19");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.20");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
-- 
1.6.4.4
