From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000575]: alsa mixer settings and sporatic loss of sound
Date: Sat,  9 Oct 2004 18:09:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041009160947.F3ADE3E00F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 41973291
	for <alsa-devel@alsa-project.org>; Sat,  9 Oct 2004 18:09:48 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 114F32CFCA
	for <alsa-devel@alsa-project.org>; Sat,  9 Oct 2004 18:09:48 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000575
======================================================================
Reported By:                grapnell
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     575
Category:                   alsamixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-09-2004 18:09 CEST
Last Modified:              10-09-2004 18:09 CEST
======================================================================
Summary:                    alsa mixer settings and sporatic loss of sound
Description: 
one thing i have noticed about alsa, is a very small event can trigger a
major crash of alsa, such as the forced quit of a non-responding
application that uses sound etc will cause alsa to crash, and I cannot get
sound support to come back unless I reboot. also, the mixer settings will
not save, I have to unmute and restore all the mixer settings manually
everytime I reboot.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 18:09 grapnell       New Bug                                      
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
