From: bvrn3r <raceburner@gmx.at>
Subject: install problem
Date: Tue, 6 Mar 2012 15:12:57 +0000 (UTC)
Message-ID: <loom.20120306T161047-904@post.gmane.org>
References: <f1c120255a37689163b27e945f1f0270@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D2F7104545
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 17:10:05 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1S4wxf-0004Xz-68
	for alsa-devel@alsa-project.org; Tue, 06 Mar 2012 17:10:03 +0100
Received: from 95.0.97.38.dynamic.ttnet.com.tr
	([95.0.97.38.dynamic.ttnet.com.tr])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 17:10:03 +0100
Received: from raceburner by 95.0.97.38.dynamic.ttnet.com.tr with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 17:10:03 +0100
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

hi andrew,

I tried to install this patch but I always get this fail.

patching file sound/pci/hda/alc662_asus_nx5_quirks.c
can't find file to patch at input line 117
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/sound/pci/hda/alc662_quirks.c b/sound/pci/hda/alc662_quirks.c
|index e69a6ea..93fa802 100644
|--- a/sound/pci/hda/alc662_quirks.c
|+++ b/sound/pci/hda/alc662_quirks.c
--------------------------
File to patch:

so what can I do??????

thx
