From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000919]: Master volume doesn't control rear speakers...
Date: Fri, 18 Feb 2005 13:07:00 +0100
Message-ID: <64f4f8461e42aa420c84de7bcfd49f8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 405C423D
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2005 13:07:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=919> 
======================================================================
Reported By:                adamk75
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   919
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-18-2005 12:41 CET
Last Modified:              02-18-2005 13:06 CET
======================================================================
Summary:                    Master volume doesn't control rear speakers...
Description: 

If I adjust the master volume in alsamixer, the rear speaker volume isn't
affected at all.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-18-05 13:00 
----------------------------------------------------------------------
It's a feature of ac97 codec.  Not a bug.

----------------------------------------------------------------------
 adamk75 - 02-18-05 13:06 
----------------------------------------------------------------------
Having a master volume control that doesn't actually control the master
volume is a feature?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-05 12:41 adamk75        New Issue                                    
02-18-05 13:00 tiwai          Note Added: 0003650                          
02-18-05 13:06 adamk75        Note Added: 0003651                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
