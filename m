From: Joe Perches <joe@perches.com>
Subject: [PATCH] MAINTAINERS - Update SOUND
Date: Wed, 15 Apr 2009 23:38:45 -0700
Message-ID: <1239863925.14053.3.camel@localhost>
References: <1239821506.26340.199.camel@localhost>
	 <s5h8wm12jts.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754640AbZDPGjQ@vger.kernel.org>
In-Reply-To: <s5h8wm12jts.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cb20d8..c81792f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5184,13 +5184,17 @@ F:	drivers/memstick/host/tifm_ms.c
 SOUND
 P:	Jaroslav Kysela
 M:	perex@perex.cz
 P:	Takashi Iwai
 M:	tiwai@suse.de
 L:	alsa-devel@alsa-project.org (subscribers-only)
+W:	http://www.alsa-project.org/main/index.php/Main_Page
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
 S:	Maintained
+F:	Documentation/sound/
+F:	include/sound/
 F:	sound/
 
 SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
 P:	Liam Girdwood
 M:	lrg@slimlogic.co.uk
 P:	Mark Brown
