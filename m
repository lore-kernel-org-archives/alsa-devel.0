From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001282]: LFE Volumne Control & Mute/Unmute not working
Date: Tue, 26 Jul 2005 23:59:00 +0200
Message-ID: <361fa1fe47eda3d154a5a24eff83d340@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5C1041D1
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 23:59:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1282> 
======================================================================
Reported By:                notz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1282
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-26-2005 23:58 CEST
Last Modified:              07-26-2005 23:58 CEST
======================================================================
Summary:                    LFE Volumne Control & Mute/Unmute not working
Description: 
if try to set lfe volume or unmute lfe control with alsamixer or amixer, my
changes always will be reverted and so i never geht any lfe output. if
have an aopen i915GM-HFS motherboard and use alsa kernel from 2005-07-12
(nitro5 kernel).

also capture volumne seems to work not ok. i have set it 11 percent. it's
the maxmium for me. higher values produces oddly noises.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-26-05 23:58 notz           New Issue                                    
07-26-05 23:58 notz           Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
