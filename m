From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000032]: PLS include this driver
Date: Thu, 10 Mar 2005 15:19:10 +0100
Message-ID: <89de215727cbcba52f40319842007f18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 88516157
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:19:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=32> 
======================================================================
Reported By:                cijoml
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   32
Category:                   OTHERS
Reproducibility:            have not tried
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-03-2004 10:11 CET
Last Modified:              03-10-2005 15:19 CET
======================================================================
Summary:                    PLS include this driver
Description: 
On this site, there is driver for bluez-sco. Could you pls include finally
into main ALSA tree? I use it about 4 mounths without any problem

http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
======================================================================

----------------------------------------------------------------------
 tiwai - 02-06-04 18:34 
----------------------------------------------------------------------
well, i didn't know of this patchset.
the code looks ok for merging to alsa-driver.
i don't think it will go to 2.6 kernel tree as it is, though, because
it would be easier to implement such a stuff on user-space.

if any new patch for ALSA 1.0.2 exists, i'll merge it.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:19 
----------------------------------------------------------------------
Did the submitted patch ever get applied?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-04 10:11 cijoml         New Issue                                    
02-03-04 10:11 cijoml         File Added: snd-bluez-sco-2003-09-15.tar.gz       
            
02-06-04 18:34 tiwai          Note Added: 0000197                          
03-10-05 15:19 jdthood        Note Added: 0003861                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
