From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 29/30] ALSA: HDA VIA: comments: update
 copyright, changeset, etc.
Date: Sat, 10 Oct 2009 19:08:52 +0800
Message-ID: <4AD06B44.4050002@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id C35AC103C04
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:08:45 +0200 (CEST)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: comments: update copyright, changeset, etc.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1,10 +1,10 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
  *
- * HD audio interface patch for VIA VT1702/VT1708/VT1709 codec
+ * HD audio interface patch for VIA VT17xx/VT18xx/VT20xx codec
  *
- * Copyright (c) 2006-2008 Lydia Wang <lydiawang@viatech.com>
- *			   Takashi Iwai <tiwai@suse.de>
+ *  (C) 2006-2009 VIA Technology, Inc.
+ *  (C) 2006-2008 Takashi Iwai <tiwai@suse.de>
  *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -36,6 +36,11 @@
 /* 2008-04-09  Lydia Wang  Add Independent HP feature                        */
 /* 2008-05-28  Lydia Wang  Add second S/PDIF Out support for VT1702	     */
 /* 2008-09-15  Logan Li    Add VT1708S Mic Boost workaround/backdoor	     */
+/* 2009-02-16  Logan Li	   Add support for VT1718S			     */
+/* 2009-03-13  Logan Li	   Add support for VT1716S			     */
+/* 2009-04-14  Lydai Wang  Add support for VT1828S and VT2020		     */
+/* 2009-07-08  Lydia Wang  Add support for VT2002P			     */
+/* 2009-07-21  Lydia Wang  Add support for VT1812			     */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
