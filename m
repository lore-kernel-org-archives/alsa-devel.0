From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000537]: VIA VT8237: rear L/R switched with Center/LFE
Date: Fri, 24 Sep 2004 19:50:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924175058.015864B013@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 41AD02A4
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 19:50:58 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 11CCC2742C
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 19:50:58 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000537
======================================================================
Reported By:                gertverv
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     537
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             09-24-2004 19:41 CEST
Last Modified:              09-24-2004 19:50 CEST
======================================================================
Summary:                    VIA VT8237: rear L/R switched with Center/LFE
Description: 
While playing back 5.1 audio, it looks like the rear L/R channels are
swapped with the Center/LFE channels. The rear L/R and Center/LFE are
connected via Gigabyte Surround-Kit.


======================================================================

----------------------------------------------------------------------
 gertverv - 09-24-2004 19:50 CEST 
----------------------------------------------------------------------
Forgot to mention, 5.1 audio works correctly when using Windows XP on this
machine

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 19:41 gertverv       New Bug                                      
09-24-04 19:41 gertverv       Distribution              => Fedora Core 2   
09-24-04 19:41 gertverv       Kernel Version            => 2.6.8.1         
09-24-04 19:50 gertverv       Bugnote Added: 0001903                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
