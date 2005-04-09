From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000481]: IEC958 Output doesn't work
Date: Sat, 9 Apr 2005 16:23:54 +0200
Message-ID: <19c7db6092db5eee9db1f0f92c7a5e6e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3583624F
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 16:23:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=481> 
======================================================================
Reported By:                somnione
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   481
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               LFS
Kernel Version:             2.4.23
======================================================================
Date Submitted:             09-04-2004 13:17 CEST
Last Modified:              04-09-2005 16:23 CEST
======================================================================
Summary:                    IEC958 Output doesn't work
Description: 
I had Version 0.9.8 and in the mixer i could switch on "IEC 958 Output"
wich would activate the optical out on the card, but with version 1.0.6a
I'm missing this option and thus the card is silent via optical out. It
has "IEC958" but nothing happens.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000562 No AC3 sound playable through S/PDIF wi...
======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 16:23 
----------------------------------------------------------------------
Submitter: This appears to be the same problem as was reported in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=562.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-04-04 13:17 somnione       New Issue                                    
09-04-04 13:17 somnione       Distribution              => LFS             
09-04-04 13:17 somnione       Kernel Version            => 2.4.23          
04-09-05 16:20 jdthood        Relationship added       has duplicate 0000562
04-09-05 16:23 jdthood        Note Added: 0004411                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
