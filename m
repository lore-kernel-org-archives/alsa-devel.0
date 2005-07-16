From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001265]: ALSA sound system is not working properly on VIA (8237) motherboards
Date: Sat, 16 Jul 2005 22:57:08 +0200
Message-ID: <e4622ad8c176dc795346c22c227dd26e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E89AB198
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 22:57:08 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1265> 
======================================================================
Reported By:                hanssh64
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1265
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse Professional
Kernel Version:             Linux hoth 2.6.8-24.16-default
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Jun 2 12:09:57 UTC
2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             07-16-2005 22:57 CEST
Last Modified:              07-16-2005 22:57 CEST
======================================================================
Summary:                    ALSA sound system is not working properly on VIA
(8237) motherboards
Description: 
The aplay-command never plays a sound file to the the end but keeps
repeating the first section
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1#1 sec) over and over
again. It never stops.
Eventually You end up with many aplay processes on the compoter playing
and mixins its sound over and over again. 

This leaves it impossible to use any sound produced by movieplayer or
system etc. 

However, it is possilbe to play a CD. But impossible to play a DVD. For a
fix/temporary work around solution, se Additional Information below. 

Hardware information inluded in file. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 22:57 hanssh64       New Issue                                    
07-16-05 22:57 hanssh64       File Added: info.txt                         
07-16-05 22:57 hanssh64       Distribution              => Suse Professional
07-16-05 22:57 hanssh64       Kernel Version            => Linux hoth
2.6.8-24.16-default https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu
Jun 2 12:09:57 UTC 2005 i686 i686 i386 GNU/Linux
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
