From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000538]: error on loading modules
Date: Tue, 28 Sep 2004 19:25:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928172515.D74C746008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 17DE3316
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 19:25:16 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000538
======================================================================
Reported By:                microft
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     538
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware
Kernel Version:             2.4.26
======================================================================
Date Submitted:             09-24-2004 21:42 CEST
Last Modified:              09-28-2004 19:25 CEST
======================================================================
Summary:                    error on loading modules
Description: 
I just compiled and installed the drivers, lib and utils on my Asus S5200N,
according to the instructions on this page:
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Intel&card=i820&chip=i820&module=intel8x0#Inst


======================================================================

----------------------------------------------------------------------
 tiwai - 09-28-2004 19:25 CEST 
----------------------------------------------------------------------
Apparently you didn't specify (or have) the correct kernel source
tree corresponding to the running kernel.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 21:42 microft        New Bug                                      
09-24-04 21:42 microft        Distribution              => slackware       
09-24-04 21:42 microft        Kernel Version            => 2.4.26          
09-28-04 19:25 tiwai          Bugnote Added: 0001956                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
