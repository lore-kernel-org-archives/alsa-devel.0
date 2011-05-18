From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/8] MAINTAINERS: Add entry for Native
	Instruments sound driver
Date: Wed, 18 May 2011 11:28:38 +0200
Message-ID: <1305710925-3857-2-git-send-email-zonque@gmail.com>
References: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 1878110383C
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:29:01 +0200 (CEST)
In-Reply-To: <1305710925-3857-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69f19f1..07d064d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4271,6 +4271,13 @@ M:	Tim Hockin <thockin@hockin.org>
 S:	Maintained
 F:	drivers/net/natsemi.c
 
+NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
+M:	Daniel Mack <zonque@gmail.com>
+S:	Maintained
+L:	alsa-devel@alsa-project.org
+W:	http://www.native-instruments.com
+F:	sound/usb/caiaq/
+
 NCP FILESYSTEM
 M:	Petr Vandrovec <petr@vandrovec.name>
 S:	Odd Fixes
-- 
1.7.5.1
