From: noreply@alsa-project.org
Subject: [ALSA - driver 0000179]: unresolved symbols
Date: Fri, 16 Jul 2004 12:54:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105445.76F3D26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DE48C22B
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:54:45 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000179
======================================================================
Reported By:                pohl457
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     179
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Debian Linux 3.0r2 (woody)
Kernel Version:             Kernel 2.2.22
======================================================================
Date Submitted:             04-02-2004 20:03 CEST
Last Modified:              07-16-2004 12:54 CEST
======================================================================
Summary:                    unresolved symbols
Description: 
after compiling the alsa driver on a frehly configured kernel source 2.2.22
I have unresolved symbols. With kernel 2.4.20 (Pentium 4) I have no
problems
======================================================================

----------------------------------------------------------------------
 perex - 04-03-2004 13:56 CEST 
----------------------------------------------------------------------
Try alsa-driver 1.0.4.

----------------------------------------------------------------------
 pohl457 - 04-06-2004 21:11 CEST 
----------------------------------------------------------------------
compile problem solved with alsa 1.0.4
thank you.

----------------------------------------------------------------------
 perex - 04-07-2004 19:46 CEST 
----------------------------------------------------------------------
Fixed in newer release.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-02-04 20:03 pohl457        New Bug                                      
04-02-04 20:03 pohl457        Distribution              => Debian Linux 3.0r2 (woody)
04-02-04 20:03 pohl457        Kernel Version            => Kernel 2.2.22   
04-03-04 13:56 perex          Bugnote Added: 0000735                       
04-06-04 21:11 pohl457        Bugnote Added: 0000758                       
04-07-04 19:46 perex          Bugnote Added: 0000761                       
04-07-04 19:46 perex          Resolution               open => fixed       
04-07-04 19:46 perex          Status                   assigned => resolved
07-16-04 12:54 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
