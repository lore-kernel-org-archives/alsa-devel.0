From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000570]: Sparse mixer for RME96
Date: Thu,  7 Oct 2004 10:59:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041007085948.C6BEE1F011@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2C2E8263
	for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2004 10:59:49 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id DF7372BA03
	for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2004 10:59:48 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000570
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     570
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-07-2004 10:59 CEST
Last Modified:              10-07-2004 10:59 CEST
======================================================================
Summary:                    Sparse mixer for RME96
Description: 
Noticed that almost all mixer controls was identified as PCM controles, so
I did a small patch.

Summary: RME96 Mixer fix

 - Fix mixer bugs

Signed-off-by: Peter Chrisensen <peter@developers.dk>
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-07-04 10:59 ungod          New Bug                                      
10-07-04 10:59 ungod          File Added: rme96-mixerfix.diff                    
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
