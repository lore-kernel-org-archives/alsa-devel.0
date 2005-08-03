From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001299]: mixed sound drained about 20db at the line-out until removal of driver
Date: Wed, 3 Aug 2005 12:05:42 +0200
Message-ID: <607f382f068960e07d6225180b241f25@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DB6C195
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 12:05:42 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1299> 
======================================================================
Reported By:                schorpp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1299
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               debian sarge-sid
Kernel Version:             2.6.12.0
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-02-2005 10:42 CEST
Last Modified:              08-03-2005 12:05 CEST
======================================================================
Summary:                    mixed sound drained about 20db at the line-out until
removal of driver
Description: 
with the driver working, output volume is about 20db too low.


======================================================================

----------------------------------------------------------------------
 schorpp - 08-02-05 15:29 
----------------------------------------------------------------------
CLOSED

was a mixer problem.

sry
y
tom

----------------------------------------------------------------------
 tiwai - 08-03-05 12:05 
----------------------------------------------------------------------
OK, resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 10:42 schorpp        New Issue                                    
08-02-05 10:42 schorpp        Distribution              => debian sarge-sid
08-02-05 10:42 schorpp        Kernel Version            => 2.6.12.0        
08-02-05 10:54 schorpp        Note Added: 0005603                          
08-02-05 11:37 schorpp        Note Added: 0005604                          
08-02-05 15:29 schorpp        Note Added: 0005605                          
08-03-05 12:05 tiwai          Status                   assigned => resolved
08-03-05 12:05 tiwai          Resolution               open => not an issue
08-03-05 12:05 tiwai          Note Added: 0005617                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
