From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000541]: Tascam US-122 drivers fails with jackd
Date: Sat, 25 Sep 2004 16:22:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040925142242.704A02014F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C18FB217
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 16:22:42 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000541
======================================================================
Reported By:                roswel
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Bug ID:                     541
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             Linux 2.6.9-rc2
======================================================================
Date Submitted:             09-25-2004 16:11 CEST
Last Modified:              09-25-2004 16:22 CEST
======================================================================
Summary:                    Tascam US-122 drivers fails with jackd
Description: 
When i start jackd everything seems allright, but if i try to play some
audio through jack, like for example with alsaplayer or ardour, nothing
happen.
======================================================================

----------------------------------------------------------------------
 karsten - 09-25-2004 16:22 CEST 
----------------------------------------------------------------------
Does alsaplayer work in alsa mode?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 16:11 roswel         New Bug                                      
09-25-04 16:11 roswel         Distribution              => Debian          
09-25-04 16:11 roswel         Kernel Version            => Linux 2.6.9-rc2 
09-25-04 16:12 roswel         Bug Monitored: roswel                        
09-25-04 16:22 karsten        Bugnote Added: 0001910                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
