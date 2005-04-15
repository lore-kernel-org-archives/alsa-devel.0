From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001054]: Alsa Segmentation Fault
Date: Fri, 15 Apr 2005 22:55:38 +0200
Message-ID: <8e0336d11ef8d57a49c6ffc02de430cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B987B219
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2005 22:55:38 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1054> 
======================================================================
Reported By:                bultom
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1054
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo linux
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-15-2005 02:39 CEST
Last Modified:              04-15-2005 22:55 CEST
======================================================================
Summary:                    Alsa Segmentation Fault
Description: 
Alsa driver make all my application who use it crashing ( compiled built in
my kernel )
======================================================================

----------------------------------------------------------------------
 bultom - 04-15-05 22:55 
----------------------------------------------------------------------
I've found the bug solution , i've just to re compile all apps who use alsa
cause they have been compiled with alsa 1.0.6 and now i'm in 1.0.8

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-05 02:39 bultom         New Issue                                    
04-15-05 02:39 bultom         Distribution              => Gentoo linux    
04-15-05 02:39 bultom         Kernel Version            => 2.6.11          
04-15-05 02:41 bultom         Issue Monitored: bultom                      
04-15-05 22:55 bultom         Note Added: 0004503                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
