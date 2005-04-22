From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000347]: Driver works with xmms, but not with kino or dvgrab
Date: Fri, 22 Apr 2005 14:07:36 +0200
Message-ID: <db13ead44398629b81fbfff6db046b56@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 835B21DE
	for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2005 14:07:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=347> 
======================================================================
Reported By:                winjer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   347
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.7
======================================================================
Date Submitted:             06-26-2004 14:44 CEST
Last Modified:              04-22-2005 14:07 CEST
======================================================================
Summary:                    Driver works with xmms, but not with kino or dvgrab
Description: 
I get fine sound playing with xmms, but when I try to grab dv via firewire
from my camcorder the sound is badly out of sync with the pictures and is
much slower.

When I switch to my second soundcard, an es1371, grabbing dv works
perfectly.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 21:01 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?
Do you have the necessary device files in /dev/snd/?
Are you using udev, devfs or static device files?

----------------------------------------------------------------------
 winjer - 04-22-05 14:07 
----------------------------------------------------------------------
This motherboard blew up a few weeks ago, so now I'm unable to test
unfortunately.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 14:44 winjer         New Issue                                    
06-26-04 14:44 winjer         Distribution              => Debian GNU/Linux
06-26-04 14:44 winjer         Kernel Version            => 2.6.7           
06-30-04 16:36 tiwai          Note Added: 0001358                          
07-04-04 16:21 winjer         Note Added: 0001380                          
04-07-05 21:01 jdthood        Note Added: 0004367                          
04-22-05 14:07 winjer         Note Added: 0004554                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
