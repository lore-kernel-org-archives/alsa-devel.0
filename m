From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000800]: Sound is Corrupted or terribe quality.
Date: Fri, 18 Mar 2005 18:23:37 +0100
Message-ID: <b07c701c0d9876e7c67a8d9e93c4e77c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9BDCD243
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2005 18:23:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=800> 
======================================================================
Reported By:                abonilla
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   800
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             01-10-2005 03:20 CET
Last Modified:              03-18-2005 18:23 CET
======================================================================
Summary:                    Sound is Corrupted or terribe quality.
Description: 
Sound goes out just like if the jack was not propperly plugged. bad Sound
Quality.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-16-05 13:27 
----------------------------------------------------------------------
It seems that this problem persists in 1.0.8.

--- Forwarded from http://bugs.debian.org/299459 ---

poor quality problem: When I play any sound file I hear this sound and 
rustle.

> Can you describe the problem in more detail?  Does changing the output
> level of the tuner (if you have some way of doing this) make any
> difference?

Changing volume level only regulated sound and rustle volume.
This problem as seem re majority of sound file but not all (not all 
frequency ??).

If this is helpful I can send file, with recording sound with rustle.

----------------------------------------------------------------------
 tiwai - 03-18-05 18:23 
----------------------------------------------------------------------
How about 1.0.9rc1?  Many bugs have been fixed for hda driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 03:20 abonilla       New Issue                                    
01-10-05 03:20 abonilla       Distribution              => Debian          
01-10-05 03:20 abonilla       Kernel Version            => 2.6.9           
01-10-05 14:56 tiwai          Note Added: 0003134                          
03-16-05 13:27 jdthood        Note Added: 0003956                          
03-18-05 18:23 tiwai          Note Added: 0004003                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
