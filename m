From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000499]: no sound through line in
Date: Mon, 13 Sep 2004 19:45:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913174510.CC29113001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2C65A295
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 19:45:11 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id DA8E623D14
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2004 19:45:10 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000499
======================================================================
Reported By:                hombergp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     499
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.1
Kernel Version:             2.6.5-108
======================================================================
Date Submitted:             09-13-2004 18:03 CEST
Last Modified:              09-13-2004 19:45 CEST
======================================================================
Summary:                    no sound through line in
Description: 
Since I upgraded to SuSE 9.1 with alsa 1.0.3
I cannot use the line in (external mini jackplug)
input anymore.
No sound is reproduced through this line in interface.
I used the line input before under SuSE 8.2 successfully.

======================================================================

----------------------------------------------------------------------
 hombergp - 09-13-2004 19:45 CEST 
----------------------------------------------------------------------
Problem resolved. Some mixers do not show mute button ;-)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-13-04 18:03 hombergp       New Bug                                      
09-13-04 18:03 hombergp       Distribution              => SuSE 9.1        
09-13-04 18:03 hombergp       Kernel Version            => 2.6.5-108       
09-13-04 18:03 hombergp       Bug Monitored: hombergp                      
09-13-04 18:04 hombergp       Bug End Monitor: hombergp                    
09-13-04 19:45 hombergp       Bugnote Added: 0001754                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
