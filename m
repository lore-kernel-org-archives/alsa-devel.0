From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000985]: hdspmixer mute/solo buttons not working
Date: Mon, 4 Jul 2005 08:40:17 +0200
Message-ID: <efdfbbbcd9de0493f1da10b88b55beb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4198B196
	for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2005 08:40:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=985> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   985
Category:                   hdsp progs
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-12-2005 19:43 CET
Last Modified:              07-04-2005 08:40 CEST
======================================================================
Summary:                    hdspmixer mute/solo buttons not working
Description: 
I think these used to work but when I tried them this morning they no
longer seem to work.
======================================================================

----------------------------------------------------------------------
 charbonnel - 07-04-05 08:40 
----------------------------------------------------------------------
Hi Mark,

Is this still an issue ?
You have to activate the global mute and/or solo buttons before the ones
on the tracks have any effect.
Also mute and solo only affect routing, not the recorded audio.

Thomas

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 19:43 Mark Knecht    New Issue                                    
07-04-05 08:40 charbonnel     Note Added: 0005380                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
