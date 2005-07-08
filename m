From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001222]: typo in info.c
Date: Fri, 8 Jul 2005 14:53:57 +0200
Message-ID: <da1c80dc414e314fe8500a1372540082@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B0E317C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 14:53:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1222> 
======================================================================
Reported By:                Henne
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1222
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-30-2005 12:38 CEST
Last Modified:              07-08-2005 14:53 CEST
======================================================================
Summary:                    typo in info.c
Description: 
Little typo in info.c in the kerneldocs of snd_info_get_str().
Patch added.
======================================================================

----------------------------------------------------------------------
 Henne - 06-30-05 12:45 
----------------------------------------------------------------------
Oops, forgot a whitespace. Take info_c.diff.

----------------------------------------------------------------------
 tiwai - 07-08-05 14:53 
----------------------------------------------------------------------
Thanks, applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-30-05 12:38 Henne          New Issue                                    
06-30-05 12:38 Henne          File Added: info_patch.diff                    
06-30-05 12:45 Henne          Note Added: 0005324                          
06-30-05 12:45 Henne          Issue Monitored: Henne                       
06-30-05 12:47 Henne          File Added: info_c.diff                      
07-08-05 14:53 tiwai          Status                   new => resolved     
07-08-05 14:53 tiwai          Resolution               open => fixed       
07-08-05 14:53 tiwai          Assigned To               => tiwai           
07-08-05 14:53 tiwai          Note Added: 0005429                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
