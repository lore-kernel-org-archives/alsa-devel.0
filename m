From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000139]: When sound starts playing musik the mouse lost sync ....
Date: Thu, 10 Mar 2005 15:14:47 +0100
Message-ID: <01852aea9657627b52f1fe1c7dbca2c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 014311C5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:14:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=139> 
======================================================================
Reported By:                neo2k
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   139
Category:                   PCI - intel8x0
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               archlinux
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-15-2004 18:33 CET
Last Modified:              03-10-2005 15:14 CET
======================================================================
Summary:                    When sound starts playing musik the mouse lost sync
....
Description: 
everytime when i start playing new sound track (mp3,ogg...)
the ps/2-mouse lost sync and i can´t use the mouse for 2-3 sec.... (it´s
only with the nfroce 2 sound driver, my old soundblaster 16 doesn´t have
this problem)
======================================================================

----------------------------------------------------------------------
 perex - 03-15-04 20:56 
----------------------------------------------------------------------
Try latest 2.6.4-mm kernels.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:14 
----------------------------------------------------------------------
Submitter: Do you still see this problem (of the mouse not being
usable for 2 to 3 seconds after starting to play a sound)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-04 18:33 neo2k          New Issue                                    
03-15-04 18:33 neo2k          Distribution              => archlinux       
03-15-04 18:33 neo2k          Kernel Version            => 2.6.4           
03-15-04 20:56 perex          Note Added: 0000620                          
03-10-05 15:14 jdthood        Note Added: 0003859                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
