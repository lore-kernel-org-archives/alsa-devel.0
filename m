From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000968]: arecord/aplay 24-bit nonstandard?
Date: Fri, 18 Mar 2005 18:15:34 +0100
Message-ID: <110581ae775599ed30b9ace400679bfe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3A045243
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2005 18:15:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=968> 
======================================================================
Reported By:                ScottHelmke
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   968
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-07-2005 18:11 CET
Last Modified:              03-18-2005 18:15 CET
======================================================================
Summary:                    arecord/aplay 24-bit nonstandard?
Description: 
Using arecord with S24_LE resolution, later tried to import files into
Ardour.  Apparently the 24-bit implemenation by arecord is faulty.  16 and
32 bit audio from arecord imported just fine.  Ardour developers say that
problem is with arecord.


======================================================================

----------------------------------------------------------------------
 ScottHelmke - 03-17-05 07:32 
----------------------------------------------------------------------
S24_3LE works fine with Ardour - thanks!

----------------------------------------------------------------------
 tiwai - 03-18-05 18:15 
----------------------------------------------------------------------
OK, closing this now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-05 18:11 ScottHelmke    New Issue                                    
03-07-05 20:52 perex          Note Added: 0003808                          
03-07-05 20:58 ScottHelmke    Note Added: 0003810                          
03-09-05 18:38 tiwai          Note Added: 0003831                          
03-17-05 07:32 ScottHelmke    Note Added: 0003978                          
03-18-05 18:15 tiwai          Status                   new => resolved     
03-18-05 18:15 tiwai          Resolution               open => not an issue
03-18-05 18:15 tiwai          Assigned To               => tiwai           
03-18-05 18:15 tiwai          Note Added: 0004000                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
