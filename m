From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001221]: DXS channels not available in alsamixer anymore
Date: Thu, 30 Jun 2005 11:05:24 +0200
Message-ID: <82cb04337292c443f84b474cc14c3175@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBD2F192
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2005 11:05:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1221> 
======================================================================
Reported By:                honzik666
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1221
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.12.1
======================================================================
Date Submitted:             06-30-2005 11:05 CEST
Last Modified:              06-30-2005 11:05 CEST
======================================================================
Summary:                    DXS channels not available in alsamixer anymore
Description: 
I've updated from 2.6.11.7 to 2.6.12.1 kernel version and now the DXS
channels are not available in the mixer anymore. 

I made a diff between via82xx.c in both kernels, but there are too many
changes between those two versions to understand what is going on. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-30-05 11:05 honzik666      New Issue                                    
06-30-05 11:05 honzik666      Distribution              => Debian          
06-30-05 11:05 honzik666      Kernel Version            => 2.6.12.1        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
