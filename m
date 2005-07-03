From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001229]: Can't modprobe sound module
Date: Sun, 3 Jul 2005 12:14:10 +0200
Message-ID: <a8662ed006e3e02c7a1dc220c024803e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B1DBC1AF
	for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2005 12:14:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1229> 
======================================================================
Reported By:                oui
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1229
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-03-2005 11:48 CEST
Last Modified:              07-03-2005 12:14 CEST
======================================================================
Summary:                    Can't modprobe sound module
Description: 
I use sound card Intel 82801DB AC'97 .I download alsa-driver ,alsa-lib and
alsa-util and follow your instruction but I can't modprobe intel8x0 it
said not found module device .Please tell me what I should do?
======================================================================

----------------------------------------------------------------------
 jcdutton - 07-03-05 12:14 
----------------------------------------------------------------------
modprobe snd-intel8x0
not
modprobe intel8x0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 11:48 oui            New Issue                                    
07-03-05 12:14 jcdutton       Note Added: 0005374                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
