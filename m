From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000972]: No sound after install...
Date: Wed, 9 Mar 2005 03:14:53 +0100
Message-ID: <6da48218d1021a1d3cd7aa9e605300da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C281173
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2005 03:14:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=972> 
======================================================================
Reported By:                rbechard1
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   972
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-08-2005 02:00 CET
Last Modified:              03-09-2005 03:14 CET
======================================================================
Summary:                    No sound after install...
Description: 
After following all of the install instructions included with the
documentation there is no sound from the sound card. The settings in
DiskDrake indicate that the sound card is using the correct driver and
alsaconf reconfigured it several times to no effect. I also check the
mixer outputs and nothing is muted.
======================================================================

----------------------------------------------------------------------
 fmoraes - 03-09-05 02:11 
----------------------------------------------------------------------
Do you have the /dev/snd/* devices?

Francisco

----------------------------------------------------------------------
 rbechard1 - 03-09-05 03:14 
----------------------------------------------------------------------
There is no /snd folder in my /dev directory...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 02:00 rbechard1      New Issue                                    
03-08-05 02:01 rbechard1      Issue Monitored: rbechard1                    
03-08-05 09:54 rbechard1      Note Added: 0003813                          
03-09-05 02:11 fmoraes        Note Added: 0003820                          
03-09-05 03:14 rbechard1      Note Added: 0003824                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
