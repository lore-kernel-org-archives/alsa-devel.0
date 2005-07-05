From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001233]: Please move aserver to alsa-utils
Date: Tue, 5 Jul 2005 11:36:38 +0200
Message-ID: <6fc46c844dd10e074325ec1d7b65586d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC44C1CE
	for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2005 11:36:38 +0200 (MEST)
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
Status:                     new
======================================================================
Date Submitted:             07-05-2005 11:36 CEST
Last Modified:              07-05-2005 11:36 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-05-05 11:36 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
