From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000905]: Creative Labs SB Audigy LS  uses snd-ca0106 driver
Date: Sat, 12 Feb 2005 23:46:09 +0100
Message-ID: <a020e31ba88f76e035cd75026c8b5f23@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 84920202
	for <alsa-devel@alsa-project.org>; Sat, 12 Feb 2005 23:46:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=905> 
======================================================================
Reported By:                adaviel
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   905
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-12-2005 23:46 CET
Last Modified:              02-12-2005 23:46 CET
======================================================================
Summary:                    Creative Labs SB Audigy LS  uses snd-ca0106 driver
Description: 
The Creative Labs SB card identified by
PCI Class 0401: 1102:0007
is supported by the 
snd-ca0106 driver (not audigyls as implied by the current matrix)

My current system (FCI) says it's an unknown device. The user said it 
was an SB Live. But 
http://pciids.sourceforge.net/iii/?i=1102
says it's an SB Audigy LS, so I guess that's what it is ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-05 23:46 adaviel        New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
