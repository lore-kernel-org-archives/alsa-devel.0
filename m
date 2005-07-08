From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001233]: Please move aserver to alsa-utils
Date: Fri, 8 Jul 2005 13:47:07 +0200
Message-ID: <cc348aff4a5c89603f7d7dffa869b84e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B9B9174
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 13:47:07 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1233> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1233
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             07-05-2005 11:36 CEST
Last Modified:              07-08-2005 13:47 CEST
======================================================================
Summary:                    Please move aserver to alsa-utils
Description: 
In Debian, library packages may not contain executable binaries. 
Therefore, the Debian maintainers would like to move the aserver program
from the libasound2 package to the alsa-utils package.  This would be much
easier if the program were moved from (upstream) alsa-lib to (upstream)
alsa-utils; otherwise the Debian alsa-utils package has to be built from
both the alsa-utils and the alsa-lib tarballs.  Could you please move the
program?  Or is there some reason why the program has to be in alsa-lib
rather than in alsa-utils?
======================================================================

----------------------------------------------------------------------
 jdthood - 07-05-05 14:40 
----------------------------------------------------------------------
OK, thanks for the explanation.

----------------------------------------------------------------------
 jdthood - 07-08-05 13:47 
----------------------------------------------------------------------
Close

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-05-05 11:36 jdthood        New Issue                                    
07-05-05 13:58 perex          Note Added: 0005390                          
07-05-05 14:40 jdthood        Note Added: 0005391                          
07-05-05 14:40 jdthood        Status                   new => resolved     
07-05-05 14:40 jdthood        Resolution               open => won't fix   
07-08-05 13:47 jdthood        Status                   resolved => closed  
07-08-05 13:47 jdthood        Note Added: 0005422                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
